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
            function confirmarDesativar(idProduto, nome){
                
                if(confirm('Deseja realmente desativar o produto '+nome+'?')){
                    window.open("gerenciar_produto.do?acao=desativar&idProduto="+idProduto,"_self");
                }
                
            }
        </script>    
        <title>Listar Produto</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <!--Menu de navegação -->
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <h2>Listar Produtos</h2>
            <a href="form_produto.jsp" class="btn btn-primary">Novo Produto</a>
            <table class="table table-hover table-striped table-bordered display" id="listarProduto">
            
                <thead>
                    <tr>
                        <th>idProduto</th>
                        <th>Nome do Produto</th>
                        <th>Quantidade(em estoque)</th>
                        <th>Valor(Unitario)</th>
                        <th>Fornecedor</th>
                        <th>Status</th>
                        <th>Opções</th>
                    </tr>
                </thead>
                 <tfoot>
                    <tr>
                        <th>idProduto</th>
                        <th>Nome do Produto</th>
                        <th>Quantidade(em estoque)</th>
                        <th>Valor (Unitario)</th>
                        <th>Fornecedor</th>
                        <th>Status</th>
                        <th>Opções</th>
                    </tr>
                </tfoot>
                <tbody>
                    <fmt:setLocale value="pt_BR" scope="session"/> <%-- Formatação para Real--%>
                    <c:forEach var="p" items="${listarTodos}">
                        <tr>
                            <td>${p.idProduto}</td> 
                            <td>${p.nome}</td>
                            <td>${p.quantidade}</td>
                            <td><fmt:formatNumber value="${p.valorUnitario}" type="currency"/></td>
                            <td>${p.fornecedor.nome_RazaoSocial}</td>
                            <td><c:if test="${p.status==1}">Ativo</c:if>
                                <c:if test="${p.status==2}">Inativo</c:if>
                            </td>
                            <td>
                                <a class="btn btn-warning" href="gerenciar_produto.do?acao=alterar&idProduto=${p.idProduto}">
                                    <i class="glyphicon glyphicon-pencil"></i>
                                </a>
                                <button class="btn btn-danger" onclick="confirmarDesativar(${p.idProduto},'${p.nome}')">
                                    <i class="glyphicon glyphicon-trash"></i>
                                </button>
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
                $("#listarProduto").DataTable({
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


