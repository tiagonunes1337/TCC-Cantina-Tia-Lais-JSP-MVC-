<%-- 
    Document   : index
    Created on : 12/08/2025, 21:29:37
    Author     : adm_pfelacio
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
            function confirmarDesativar(idFornecedor, nome_RazaoSocial){
                
                if(confirm('Deseja realmente desativar o fornecedor '+nome_RazaoSocial+'?')){
                    window.open("gerenciar_fornecedor.do?acao=desativar&idFornecedor="+idFornecedor,"_self");
                }
                
            }
        </script>    
        <title>Listar Fornecedor</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <!--Menu de navegação -->
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <h2>Listar Fornecedores</h2>
            <a href="form_fornecedor.jsp" class="btn btn-primary">Novo Fornecedor</a>
            <table class="table table-hover table-striped table-bordered display" id="listarFornecedor">
            
                <thead>
                    <tr>
                        <th>idFornecedor</th>
                        <th>Nome do Fornecedor</th>
                        <th>Endereco</th>
                        <th>Estado</th>
                        <th>CNPJ</th>
                        <th>Telefone</th>
                        <th>Status</th>
                        <th>Opções</th>
                    </tr>
                </thead>
                 <tfoot>
                    <tr>
                        <th>idFornecedor</th>
                        <th>Nome do Fornecedor</th>
                        <th>Endereco</th>
                        <th>Estado</th>
                        <th>CNPJ</th>
                        <th>Telefone</th>
                        <th>Status</th>
                        <th>Opções</th>
                    </tr>
                </tfoot>
                <tbody>
                    <c:forEach var="f" items="${listarTodos}">
                        <tr>
                            <td>${f.idFornecedor}</td> 
                            <td>${f.nome_RazaoSocial}</td>
                            <td>${f.endereco}</td>
                            <td>${f.estado}</td>
                            <td>${f.CNPJ}</td>
                            <td>${f.telefone}</td>
                            <td><c:if test="${f.status==1}">Ativo</c:if>
                                <c:if test="${f.status==2}">Inativo</c:if>
                            </td>
                            <td>
                                <a class="btn btn-warning" href="gerenciar_fornecedor.do?acao=alterar&idFornecedor=${f.idFornecedor}">
                                    <i class="glyphicon glyphicon-pencil"></i>
                                </a>
                                <button class="btn btn-danger" onclick="confirmarDesativar(${f.idFornecedor},'${f.nome_RazaoSocial}')">
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
            // --- 1. FUNÇÃO DE FORMATAÇÃO DE CNPJ (Repita a função acima aqui) ---
            function formatarCNPJ(numero) {
                // ... (código da função CNPJ aqui) ...
                if (numero) {
                    numero = String(numero).replace(/\D/g, ''); 
                    if (numero.length === 14) {
                        return numero.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5');
                    }
                }
                return numero;
            }
            function formatarTelefone(numero) {
                if (!numero) return '';
                let valorLimpo = String(numero).replace(/\D/g, ''); 

                // Fixo (10 dígitos: (XX) XXXX-XXXX) ou Celular (11 dígitos: (XX) 9XXXX-XXXX)
                if (valorLimpo.length === 10) {
                    return valorLimpo.replace(/^(\d{2})(\d{4})(\d{4})$/, '($1) $2-$3');
                } else if (valorLimpo.length === 11) {
                    return valorLimpo.replace(/^(\d{2})(\d{5})(\d{4})$/, '($1) $2-$3');
                }
                return numero;
            }
            $(document).ready(function(){
                $("#listarFornecedor").DataTable({
                    "language":{
                    "url": "datatables/portugues.json"     
                    }
                });
                // --- 2. APLICAÇÃO DA FORMATAÇÃO NA TABELA ---
                // Itera sobre todas as linhas do corpo da tabela
                $('#listarFornecedor tbody tr').each(function() {
                    var $row = $(this);
                    // O campo CNPJ está na 5ª coluna, índice 4 (0, 1, 2, 3, **4**)
                    var $cnpjCell = $row.find('td:eq(4)'); 
                    var valorSemMascara = $cnpjCell.text().trim();
                    // Aplica a formatação de CNPJ
                    var valorFormatado = formatarCNPJ(valorSemMascara);
                    $cnpjCell.text(valorFormatado);
                    
                    var $telCell = $row.find('td:eq(5)'); 
                    var valorSemMascaraTel = $telCell.text().trim();
                    $telCell.text(formatarTelefone(valorSemMascaraTel));
                });
                // --- FIM DA APLICAÇÃO DA FORMATAÇÃO ---
                
                function toggleMenu(){
                    var menu = document.getElementById("nav-links");
                    menu.classList.toggle("show");
                }
            });
        
        <!-- ativar menu responsivo-->
        
            
        </script>    
        
    </body>
</html>


