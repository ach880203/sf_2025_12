package org.zerock.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
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

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        log.info("SECURITY CONFIG");
        
        //1. 권한 정책  공개 영역 설정 
        http.authorizeHttpRequests(config -> {
        	
        	//정적 리소스
        	config.requestMatchers(
        			new AntPathRequestMatcher("/rsources/**"),
        			 new AntPathRequestMatcher("/css/**"),
        			 new AntPathRequestMatcher("/js/**"),
        			 new AntPathRequestMatcher("/images/**")
        			).permitAll();
        	
        	//공개 영역
        	config.requestMatchers(
        			 new AntPathRequestMatcher("/"),
        			 new AntPathRequestMatcher("/community/**"),
        			 new AntPathRequestMatcher("/account/login")
        			).permitAll();
        	
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
                  .successHandler(new CustomLoginSuccessHandler());
        });
        
        // 3. 아이디 기억
        http.rememberMe(config ->{
        	config.key("my-key");
        	config.tokenRepository(persistentTokenRepository());
        	config.tokenValiditySeconds(60*60*24*30);
        });
        
        // 4. 로그아웃
        http.logout(config -> {
        	config.deleteCookies("JSESSIONID", "remember-me");
            config.logoutUrl("/account/doLogout");  // 🔥 POST 로그아웃 URL
            config.logoutSuccessUrl("/account/login?logout");  // 🔥 완료 페이지
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