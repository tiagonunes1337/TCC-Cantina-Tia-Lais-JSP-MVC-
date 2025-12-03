<%-- 
    Document   : index
    Created on : 12/08/2025, 21:29:37
    Author     : adm_pfelacio
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
            function confirmarDesativar(idUsuario, nome_RazaoSocial){
                
                if(confirm('Deseja realmente desativar o usuario '+nome_RazaoSocial+'?')){
                    window.open("gerenciar_usuario.do?acao=desativar&idUsuario="+idUsuario,"_self");
                }
                
            }
        </script>    
        <title>Listar Usuario</title>
    </head>
    <body>
        <div class="banner">
            <%@include file="banner.jsp" %>
        </div>
        <!--Menu de navegação -->
        <%@include file="menu.jsp" %>
        
        <div class="content">
            <h2>Listar Usuários</h2>
            <a href="form_usuario.jsp" class="btn btn-primary">Novo Usuário</a>
            <table class="table table-hover table-striped table-bordered display" id="listarUsuario">
            
                <thead>
                    <tr>
                        <th>idUsuario</th>
                        <th>Nome do Usuario</th>
                        <th>Login</th>
                        <th>CPF</th>
                        <th>Telefone</th>
                        <th>Data de Nascimento</th>
                        <th>Perfil</th>
                        <th>Status</th>
                        <th>Opções</th>
                    </tr>
                </thead>
                 <tfoot>
                    <tr>
                        <th>idUsuario</th>
                        <th>Nome do Usuario</th>
                        <th>Login</th>
                        <th>CPF</th>
                        <th>Telefone</th>
                        <th>Data de Nascimento</th>
                        <th>Perfil</th>
                        <th>Status</th>
                        <th>Opções</th>
                    </tr>
                </tfoot>
                <tbody>
                    <c:forEach var="u" items="${listarTodos}">
                        <tr>
                            <td>${u.idUsuario}</td> 
                            <td>${u.nome_RazaoSocial}</td>
                            <td>${u.login}</td>
                            <td>${u.CPF}</td>
                            <td>${u.telefone}</td>
                            <td><fmt:formatDate pattern="dd/MM/yyyy" value="${u.dataNasc}"/></td>
                            <td>${u.perfil.nome}</td>
                            <td><c:if test="${u.status==1}">Ativo</c:if>
                                <c:if test="${u.status==2}">Inativo</c:if>
                            </td>
                            <td>
    <c:if test="${u.perfil.idPerfil != 1 || ulogado.perfil.idPerfil == 1}">
        
        <a class="btn btn-warning" href="gerenciar_usuario.do?acao=alterar&idUsuario=${u.idUsuario}">
            <i class="glyphicon glyphicon-pencil"></i>
        </a>
        
        <button class="btn btn-danger" onclick="confirmarDesativar(${u.idUsuario},'${u.nome_RazaoSocial}')">
            <i class="glyphicon glyphicon-trash"></i>
        </button>
        
    </c:if>

    <c:if test="${u.perfil.idPerfil == 1 && ulogado.perfil.idPerfil != 1}">
        <span class="btn btn-default disabled" title="Acesso Restrito ao Admin Master">
            <i class="glyphicon glyphicon-lock"></i>
        </span>
    </c:if>
</td>
                        </tr>
                        
                       
                        
                    </c:forEach>
                    
                </tbody>
            
            </table>    
            
            
        </div> 
        <script type="text/javascript" src="datatables/jquery.js"></script>
        <script type="text/javascript" src="datatables/jquery.dataTables.min.js"></script>
        <script type="text/javascript">
            // --- 1. FUNÇÃO DE FORMATAÇÃO DE CPF ---
            function formatarCPF(numero) {
                if (numero) {
                    // Remove qualquer não-dígito que possa ter vindo
                    numero = String(numero).replace(/\D/g, ''); 
                    
                    if (numero.length === 11) {
                        // Aplica a máscara CPF: 000.000.000-00
                        return numero.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
                    }
                }
                return numero; // Retorna o valor original (limpo) se o tamanho for incorreto
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
                $("#listarUsuario").DataTable({
                    "language":{
                    "url": "datatables/portugues.json"     
                    }
                });
                // --- 2. APLICAÇÃO DA FORMATAÇÃO NA TABELA ---
                // Itera sobre todas as linhas do corpo da tabela
                $('#listarUsuario tbody tr').each(function() {
                    var $row = $(this);
                    // O campo CPF está na 4ª coluna, índice 3 (0, 1, 2, **3**)
                    var $cpfCell = $row.find('td:eq(3)'); 
                    var valorSemMascara = $cpfCell.text().trim();
                    // Aplica a formatação de CPF
                    var valorFormatado = formatarCPF(valorSemMascara);
                    $cpfCell.text(valorFormatado);
                    
                    var $telCell = $row.find('td:eq(4)'); 
                    var valorSemMascaraTel = $telCell.text().trim();
                    $telCell.text(formatarTelefone(valorSemMascaraTel));
                });
                // --- FIM DA APLICAÇÃO DA FORMATAÇÃO ---
                <!-- ativar menu responsivo-->
        
            function toggleMenu(){
                var menu = document.getElementById("nav-links");
                menu.classList.toggle("show");
            }
            });
        
        
        </script>    
        
    </body>
</html>


