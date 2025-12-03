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
        <title>Cadastrar Fornecedor</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <!--Menu de navegação -->
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <h2>Cadastrar Fornecedor</h2>
            <div class="form-container">
                <form method="POST" action="gerenciar_fornecedor.do">
                    <legend>Formulário de Fornecedores</legend>
                    <!-- ID oculto -->
                    <input type="hidden" name="idFornecedor" id="idFornecedor" value="${fornecedor.idFornecedor}"/>
                    
                    
                    <label for="nome_RazaoSocial">Nome do Fornecedor</label>
                    <input type="text" name="nome_RazaoSocial" id="nome_RazaoSocial" required="" 
                           maxlength="100" value="${fornecedor.nome_RazaoSocial}"/>
                    
                    <label for="endereco">Endereco do Fornecedor</label>
                    <input type="text" name="endereco" id="endereco" required="" 
                           maxlength="100" value="${fornecedor.endereco}"/>
                    
                    <label for="estado">Estado</label>
                    <input type="text" name="estado" id="estado" required="" 
                           maxlength="100" value="${fornecedor.estado}"/>
                    
                    <label for="CNPJ">CNPJ</label>
                    <input type="text" name="CNPJ" id="CNPJ" required="" 
                           maxlength="18" value="${fornecedor.CNPJ}" onkeyup="mascaraCNPJ()"/>
                    
                    <label for="telefone">Telefone do Fornecedor</label>
                    <input type="text" name="telefone" id="telefone" required=""
                           maxlength="15" value="${fornecedor.telefone}" onkeyup="mascaratelefone()"/>
                    
                    <label for="status">Status</label>
                    <select name="status" required="">
                        <c:if test="${fornecedor.status==null}">  
                            <option value="0">Escolha uma opção</option>
                            <option value="1">Ativo</option>
                            <option value="2">Inativo</option>
                        </c:if>
                        <c:if test="${fornecedor.status==1}">
                            <option value="1" selected="">Ativo</option>
                            <option value="2">Inativo</option>
                        </c:if> 
                        <c:if test="${fornecedor.status==2}">
                            <option value="1">Ativo</option>
                            <option value="2" selected="">Inativo</option>
                        </c:if>    
                    </select>
                    
                    <!-- botoes-->
                    <div class="form button form">
                        <button type="submit" class="btn btn-success">Gravar</button>
                        <a href="gerenciar_fornecedor.do?acao=listarTodos" 
                           class="btn btn-warning">Voltar</a>
                    </div>
                         
                </form>
            </div>  
            
            
        </div> 
        <script type="text/javascript" src="datatables/jquery.js"></script>
        <script type="text/javascript" src="datatables/jquery.dataTables.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#listarFornecedor").DataTable({
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
            
            function limparNaoNumericos(valor) {
                return valor.replace(/\D/g, ''); 
            }

            inicializarMascaras();
            
            function mascaraCNPJ(){
                var CNPJ = document.getElementById("CNPJ");
                var valorLimpo = limparNaoNumericos(CNPJ.value); 
                
                // 2. Reseta o valor do campo com a string limpa para prevenir caracteres indesejados
                if (CNPJ.value !== valorLimpo) {
                    CNPJ.value = valorLimpo;
                }
                
                // 3. Aplica a formatação (Lógica reescrita para ser robusta)
                var valorFinal = valorLimpo;
                if (valorLimpo.length > 2) {
                    valorFinal = valorLimpo.substring(0, 2) + "." + valorLimpo.substring(2);
                }
                if (valorLimpo.length > 5) {
                    valorFinal = valorFinal.substring(0, 6) + "." + valorFinal.substring(6);
                }
                if (valorLimpo.length > 8) {
                    valorFinal = valorFinal.substring(0, 10) + "/" + valorFinal.substring(10);
                }
                if (valorLimpo.length > 12) {
                    valorFinal = valorFinal.substring(0, 15) + "-" + valorFinal.substring(15);
                }
                CNPJ.value = valorFinal;
            }

            function mascaratelefone(){
                var telefone = document.getElementById("telefone");
                var valorLimpo = limparNaoNumericos(telefone.value);

                // 1. Limpeza Garantida (Para impedir não-números)
                if (telefone.value !== valorLimpo) {
                    telefone.value = valorLimpo;
                }

                // 2. Trunca para o máximo de dígitos (11)
                var maxDigitos = 11;
                valorLimpo = valorLimpo.substring(0, maxDigitos);

                var valorFormatado = valorLimpo;

                // LÓGICA DE FORMATAÇÃO:

                // (XX)
                if (valorLimpo.length > 0) {
                    valorFormatado = "(" + valorLimpo.substring(0, 2);
                }

                // (XX) XXXXX...
                if (valorLimpo.length > 2) {
                    valorFormatado += ") " + valorLimpo.substring(2);
                }

                // (XX) 9XXXX-XXXX (11 dig.) ou (XX) XXXX-XXXX (10 dig.)
                if (valorLimpo.length > 6) { 

                    // Posição para o traço na string formatada:
                    // Se 11 dígitos (Celular): Traço após o 5º dígito do número (índice 10 da string formatada)
                    // Se 10 dígitos (Fixo): Traço após o 4º dígito do número (índice 9 da string formatada)

                    var posTraco = (valorLimpo.length === 11) ? 10 : 9;

                    if (valorFormatado.length > posTraco) {
                         valorFormatado = valorFormatado.substring(0, posTraco) + "-" + valorFormatado.substring(posTraco);
                    }
                }

                // Aplica o valor final e ajusta o maxlength
                telefone.value = valorFormatado;

                // Atualiza o maxlength (15 para celular, 14 para fixo)
                telefone.maxLength = (valorLimpo.length === 11) ? 15 : 14; 
            }
            
            function inicializarMascaras() {
                // Reaplica a máscara no carregamento (se houver valor no campo)
                if (document.getElementById("CNPJ").value.length > 0) {
                    mascaraCNPJ();
                }
                if (document.getElementById("telefone").value.length > 0) {
                    mascaratelefone();
                }
            }
        </script>    
        
    </body>
</html>


