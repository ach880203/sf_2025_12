<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout Completed</title>

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

        background: radial-gradient(circle at top, #5c4518, #000000 70%);
        color: #fff;
        overflow: hidden;
    }

    .glow{
        position: absolute;
        width: 450px;
        height: 450px;
        background: radial-gradient(circle, rgba(255,215,0,0.35), transparent 70%);
        filter: blur(30px);
        animation: float 7s infinite linear;
        opacity: .5;
    }

    .glow:nth-child(1){ top: 5%; left: 10%; }
    .glow:nth-child(2){ bottom: 8%; right: 15%; animation-delay: 1.5s; }
    .glow:nth-child(3){ top: 55%; right: 35%; animation-delay: 3s; }

    @keyframes float{
        0%{ transform: translateY(-25px); }
        50%{ transform: translateY(25px); }
        100%{ transform: translateY(-25px); }
    }

    .box{
        width: 520px;
        padding: 50px;
        text-align: center;

        background: rgba(0,0,0,0.35);
        border-radius: 22px;

        border: 1px solid rgba(255,215,0,0.3);
        box-shadow:
            0 0 25px rgba(255,215,0,0.25),
            inset 0 0 25px rgba(255,215,0,0.14);

        backdrop-filter: blur(14px);
        z-index: 10;
        animation: fadeIn .8s ease-in-out;
    }

    @keyframes fadeIn{
        from{ opacity: 0; transform: translateY(25px);}
        to{ opacity: 1; transform: translateY(0);}
    }

    .title{
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 12px;

        background: linear-gradient(135deg,#fff7c2,#ffea8c,#ffbf00);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .msg{
        margin-bottom: 30px;
        opacity: .92;
        line-height: 1.6rem;
    }

    .btn-area{
        display: flex;
        justify-content: center;
        gap: 14px;
    }

    .gold-btn{
        padding: 12px 22px;
        border-radius: 12px;
        border: none;
        cursor: pointer;

        background: linear-gradient(135deg,#ffbf00,#ffea8c,#ffbf00);
        background-size: 200% 200%;
        animation: shine 4s infinite linear;

        color: #000;
        font-weight: 700;
        transition: .2s;
        text-decoration: none;
        display: inline-block;
    }

    .outline-btn{
        padding: 12px 22px;
        border-radius: 12px;
        border: 1px solid rgba(255,215,0,0.4);
        background: transparent;
        color: #ffec9f;
        font-weight: 600;
        text-decoration: none;
        transition: .2s;
    }

    @keyframes shine{
        0%{ background-position: 0% 50%;}
        50%{ background-position: 100% 50%;}
        100%{ background-position: 0% 50%;}
    }

    .gold-btn:hover{
        transform: scale(1.05);
        box-shadow:
            0 10px 40px rgba(255,215,0,0.4),
            inset 0 0 12px rgba(255,255,255,0.4);
    }

    .outline-btn:hover{
        background: rgba(255,255,255,0.08);
    }

    .footer{
        margin-top: 25px;
        opacity: .7;
        font-size: 12px;
    }

</style>
</head>
<body>

<div class="glow"></div>
<div class="glow"></div>
<div class="glow"></div>

<div class="box">

    <div class="title">Logout Completed ✨</div>

    <div class="msg">
        안전하게 로그아웃 되었습니다.<br/>
        잠시 숨 고르고, 다시 또 만나요 😊
    </div>

    <div class="btn-area">
        <a href="<c:url value='/account/login'/>" class="gold-btn">
            로그인 다시하기
        </a>

        <a href="<c:url value='/'/>" class="outline-btn">
            홈으로 가기
        </a>
    </div>

    <div class="footer">
        © 2025 — Shine Like Gold ⚜
    </div>

</div>

</body>
</html>
