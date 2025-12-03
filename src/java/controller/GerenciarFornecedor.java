/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Fornecedor;
import modelo.FornecedorDAO;

/**
 *
 * @author 375861
 */
public class GerenciarFornecedor extends HttpServlet {

   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        PrintWriter out = response.getWriter();
        String mensagem = "";
        
        String acao = request.getParameter("acao");
        String idFornecedorStr = request.getParameter("idFornecedor");
        Fornecedor f = new Fornecedor();
        try{
            FornecedorDAO fDAO = new FornecedorDAO();
            int idFornecedor = 0;
            if(acao.equals("alterar")){
                if(GerenciarLogin.verificarPermissao(request, response)){
                    try{
                        idFornecedor = Integer.parseInt(idFornecedorStr);
                        f = fDAO.getCarregaPorID(idFornecedor);
                        if(f.getIdFornecedor()>0){
                            RequestDispatcher disp = getServletContext().getRequestDispatcher("/form_fornecedor.jsp");
                            request.setAttribute("fornecedor", f);
                            disp.forward(request, response);
                        }else{
                            exibirMensagem("Fornecedor não encontrado", false, "",response);
                        }

                    }catch(NumberFormatException e){
                        exibirMensagem("ID de fornecedor inválido", false, "",response);
                    }
                }else{
                    exibirMensagem("Acesso Negado", false, "",response);
                }
            }
            if(acao.equals("desativar")){
                if(GerenciarLogin.verificarPermissao(request, response)){
                    try{
                        idFornecedor = Integer.parseInt(idFornecedorStr);
                        if(idFornecedor!=0){
                            f.setIdFornecedor(idFornecedor);
                            if(fDAO.desativar(f)){
                                exibirMensagem("Fornecedor desativado com sucesso", true, "gerenciar_fornecedor.do?acao=listarTodos", response);
                            }else{
                                exibirMensagem("Erro ao desativar", false, "", response);
                            }
                        }
                    }catch(NumberFormatException e){
                       exibirMensagem("id de fornecedor invalido", false, "", response); 
                    }
                }else{
                    exibirMensagem("Acesso Negado", false, "",response);
                }
            }
            
            if(acao.equals("listarTodos")){
                
                ArrayList<Fornecedor> listarTodos = new ArrayList<>();
                listarTodos = fDAO.getLista();
                
                    RequestDispatcher disp = getServletContext().getRequestDispatcher("/listar_fornecedor.jsp");
                    request.setAttribute("listarTodos", listarTodos);
                    disp.forward(request, response);
                
            
            }
        
        }catch(Exception e){
            out.println(e);
            exibirMensagem("Erro ao acessar o banco", false, "", response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        PrintWriter out = response.getWriter();
        //configurar o response
        response.setContentType("text/html");
        ArrayList<String> erros = new ArrayList<String>();
        //Recebe os parametros
            String nome_RazaoSocial = request.getParameter("nome_RazaoSocial");
            String endereco = request.getParameter("endereco");
            String estado = request.getParameter("estado");
            String CNPJ = request.getParameter("CNPJ");
            if (CNPJ != null) {
                CNPJ = CNPJ.replaceAll("[^0-9]", ""); 
            }
            String telefone = request.getParameter("telefone");
            if (telefone != null) {
                telefone = telefone.replaceAll("[^0-9]", ""); 
            }
            String statusStr = request.getParameter("status");
            String idFornecedorStr = request.getParameter("idFornecedor");
            
        try{
            
            
            int status = 0;
            int idFornecedor=0;
            
            
            if(idFornecedorStr!= null && !idFornecedorStr.isEmpty()){
                try{
                    idFornecedor = Integer.parseInt(idFornecedorStr);
                }catch(NumberFormatException e){
                    erros.add("ID de fornecedor inválido");
                }
            }
            if(statusStr!= null && !statusStr.isEmpty()){
                try{
                    status = Integer.parseInt(statusStr);
                }catch(NumberFormatException e){
                    erros.add("status do fornecedor inválido");
                }
            }
            
            if(nome_RazaoSocial == null || nome_RazaoSocial.trim().isEmpty())
                erros.add("O campo nome é obrigatório");
            
            if(endereco == null || endereco.trim().isEmpty())
                erros.add("O campo endereco é obrigatório");
            
            if(estado == null || estado.trim().isEmpty())
                erros.add("O campo estado é obrigatório");
            
            if(CNPJ == null || CNPJ.trim().isEmpty())
                erros.add("O campo CNPJ é obrigatório");
            
            if(telefone == null || telefone.trim().isEmpty())
                erros.add("O campo telefone é obrigatório");
            
            
            if(erros.size()>0){
                String campos="";
                for(String erro:erros){
                    campos+= "\\n - "+erro;
                }
                exibirMensagem("Preencha o (s) campo(s)"+campos, false,"", response);
            }else{
                //Cria o objeto Menu com os dadois recebidos
                Fornecedor f = new Fornecedor();
                f.setIdFornecedor(idFornecedor);
                // System.out.println(p.getIdPerfil());
                f.setNome_RazaoSocial(nome_RazaoSocial);
                f.setEndereco(endereco);
                f.setEstado(estado);
                f.setCNPJ(CNPJ);
                f.setTelefone(telefone);
                f.setStatus(status);
                
                //Usa DAO para gravar no banco
                FornecedorDAO dao = new FornecedorDAO();
                boolean sucesso = dao.gravar(f);
                
                if(sucesso){
                    exibirMensagem("Fornecedor gravado com sucesso", true, "gerenciar_fornecedor.do?acao=listarTodos", response);
                }else{
                    exibirMensagem("Erro ao gravar os dados do fornecedor", false, "", response);
                }
            }
	            
	            
	        } catch (ClassNotFoundException ex) {
	            Logger.getLogger(GerenciarFornecedor.class.getName()).log(Level.SEVERE, null, ex);
	            exibirMensagem("Erro interno: Classe não encontrada. Contate o administrador.", false, "", response);
	        } catch (Exception ex) {
	            Logger.getLogger(GerenciarFornecedor.class.getName()).log(Level.SEVERE, null, ex);
	            exibirMensagem("Erro ao processar a requisição: " + ex.getMessage(), false, "", response);
	        }
	    }
    
    private static void exibirMensagem(String mensagem, boolean resposta, String link, HttpServletResponse response){
            
        try{
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('"+mensagem+"')");
            if(resposta){
                out.println("location.href='"+link+"'");
            }else{
                out.println("history.back();");
            }
            out.println("</script>");
            out.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
