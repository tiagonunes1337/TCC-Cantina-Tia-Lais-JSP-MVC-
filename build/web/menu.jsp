<%@page import="controller.GerenciarLogin"%>
<%@page import="modelo.Usuario"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Usuario ulogado = GerenciarLogin.verificarAcesso(request, response);
    request.setAttribute("ulogado", ulogado);
%>
<nav>
    <div class="menu-icon" onclick="toggleMenu()">&#9776</div>
    <ul style="font-weight: bold" id="nav-links">
        <c:if test="${ulogado!=null && ulogado.perfil!=null}">
            
            <c:forEach var="menu" items="${ulogado.perfil.menus.menusVinculados}">
                <c:if test="${menu.exibir==1}">                
                    <li><a href="${menu.link}">${menu.nome}</a></li>
                </c:if>
            </c:forEach>
        </c:if>
        <%--<li><a href="index.jsp">Home</a></li>
        <li><a href="gerenciar_perfil.do?acao=listarTodos">Perfil</a></li>
        <li><a href="gerenciar_menu.do?acao=listarTodos">Menus</a></li>
        <li><a href="gerenciar_usuario.do?acao=listarTodos">Usuários</a></li>
        <li><a href="gerenciar_fornecedor.do?acao=listarTodos">Fornecedores</a></li>
        <li><a href="gerenciar_produto.do?acao=listarTodos">Produtos</a></li>*/--%>
    </ul>
</nav>
    <div class="pull-right">
        Bem-Vindo, <c:if test="${ulogado!=null}">${ulogado.nome_RazaoSocial}</c:if>
        <a href="gerenciar_login.do"> Sair</a>
    </div>