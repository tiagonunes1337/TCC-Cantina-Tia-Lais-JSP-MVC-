<%-- 
    Document   : listar_estoque
    Created on : 20/11/2025
    Author     : Tiago
--%>

<%-- listar_estoque.jsp (Simplificado) --%>
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
        <title>Relatório de Estoque</title>
    </head>
    <body>
        <div class="banner"><%@include file="banner.jsp" %></div>
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <h2>Relatório de Saldo em Estoque</h2>
            
            <table class="table table-striped table-hover display" id="tabelaEstoque">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Produto</th>
                        <th>Fornecedor</th>
                        <th>Qtd Atual</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${listaEstoque}">
                        <tr>
                            <td>${p.idProduto}</td>
                            <td>${p.nome}</td>
                            <%-- Certifique-se que seu ProdutoDAO carrega o Fornecedor --%>
                            <td>${p.fornecedor.nome_RazaoSocial}</td>
                            
                            <td style="font-weight: bold; color: ${p.quantidade < 10 ? 'red' : 'green'}">
                                ${p.quantidade}
                            </td>
                            
                                    <td style="font-weight: bold;">
                                        <c:choose>
                                            <%-- 1. Verifica se o produto está Desativado (Status = 2) --%>
                                            <c:when test="${p.status == 2}">
                                                <span style="color: #666;">Indisponível (Desativado)</span>
                                            </c:when>
                                            <%-- 2. Se não estiver desativado, verifica se a Quantidade é > 0 --%>
                                            <c:when test="${p.quantidade > 0}">
                                                <span style="color: green;">Disponível</span>
                                            </c:when>
                                            <%-- 3. Caso contrário (Qtd <= 0 e Status != 2) --%>
                                            <c:otherwise>
                                                <span style="color: darkorange;">Esgotado</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>    
        </div>
        <div class="content">
        <h2>Relatório de Saldo em Estoque</h2>
    
        <a href="gerenciar_estoque.do?acao=gerarPDF" class="btn btn-danger" target="_blank">
        <i class="glyphicon glyphicon-file"></i> Baixar PDF
        </a>
    
        <table class="table table-striped" id="tabelaEstoque">
        </table>    
        </div>
        <script src="datatables/jquery.js"></script>
         <script src="datatables/jquery.dataTables.min.js"></script>
         <script>
            $(document).ready(function(){
                $("#tabelaEstoque").DataTable({ "language":{ "url": "datatables/portugues.json" } });
            });
            function toggleMenu(){ /* ... */ }
        </script>
    </body>
</html>