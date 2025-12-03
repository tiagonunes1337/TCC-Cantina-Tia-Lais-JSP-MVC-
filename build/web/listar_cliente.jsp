<%-- 
    Document   : listar_cliente
    Created on : 01/10/2025, 20:54:52
    Author     : 377457
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
            function confirmarDesativar(idCliente, nome_RazaoSocial){
                
                if(confirm('Deseja realmente desativar o cliente '+nome_RazaoSocial+'?')){
                    window.open("gerenciar_cliente.do?acao=desativar&idCliente="+idCliente,"_self");
                }
                
            }
        </script>    
        <title>Listar Cliente</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <!--Menu de navegação -->
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <h2>Listar Clientes</h2>
            <a href="form_cliente.jsp" class="btn btn-primary">Novo Cliente</a>
            <table class="table table-hover table-striped table-bordered display" id="listarCliente">
            
                <thead>
                    <tr>
                        <th>idCliente</th>
                        <th>Nome do Cliente</th>
                        <th>Tipo de Cliente</th>
                        <th>CPF/CNPJ</th>
                        <th>Status</th>
                        <th>Opções</th>
                    </tr>
                </thead>
                 <tfoot>
                    <tr>
                        <th>idCliente</th>
                        <th>Nome do Cliente</th>
                        <th>Tipo de Cliente</th>
                        <th>CPF/CNPJ</th>
                        <th>Status</th>
                        <th>Opções</th>
                    </tr>
                </tfoot>
                <tbody>
                    <c:forEach var="c" items="${listarTodos}">
                        <tr>
                            <td>${c.idCliente}</td> 
                            <td>${c.nome_RazaoSocial}</td>
                            <td><c:if test="${c.tipo==1}">Pessoa Física</c:if>
                                <c:if test="${c.tipo==2}">Pessoa Jurídica</c:if>
                            </td>
                            <td>${c.CPF_CNPJ}</td>
                            <td><c:if test="${c.status==1}">Ativo</c:if>
                                <c:if test="${c.status==2}">Inativo</c:if>
                            </td>
                            <td>
                                <a class="btn btn-warning" href="gerenciar_cliente.do?acao=alterar&idCliente=${c.idCliente}">
                                    <i class="glyphicon glyphicon-pencil"></i>
                                </a>
                                <button class="btn btn-danger" onclick="confirmarDesativar(${c.idCliente},'${c.nome_RazaoSocial}')">
                                    <i class="glyphicon glyphicon-trash"></i>
                                </button>
                                    
                                <a href="gerenciar_venda.do?acao=novaVenda&idCliente=${c.idCliente}" class="brn btn-primary">
                                    <i class="glyphicon glyphicon"> Realizar Venda</i>
                                </a>
                                <a href="gerenciar_venda.do?acao=listarVendaPorCliente&idCliente=${c.idCliente}" class="brn btn-success">
                                    <i class="glyphicon glyphicon"> Verificar Venda</i>
                                </a>
                            </td>
                        </tr>
                        
                       
                        
                    </c:forEach>
                    
                </tbody>
            
            </table>    
            
            
        </div> 
        <script type="text/javascript" src="datatables/jquery.js"></script>
        <script type="text/javascript" src="datatables/jquery.dataTables.min.js"></script>
        <script type="text/javascript">
            function formatarCpfCnpj(numero) {
    if (numero) {
        numero = String(numero).replace(/\D/g, ''); 
        
        if (numero.length === 11) {
            // Formato CPF: 000.000.000-00
            return numero.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
        } else if (numero.length === 14) {
            // Formato CNPJ: 00.000.000/0000-00
            return numero.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5');
        }
    }
    return numero;
}
            $(document).ready(function(){
                $("#listarCliente").DataTable({
                    "language":{
                    "url": "datatables/portugues.json"     
                    }
                });
                // --- LÓGICA DE FORMATAÇÃO DA LISTA ---
                // Itera sobre todas as linhas do corpo da tabela
                $('#listarCliente tbody tr').each(function() {
                    var $row = $(this);
                    // A coluna CPF/CNPJ (4ª coluna) tem o índice 3 (0, 1, 2, **3**)
                    var $cpfCnpjCell = $row.find('td:eq(3)'); 
                    var valorSemMascara = $cpfCnpjCell.text().trim();
                    
                    // Aplica a formatação e substitui o conteúdo da célula
                    var valorFormatado = formatarCpfCnpj(valorSemMascara);
                    $cpfCnpjCell.text(valorFormatado);
                });
                // --- FIM DA LÓGICA DE FORMATAÇÃO ---
            });
        
        <!-- ativar menu responsivo-->
        
            function toggleMenu(){
                var menu = document.getElementById("nav-links");
                menu.classList.toggle("show");
            }
        </script>    
        
    </body>
</html>



