<%--
    Document   : form_login
    Created on : 12/08/2025
    Author     : Tiago
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">
<html lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="stylesheet" href="css/login.css"/>
        <title>Login</title>
    </head>
<body>
    
    <%
        String mensagem = (String) request.getSession().getAttribute("mensagem");
        if(mensagem != null){
    %>
            <div style="position: absolute; top: 10px; width: 100%; text-align: center; z-index: 100;">
                <div style="background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; padding: 10px; border-radius: 5px; display: inline-block;">
                    <%=mensagem%>
                </div>
            </div>
    <%
            request.getSession().removeAttribute("mensagem");
        }
    %>
    
    <main class="container">
        <h1 class="titulo"> Cantina Tia Lais </h1>
        <h1 class="titulo">Sabores Saudavéis </h1>
        <h2 class="subtitulo">Seja bem-vindo(a)!</h2>
        <h3 class="subtitulo">Para acessar o site, faça o login:</h3>

        <form action="gerenciar_login.do" method="post">
            
            <h2 class="formulario">Digite o seu login:</h2>
            <div class="input-box">
                <input type="text" name="login" placeholder="Login" required>
                <i class='bx bx-user'></i> 
            </div>
            
            <h2 class="formulario">Digite a sua senha:</h2>
            <div class="input-box">
                <input type="password" name="senha" placeholder="Senha" required>
                <i class='bx bx-lock-alt'></i>  
            </div>
            
            <div class="input-box">
                <input type="submit" value="Entrar">
            </div>
            <div class="input-box">
                <input type="reset" value="Limpar">
            </div>
        </form>
    </main>
    
    </body>
</html>