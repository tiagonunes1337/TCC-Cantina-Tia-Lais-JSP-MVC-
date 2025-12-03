<%-- 
    Document   : index
    Created on : 12/08/2025, 21:29:37
    Author     : adm_pfelacio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <fmt:setLocale value="pt_BR" scope="session"/>
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
        <title>Cadastrar Produto</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <!--Menu de navegação -->
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <h2>Cadastrar Produto</h2>
            <div class="form-container">
                <form method="POST" action="gerenciar_produto.do">
                    <legend>Formulário de Produto</legend>
                    <!-- ID oculto -->
                    <input type="hidden" name="idProduto" id="idProduto" value="${produto.idProduto}"/>
                    
                    
                    <label for="nome">Nome do Produto </label>
                    <input type="text" name="nome" id="nome" required="" 
                           maxlength="100" value="${produto.nome}"/>
                    
                    <label for="quantidade">Quantidade</label>
                    <input type="text" name="quantidade" id="quantidade" required="" 
                           maxlength="100" value="${produto.quantidade}"/>
                    
                    <label for="valorUnitario">Valor (Unitario)</label>
                    <input type="text" name="valorUnitario" id="valorUnitario" required="" 
                           maxlength="100" value="<fmt:formatNumber value='${produto.valorUnitario}' type='currency'/>"/>
                           
                    
                    <label for="Fornecedor">Fornecedor</label>
                    <select name="idFornecedor" id="idFornecedor" required="">
                        <option value="">Selecione o Fornecedor</option>
                        <jsp:useBean class="modelo.FornecedorDAO" id="fornecedor"/>
                        <c:forEach var="f" items="${fornecedor.lista}">
                            <option value="${f.idFornecedor}"
                                <c:if test="${f.idFornecedor==produto.fornecedor.idFornecedor}">
                                    selected=""
                                </c:if>>${f.nome_RazaoSocial}</option> 
                        </c:forEach>
                    </select>
        <br>
                    <label for="status">Status</label>
                    <select name="status" required="">
                        <c:if test="${produto.status==null}">  
                            <option value="0">Escolha uma opção</option>
                            <option value="1">Ativo</option>
                            <option value="2">Inativo</option>
                        </c:if>
                        <c:if test="${produto.status==1}">
                            <option value="1" selected="">Ativo</option>
                            <option value="2">Inativo</option>
                        </c:if> 
                        <c:if test="${produto.status==2}">
                            <option value="1">Ativo</option>
                            <option value="2" selected="">Inativo</option>
                        </c:if>    
                    </select>
                    
                    <!-- botoes-->
                    <div class="form button form">
                        <button type="submit" class="btn btn-success">Gravar</button>
                        <a href="gerenciar_produto.do?acao=listarTodos" 
                           class="btn btn-warning">Voltar</a>
                    </div>
                         
                </form>
            </div>  
            
            
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



