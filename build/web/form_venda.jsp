<%-- 
    Document   : index
    Created on : 12/08/2025, 21:29:37
    Author     : adm_pfelacio
--%>

<%@page import="modelo.Cliente"%>
<%@page import="modelo.Venda"%>
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
        <title>Cadastrar Venda</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <!--Menu de navegação -->
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <h2>Cadastrar Venda</h2>
            <div class="form-container">
                <%
                    Venda v = new Venda();
                    Cliente c = new Cliente();
                    
                    try{
                        v = (Venda) session.getAttribute("venda");
                    }catch(Exception e){
                        out.print(e);
                    }
                    
                %>
                <br><br>
                Vendedor: <%=v.getVendedor().getNome_RazaoSocial()%><br><br>
                Cliente: <%=v.getCliente().getNome_RazaoSocial()%>
                <h4> Catalogo: (<%=v.getCarrinho().size()%> Itens no Carrinho)</h4>
                <jsp:useBean class="modelo.ProdutoDAO" id="produto"/>
                <c:forEach var="p" items="${produto.lista}">
                <c:if test="${p.status != 2}">
                    <div id="prod${p.idProduto}">
                        <form method="get" action="gerenciar_venda.do">
                            <input type="hidden" name="acao" id="acao" value="AdicionarProduto"/>
                            <input type="hidden" name="idProduto" id="idProduto" value="${p.idProduto}"/>
                            
                            ${p.nome}
                            <input type="number" name="quantidade" id="quantidade" required="" value="1" style="width: 40px;"
                                    value=""/>
                            <button class="btn btn-default">
                                <img src="imagens/carrinho.png" width="20px" height="20px">
                            </button>
                        </form>
                    </div>
                </c:if>
                </c:forEach>
                <div class="row">
                    <a href="gerenciar_cliente.do?acao=listarTodos" class="btn btn-warning">Cancelar</a>
                    <a href="form_visualizar_carrinho.jsp" class="btn btn-success">Carrinho</a>
                </div>  
                
            </div>
            
            
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

