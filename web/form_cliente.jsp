<%-- 
    Document   : form_cliente
    Created on : 01/10/2025, 20:41:39
    Author     : 377457
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
        <title>Cadastrar Cliente</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <!--Menu de navegação -->
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <h2>Cadastrar Cliente</h2>
            <div class="form-container">
                <form method="POST" action="gerenciar_cliente.do">
                    <legend>Formulário de Cliente</legend>
                    <!-- ID oculto -->
                    <input type="hidden" name="idCliente" id="idCliente" value="${cliente.idCliente}"/>
                    
                    <label for="nome_RazaoSocial">Nome do Cliente </label>
                    <input type="text" name="nome_RazaoSocial" id="nome_RazaoSocial" required="" 
                           maxlength="100" value="${cliente.nome_RazaoSocial}"/>
                    
                    <label for="tipo">Tipo de Pessoa</label>
                    <select name="tipo" required="">
                        <c:if test="${cliente.tipo==null}">  
                            <option value="0">Escolha uma opção</option>
                            <option value="1">Pessoa Física</option>
                            <option value="2">Pessoa Jurídica</option>
                        </c:if>
                        <c:if test="${cliente.tipo==1}">
                            <option value="1" selected="">Pessoa Física</option>
                            <option value="2">Pessoa Jurídica</option>
                        </c:if> 
                        <c:if test="${cliente.tipo==2}">
                            <option value="1">Pessoa Física</option>
                            <option value="2" selected="">Pessoa Jurídica</option>
                        </c:if>    
                    </select>
        <br>                   
                    <label for="CPF_CNPJ" >CPF/CNPJ</label>
                    <input type="text" name="CPF_CNPJ" id="CPF_CNPJ" required="" 
                           maxlength="18" value="${cliente.CPF_CNPJ}"/>
                    
                    <label for="status">Status</label>
                    <select name="status" required="">
                        <c:if test="${cliente.status==null}">  
                            <option value="0">Escolha uma opção</option>
                            <option value="1">Ativo</option>
                            <option value="2">Inativo</option>
                        </c:if>
                        <c:if test="${cliente.status==1}">
                            <option value="1" selected="">Ativo</option>
                            <option value="2">Inativo</option>
                        </c:if> 
                        <c:if test="${cliente.status==2}">
                            <option value="1">Ativo</option>
                            <option value="2" selected="">Inativo</option>
                        </c:if>    
                    </select>
                    
                    <!-- botoes-->
                    <div class="form button form">
                        <button type="submit" class="btn btn-success">Gravar</button>
                        <a href="gerenciar_cliente.do?acao=listarTodos" 
                           class="btn btn-warning">Voltar</a>
                    </div>
                         
                </form>
            </div>  
            
            
        </div> 
<script type="text/javascript" src="datatables/jquery.js"></script>
<script type="text/javascript" src="datatables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/jquery.mask.min.js"></script>
<script type="text/javascript">
    
    // 1. FUNÇÃO DE LIMPEZA GERAL
    function limparFormatacao(valor) {
        return valor.replace(/\D/g, ''); // Remove tudo que não for dígito
    }

    // 2. MÁSCARA MANUAL DE CPF (Aprimorada com limpeza)
    function aplicarMascaraCPF() {
        var campo = document.getElementById("CPF_CNPJ");
        var valor = limparFormatacao(campo.value);
        var mascara = '';

        if (valor.length > 0) {
            mascara = valor.substring(0, 3);
        }
        if (valor.length > 3) {
            mascara += "." + valor.substring(3, 6);
        }
        if (valor.length > 6) {
            mascara += "." + valor.substring(6, 9);
        }
        if (valor.length > 9) {
            mascara += "-" + valor.substring(9, 11);
        }
        campo.value = mascara;
        campo.maxLength = 14; // CPF tem no máximo 14 caracteres formatados
    }
    
    // 3. MÁSCARA MANUAL DE CNPJ (Aprimorada com limpeza)
    function aplicarMascaraCNPJ() {
        var campo = document.getElementById("CPF_CNPJ");
        var valor = limparFormatacao(campo.value);
        var mascara = '';

        if (valor.length > 0) {
            mascara = valor.substring(0, 2);
        }
        if (valor.length > 2) {
            mascara += "." + valor.substring(2, 5);
        }
        if (valor.length > 5) {
            mascara += "." + valor.substring(5, 8);
        }
        if (valor.length > 8) {
            mascara += "/" + valor.substring(8, 12);
        }
        if (valor.length > 12) {
            mascara += "-" + valor.substring(12, 14);
        }
        campo.value = mascara;
        campo.maxLength = 18; // CNPJ tem no máximo 18 caracteres formatados
    }

    // 4. FUNÇÃO DE CONTROLE DINÂMICO
    function configurarMascara(tipo,limparCampo) {
        var campo = $('#CPF_CNPJ');
        // SÓ LIMPA O CAMPO SE A FUNÇÃO FOR CHAMADA PARA LIMPAR (ou seja, quando o usuário muda o <select>)
        if(limparCampo){
            campo.val('');
        }
        campo.off('keyup'); // Remove qualquer evento keyup anterior

        if (tipo === '1' || tipo === '0') { // Pessoa Física ou Escolha (Default)
            campo.on('keyup', aplicarMascaraCPF);
            aplicarMascaraCPF(); // Aplica a formatação inicial (maxlength)
        } else if (tipo === '2') { // Pessoa Jurídica
            campo.on('keyup', aplicarMascaraCNPJ);
            aplicarMascaraCNPJ(); // Aplica a formatação inicial (maxlength)
        }
        // Após aplicar a função de máscara, força a formatação do valor existente (se houver)
        // Primeiro, removemos a formatação do valor que veio do DB
        var valorLimpoDoDB = limparFormatacao(campo.val());
        campo.val(valorLimpoDoDB);

        // E depois re-aplicamos a máscara em cima do valor limpo.
        campo.trigger('keyup');
    }
    
    $(document).ready(function(){
        // Inicialização do DataTables (mantido)
        $("#listarCliente").DataTable({
            "language":{
            "url": "datatables/portugues.json"     
            }
        });
        
        // --- 1. LÓGICA DE INICIALIZAÇÃO (MODO EDIÇÃO) ---
    var tipoInicial = $('select[name="tipo"]').val();
    
    // Chamamos a função SEM o parâmetro 'limparCampo'. O valor do DB será carregado e formatado.
    configurarMascara(tipoInicial, false); 
    
    // --- 2. LÓGICA DE ALTERAÇÃO (SÓ LIMPA SE O USUÁRIO MUDAR) ---
    $('select[name="tipo"]').on('change', function() {
        var tipoSelecionado = $(this).val();
        
        // Chamamos a função COM o parâmetro 'limparCampo' como true.
        configurarMascara(tipoSelecionado, true); 
    });
        
        function toggleMenu(){
            var menu = document.getElementById("nav-links");
            menu.classList.toggle("show");
        }
    });
</script>
        
    </body>
</html>



