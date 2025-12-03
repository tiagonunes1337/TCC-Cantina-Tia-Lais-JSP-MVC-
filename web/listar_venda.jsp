<%-- 
    Document   : index
    Created on : 12/08/2025, 21:29:37
    Author     : adm_pfelacio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            function confirmarDesativar(idVendas, nome_RazaoSocial){
                if(confirm('Deseja realmente cancelar a venda do cliente '+nome_RazaoSocial+'?')){
                    window.open("gerenciar_venda.do?acao=desativar&idVendas="+idVendas,"_self");
                } 
            }
            function confirmarFinalizar(idVendas, nome_RazaoSocial){
                if(confirm('Deseja realmente finalizar a venda do cliente '+nome_RazaoSocial+'?')){
                    window.open("gerenciar_venda.do?acao=finalizar&idVendas="+idVendas,"_self");
                } 
            }
        </script>    
        <title>Listar Vendas</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <!--Menu de navegação -->
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <h2>Listar Venda</h2>
            <a href="gerenciar_cliente.do?acao=listarTodos" class="btn btn-primary">Nova Venda</a>
            <table class="table table-hover table-striped table-bordered display" id="listarVenda">
            
                <thead>
                    <tr>
                        <th>idVenda</th>
                        <th>Vendedor</th>
                        <th>Cliente</th>
                        <th>Data da Venda</th>
                        <th>Total da Venda</th>
                        <th>Status</th>
                        <th>Opções</th>
                    </tr>
                </thead>
                 <tfoot>
                    <tr>
                        <th>idVenda</th>
                        <th>Vendedor</th>
                        <th>Cliente</th>
                        <th>Data da Venda</th>
                        <th>Total da Venda</th>
                        <th>Status</th>
                        <th>Opções</th>
                    </tr> 
                </tfoot>
                <tbody>
                    <fmt:setLocale value="pt_BR" scope="session"/>
                    <c:set var="listaDeVendas" value="${listarVendaPorCliente != null ? listarVendaPorCliente : listarTodos}" />
                    <c:forEach var="v" items="${listaDeVendas}">
                        <tr>
                            <td>${v.idVendas}</td> 
                            <td>${v.vendedor.nome_RazaoSocial}</td>
                            <td>${v.cliente.nome_RazaoSocial}</td>
                            <td><fmt:formatDate pattern="dd/MM/yyyy" value="${v.dataVenda}"/></td>
                            <td><fmt:formatNumber value="${v.total}" type="currency"/></td>                            
                            <td><c:if test="${v.status==1}">Em Preparação</c:if>
                                <c:if test="${v.status==2}">Cancelada</c:if>
                                <c:if test="${v.status==3}">Finalizada</c:if>
                            </td>
                            <td>
    <c:if test="${v.status == 1}">
        
        <a class="btn btn-warning" href="gerenciar_venda.do?acao=alterar&idVendas=${v.idVendas}">
            <i class="glyphicon glyphicon-pencil"></i>
        </a>

        <button class="btn btn-danger" onclick="confirmarDesativar(${v.idVendas})">
            <i class="glyphicon glyphicon-trash"></i>
        </button>
        
        <a class="btn btn-success" href="gerenciar_venda.do?acao=finalizar&idVendas=${v.idVendas}">
             <i class="glyphicon glyphicon-ok"></i>
        </a>
        
    </c:if>

    <c:if test="${v.status != 1}">
        <span class="badge" style="background-color: gray;">
            <i class="glyphicon glyphicon-lock"></i> Bloqueado
        </span>
    </c:if>
</td>
                        </tr>
                        
                       
                        
                    </c:forEach>
                    
                </tbody>
            
            </table>    
            
            
        </div> 
        <script type="text/javascript" src="datatables/jquery.js"></script>
        <script type="text/javascript" src="datatables/jquery.dataTables.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#listarVenda").DataTable({
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


