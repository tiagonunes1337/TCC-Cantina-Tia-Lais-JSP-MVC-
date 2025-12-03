
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
        <title>Resultados do Relatório de Vendas</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <h2>Resultados do Relatório</h2>
            
            <a href="gerenciar_relatorio.do" class="btn btn-primary">Voltar ao Filtro</a>
            
            <table class="table table-hover table-striped table-bordered display" id="tabelaRelatorio">
                <thead>
                    <tr>
                        <th>ID Venda</th>
                        <th>Vendedor (Usuário)</th>
                        <th>Cliente</th>
                        <th>Data da Venda</th>
                        <th>Total da Venda</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th>ID Venda</th>
                        <th>Vendedor (Usuário)</th>
                        <th>Cliente</th>
                        <th>Data da Venda</th>
                        <th>Total da Venda</th>
                        <th>Status</th>
                    </tr>
                </tfoot>
                <tbody>
                    <c:forEach var="v" items="${vendasFiltradas}">
                        <tr>
                            <td>${v.idVendas}</td>
                            <td>${v.vendedor.nome_RazaoSocial}</td> 
                            <td>${v.cliente.nome_RazaoSocial}</td>
                            <td><fmt:formatDate pattern="dd/MM/yyyy" value="${v.dataVenda}"/></td>
                            <td>R$ <fmt:formatNumber value="${v.total}" pattern="#,##0.00"/></td> 
                            <td>
                                <c:if test="${v.status==1}">Em Preparação</c:if>
                                <c:if test="${v.status==2}">Cancelada</c:if>
                                <c:if test="${v.status==3}">Finalizada</c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty vendasFiltradas}">
                         <tr>
                            <td colspan="6">Nenhum registro encontrado para o período selecionado.</td>
                         </tr>
                    </c:if>
                </tbody>
            </table>    
        </div> 
        
        <script type="text/javascript" src="datatables/jquery.js"></script>
        <script type="text/javascript" src="datatables/jquery.dataTables.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#tabelaRelatorio").DataTable({
                    "language":{ "url": "datatables/portugues.json" }
                });
            });
            function toggleMenu(){
                var menu = document.getElementById("nav-links");
                menu.classList.toggle("show");
            }
        </script>    
    </body>
</html>
