<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Golden Login</title>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<style>
    *{ 
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }

    body{
        margin: 0;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;

        background: radial-gradient(circle at top, #5f4b22, #000000 70%);
        color: #fff;
        overflow: hidden;
    }

    /* 반짝이는 금빛 애니메이션 */
    .glow{
        position: absolute;
        width: 400px;
        height: 400px;
        background: radial-gradient(circle, rgba(255,215,0,0.4), transparent 70%);
        filter: blur(30px);
        animation: move 6s infinite linear;
        opacity: .5;
    }

    .glow:nth-child(1){ top: 10%; left: 20%; }
    .glow:nth-child(2){ bottom: 10%; right: 15%; animation-delay: 2s; }
    .glow:nth-child(3){ top: 50%; right: 40%; animation-delay: 4s; }

    @keyframes move{
        0%{ transform: translateY(-20px); }
        50%{ transform: translateY(20px); }
        100%{ transform: translateY(-20px); }
    }

    .login-box{
        width: 460px;
        padding: 45px 40px;
        background: rgba(0,0,0,0.35);
        border-radius: 20px;

        border: 1px solid rgba(255,215,0,0.28);
        box-shadow: 
            0 0 20px rgba(255,215,0,0.2),
            inset 0 0 25px rgba(255,215,0,0.15);

        backdrop-filter: blur(14px);
        position: relative;
        z-index: 10;
        animation: fadeIn .8s ease-in-out;
    }

    @keyframes fadeIn{
        from{ opacity: 0; transform: translateY(20px);}
        to{ opacity: 1; transform: translateY(0);}
    }

    .login-title{
        text-align: center;
        font-size: 28px;
        margin-bottom: 10px;
        font-weight: 700;
        background: linear-gradient(135deg, #fff7c2, #ffda5c, #fff2a0);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .sub{
        text-align: center;
        opacity: .8;
        margin-bottom: 25px;
        font-size: 14px;
    }

    .input-group{
        margin-bottom: 18px;
        width: 100%;
    }

    .input-group label{
        display: block;
        margin-bottom: 6px;
        font-size: 13px;
        opacity: .9;
    }

    .input-group input{
        width: 100%;
        padding: 13px 14px;
        border-radius: 12px;
        border: 1px solid rgba(255,215,0,0.35);
        outline: none;
        background: rgba(0,0,0,0.35);
        color: #fff;
        font-size: 14px;
        transition: .2s;
    }

    .input-group input:focus{
        background: rgba(0,0,0,0.55);
        box-shadow: 0 0 12px rgba(255,215,0,0.4);
    }

    .login-btn{
        width: 100%;
        padding: 13px;
        border-radius: 12px;
        border: none;
        cursor: pointer;

        background: linear-gradient(135deg,#ffbf00,#ffea8c,#ffbf00);
        background-size: 200% 200%;
        animation: shine 4s infinite linear;

        color: #000;
        font-weight: 700;
        margin-top: 10px;
        transition: .2s;
    }

    @keyframes shine{
        0%{ background-position: 0% 50%;}
        50%{ background-position: 100% 50%;}
        100%{ background-position: 0% 50%;}
    }

    .login-btn:hover{
        transform: scale(1.03);
        box-shadow: 
            0 10px 40px rgba(255,215,0,0.4),
            inset 0 0 10px rgba(255,255,255,0.4);
    }

    .error-msg, .logout-msg{
        padding: 10px 12px;
        border-radius: 12px;
        margin-bottom: 15px;
        font-size: 13px;
    }

    .error-msg{
        background: rgba(255,0,0,0.25);
    }

    .logout-msg{
        background: rgba(0,160,0,0.35);
    }

    .footer{
        text-align: center;
        margin-top: 22px;
        opacity: .7;
        font-size: 12px;
    }

</style>
</head>
<body>

<div class="glow"></div>
<div class="glow"></div>
<div class="glow"></div>

<div class="login-box">

    <div class="login-title">Golden Gate Login ✨</div>
    <div class="sub">빛나는 당신을 위한 프리미엄 로그인</div>

    <c:if test="${param.error != null}">
        <div class="error-msg">
            😢 아이디 또는 비밀번호가 올바르지 않습니다.
        </div>
    </c:if>

    <c:if test="${param.logout != null}">
        <div class="logout-msg">
            👋 안전하게 로그아웃 되었습니다.
        </div>
    </c:if>

    <form method="post" action="<c:url value='/account/login'/>">

        <div class="input-group">
            <label>아이디</label>
            <input type="text" name="username" placeholder="아이디를 입력하세요" required />
        </div>

        <div class="input-group">
            <label>비밀번호</label>
            <input type="password" name="password" placeholder="비밀번호를 입력하세요" required />
        </div>
        
          <!-- ✅ remember-me 추가 -->
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" name="remember-me" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">
                        로그인 상태 유지
                    </label>
                </div>

        <sec:csrfInput/>

        <button class="login-btn" type="submit">
            LOGIN NOW ✨
        </button>

    </form>

    <div class="footer">
        © 2025 — Shine Like Gold ⚜
    </div>

</div>

</body>
</html>
