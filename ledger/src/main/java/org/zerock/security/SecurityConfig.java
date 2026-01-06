package org.zerock.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import lombok.extern.log4j.Log4j2;

@Configuration
@Log4j2
@EnableWebSecurity
public class SecurityConfig {
	
	@Autowired
	private DataSource dataSource;
	
	@Autowired
    private UserDetailsService userDetailsService;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

    	try (var con = dataSource.getConnection()) {
    		  var md = con.getMetaData();
    		  log.info("JDBC url={}", md.getURL());
    		  log.info("JDBC user={}", md.getUserName());

    		  try (var ps = con.prepareStatement("SELECT DATABASE(), @@hostname, @@port");
    		       var rs = ps.executeQuery()) {
    		    if (rs.next()) {
    		      log.info("DB={}/host={}/port={}", rs.getString(1), rs.getString(2), rs.getString(3));
    		    }
    		  }
    		}

    	
        log.info("SECURITY CONFIG");
        
        //1. 권한 정책  공개 영역 설정 
        http.authorizeHttpRequests(config -> {
        	
        	//정적 리소스
        	config.requestMatchers(
        			new AntPathRequestMatcher("/resources/**"),
        			 new AntPathRequestMatcher("/css/**"),
        			 new AntPathRequestMatcher("/js/**"),
        			 new AntPathRequestMatcher("/images/**")
        			).permitAll();
        	
        	//공개 영역
        	config.requestMatchers(
        			 new AntPathRequestMatcher("/"),
        			 new AntPathRequestMatcher("/index.jsp"),
        			 new AntPathRequestMatcher("/home"),
        			 new AntPathRequestMatcher("/account/login"),
        			 new AntPathRequestMatcher("/community/list"),
        			 new AntPathRequestMatcher("/community/read/**"),
        			 new AntPathRequestMatcher("/community/read")
        			).permitAll();
        	
        	//댓글 보기는 가능, 작성,삭제,수정은로그인
        	config.requestMatchers( new AntPathRequestMatcher("/replies/**")        			
        			).authenticated();
        	
        	//개인 가계부
        	config.requestMatchers(
        			 new AntPathRequestMatcher("/ledger/**")
        			).authenticated();

        	//그 외의 로그인 필요
        	config.anyRequest().authenticated();
       	});

        // 2. 로그인
        http.formLogin(config -> {
            config.loginPage("/account/login")
                  .loginProcessingUrl("/account/login")
                  .successHandler(new CustomLoginSuccessHandler())
                  .permitAll();
        });
        
        // 3. 아이디 기억
        
        
        http.rememberMe(config ->{
        	config.key("my-key");
        	config.userDetailsService(userDetailsService);
        	config.tokenRepository(persistentTokenRepository());
        	config.tokenValiditySeconds(60 * 60 * 24 * 30);
        });
        
        // 4. 로그아웃
		/*
		 * http.logout(config -> { config.deleteCookies("JSESSIONID", "remember-me");
		 * config.logoutUrl("/account/doLogout"); // 🔥 POST 로그아웃 URL
		 * config.logoutSuccessUrl("/account/login?logout"); // 🔥 완료 페이지 });
		 */
        http.logout(config -> {
            config.deleteCookies("JSESSIONID", "remember-me");
            config.logoutRequestMatcher(new AntPathRequestMatcher("/account/logout", "GET")); // 지금 a태그니까 GET
            config.logoutSuccessUrl("/home");
        });

        
        //5. 예외 처리
        http.exceptionHandling(config ->
        	config.accessDeniedHandler(new Custom403Handler())
   		);
        
        http.csrf(config -> config.disable()); // (나중엔 켜자 🔐)

        return http.build();
    }
    
    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
    	JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
    	tokenRepository.setDataSource(dataSource);
    	
    	return tokenRepository;
    }

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }
}