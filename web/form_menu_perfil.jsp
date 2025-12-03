<%-- 
    Document   : form_menu_perfil
    Created on : 25/09/2025, 20:12:35
    Author     : 377457
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="bootstrap/css/bootstrap-theme.min.css"/>
        <link rel="stylesheet" href="datatables/jquery.dataTables.min.css"/>
        <link rel="stylesheet" href="css/estilo.css"/>
        <script type="text/javascript">
            function confirmarExclusao(idMenu, nome,idPerfil){
                
                if(confirm('Deseja realmente desvincular o menu '+nome+'?')){
                    window.open("gerenciar_menu_perfil.do?acao=desvincular&idMenu="+idMenu+'&idPerfil='+idPerfil,"_self");
                }
                
            }
        </script>    
        <title>Vinvular e Desvincular Menus</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <!--Menu de navegação -->
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <form method="POST" action="gerenciar_menu_perfil.do">
                    <legend>Formulário de Menu Perfil</legend>
                    <!-- ID e status oculto -->
                    <input type="hidden" name="idPerfil" id="idPerfil" value="${perfil.idPerfil}"/>
                    
                    
                    <label for="nome">Perfil:${perfil.nome}</label>
                    
                    
                    <label for="idMenu">Menu Desvinculados</label>
                    <select name="idMenu" required="">
                        <option value="0">Selecione o menu</option>
                        <c:forEach items="${perfil.menus.menusNaoVinculados}" var="m">
                            <option value="${m.idMenu}">${m.nome}</option>
                        </c:forEach>
                    </select>
                    
                    <!-- botoes-->
                    <div class="form button form">
                        <button type="submit" class="btn btn-success">Vincular</button>
                        <a href="gerenciar_perfil.do?acao=listarTodos" 
                           class="btn btn-warning">Voltar</a>
                    </div>             
            </form>
            <h2>Menus Vinculados</h2>
            <table class="table table-hover table-striped table-bordered display" id="listarMenu">
            
                <thead>
                    <tr>
                        <th>idMenu</th>
                        <th>Nome do Menu</th>
                        <th>Link</th>
                        <th>Exibir</th>
                        <th>Desvincular</th>
                    </tr>
                </thead>
                 <tfoot>
                    <tr>
                       <th>idMenu</th>
                        <th>Nome do Menu</th>
                        <th>Link</th>
                        <th>Exibir</th>
                        <th>Desvincular</th>
                    </tr>
                </tfoot>
                <tbody>
                    <c:if test="${not empty perfil.menus.menusVinculados}">
                        <c:forEach var="m" items="${perfil.menus.menusVinculados}">
                            <tr>
                                <td>${m.idMenu}</td> 
                                <td>${m.nome}</td>
                                <td>${m.link}</td>
                                <td><c:if test="${m.exibir==1}">Sim</c:if>
                                    <c:if test="${m.exibir==2}">Não</c:if>
                                </td>
                                <td>
                                    <button class="btn btn-danger" onclick="confirmarExclusao(${m.idMenu},'${m.nome}',${perfil.idPerfil})">
                                        <i class="glyphicon glyphicon-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </tbody>
            </table>    
            
            
        </div> 
        <script type="text/javascript" src="datatables/jquery.js"></script>
        <script type="text/javascript" src="datatables/jquery.dataTables.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#listarMenu").DataTable({
                    "language":{
                    "url": "datatables/portugues.json"     
                    }
                });
            });
        
        <!-- ativar menu responsivo-->
        
            function toggleMenu(){
                var menu = document.getElementById("nav-links");
                menu.classList.toggle("show");
            }
        </script>    
        
    </body>
</html>



