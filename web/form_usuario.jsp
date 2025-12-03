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
        <title>Cadastrar Usuario</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <!--Menu de navegação -->
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <h2>Cadastrar Usuario</h2>
            <div class="form-container">
                <form method="POST" action="gerenciar_usuario.do">
                    <legend>Formulário de Usuario</legend>
                    <!-- ID oculto -->
                    <input type="hidden" name="idUsuario" id="idUsuario" value="${usuario.idUsuario}"/>
                    
                    
                    <label for="nome_RazaoSocial">Nome do Usuario</label>
                    <input type="text" name="nome_RazaoSocial" id="nome_RazaoSocial" required="" 
                           maxlength="100" value="${usuario.nome_RazaoSocial}"/>
                    
                    <label for="login">Login</label>
                    <input type="text" name="login" id="login" required="" 
                           maxlength="100" value="${usuario.login}"/>
                    
                    <label for="senha">Senha</label>
                    <input type="password" name="senha" id="senha" required=""
                           maxlength="100" value="${usuario.senha}"/>
        <br>
                    <label for="CPF">CPF</label>
                    <input type="text" name="CPF" id="CPF" required=""
                           maxlength="14" value="${usuario.CPF}" onkeyup="mascaraCPF()"/>
                    
                    <label for="RG">RG</label>
                    <input type="text" name="RG" id="RG" required=""
                           maxlength="9" value="${usuario.RG}" onkeyup="mascaraRG()"/>
                    
                    <label for="telefone">Telefone</label>
                    <input type="text" name="telefone" id="telefone" required=""
                           maxlength="15" value="${usuario.telefone}" onkeyup="mascaratelefone()"/>
                    
                    <label for="endereco">Endereco</label>
                    <input type="text" name="endereco" id="endereco" required=""
                           maxlength="100" value="${usuario.endereco}"/>
                    
                    <label for="estado">Estado</label>
                    <input type="text" name="estado" id="estado" required=""
                           maxlength="100" value="${usuario.estado}"/>
                    
                    <label for="dataNasc">Data de Nascimento</label>
                    <input type="date" name="dataNasc" id="dataNasc" 
                           maxlength="100" value="${usuario.dataNasc}"/>
        <br>
                    <label for="Perfil">Perfil</label>
                    <select name="idPerfil" id="idPerfil" required="">
                        <option value="">Selecione o Perfil</option>
                        <jsp:useBean class="modelo.PerfilDAO" id="perfil"/>
                        <c:forEach var="p" items="${perfil.lista}">
                            <option value="${p.idPerfil}"
                                <c:if test="${p.idPerfil==usuario.perfil.idPerfil}">
                                    selected=""
                                </c:if>>${p.nome}</option> 
                        </c:forEach>
                    </select>
        <br>
                    <label for="status">Status</label>
                    <select name="status" required="">
                        <c:if test="${usuario.status==null}">  
                            <option value="0">Escolha uma opção</option>
                            <option value="1">Ativo</option>
                            <option value="2">Inativo</option>
                        </c:if>
                        <c:if test="${usuario.status==1}">
                            <option value="1" selected="">Ativo</option>
                            <option value="2">Inativo</option>
                        </c:if> 
                        <c:if test="${usuario.status==2}">
                            <option value="1">Ativo</option>
                            <option value="2" selected="">Inativo</option>
                        </c:if>    
                    </select>
                    
                    <!-- botoes-->
                    <div class="form button form">
                        <button type="submit" class="btn btn-success">Gravar</button>
                        <a href="gerenciar_usuario.do?acao=listarTodos" 
                           class="btn btn-warning">Voltar</a>
                    </div>
                         
                </form>
            </div>  
            
            
        </div> 
        <script type="text/javascript" src="datatables/jquery.js"></script>
        <script type="text/javascript" src="datatables/jquery.dataTables.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#listarUsuario").DataTable({
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
            
            function mascaraCPF(){
                var CPF = document.getElementById("CPF");
                // 1. Garante que só há números no campo e obtém o valor limpo
                var valorLimpo = limparNaoNumericos(CPF.value); 
                
                // 2. Reseta o valor do campo com a string limpa para prevenir caracteres indesejados
                if (CPF.value !== valorLimpo) {
                    CPF.value = valorLimpo;
                }
                
                // 3. Aplica a formatação (Lógica reescrita para ser robusta)
                var valorFinal = valorLimpo;
                if (valorLimpo.length > 3) {
                    valorFinal = valorLimpo.substring(0, 3) + "." + valorLimpo.substring(3);
                }
                if (valorLimpo.length > 6) {
                    valorFinal = valorFinal.substring(0, 7) + "." + valorFinal.substring(7);
                }
                if (valorLimpo.length > 9) {
                    valorFinal = valorFinal.substring(0, 11) + "-" + valorFinal.substring(11);
                }
                CPF.value = valorFinal;
            }
            
            function mascaraRG(){
                var RG = document.getElementById("RG");
                var valorLimpo = limparNaoNumericos(RG.value); 
                
                if (RG.value !== valorLimpo) {
                    RG.value = valorLimpo;
                }

                var valorFinal = valorLimpo;
                if (valorLimpo.length > 1) {
                    valorFinal = valorLimpo.substring(0, 1) + "." + valorLimpo.substring(1);
                }
                if (valorLimpo.length > 5) {
                    valorFinal = valorFinal.substring(0, 5) + "." + valorFinal.substring(5);
                }
                RG.value = valorFinal;
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
                if (document.getElementById("CPF").value.length > 0) {
                    mascaraCPF();
                }
                if (document.getElementById("RG").value.length > 0) {
                    mascaraRG();
                }
                if (document.getElementById("telefone").value.length > 0) {
                    mascaratelefone();
                }
            }
            
        </script>    
        
    </body>
</html>

