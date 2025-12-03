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
        <title>Relatório de Vendas</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <%@include file="menu.jsp" %>
        
        <<div class="content">
    <h2>Gerar Relatório de Vendas</h2>
    
    <form method="POST" action="gerenciar_relatorio.do">
        
        <div class="form-group">
            <label>Data de Início:</label>
            <input type="date" name="dataInicio" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label>Data Final:</label>
            <input type="date" name="dataFim" class="form-control" required>
        </div>
        
        <div class="form-group" style="margin-top: 20px;">
            <button type="submit" class="btn btn-primary">
                Visualizar na Tela
            </button>
            
            <button type="submit" class="btn btn-danger" 
                    formaction="gerenciar_relatorio.do?acao=gerarPDF">
                Baixar PDF
            </button>
        </div>
        
    </form>
</div>
        
        <script>
            function toggleMenu(){
                var menu = document.getElementById("nav-links");
                menu.classList.toggle("show");
            }
            
            function validarDatas(){
                var dataInicio = document.getElementById('dataInicio').value;
                var dataFim = document.getElementById('dataFim').value;
                
                if(dataInicio === '' || dataFim === ''){
                    alert('Por favor, preencha ambas as datas.');
                    return false;
                }
                
                if(dataInicio > dataFim){
                    alert('A data de início não pode ser maior que a data final.');
                    return false;
                }
                
                return true;
            }
        </script>  
    </body>
</html>
