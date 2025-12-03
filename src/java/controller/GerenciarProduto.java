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
import modelo.Produto;
import modelo.ProdutoDAO;

/**
 *
 * @author Note
 */
public class GerenciarProduto extends HttpServlet {

    

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
        String idProdutoStr = request.getParameter("idProduto");
        Produto p = new Produto();
        try{
            ProdutoDAO pDAO = new ProdutoDAO();
            int idProduto = 0;
            if(acao.equals("alterar")){
                if(GerenciarLogin.verificarPermissao(request, response)){
                    try{
                        idProduto = Integer.parseInt(idProdutoStr);
                        p = pDAO.getCarregaPorID(idProduto);
                        if(p.getIdProduto()>0){
                            RequestDispatcher disp = getServletContext().getRequestDispatcher("/form_produto.jsp");
                            request.setAttribute("produto", p);
                            disp.forward(request, response);
                        }else{
                            exibirMensagem("Produto não encontrado", false, "",response);
                        }

                    }catch(NumberFormatException e){
                        exibirMensagem("ID de produto inválido", false, "",response);
                    }
                }else{
                    exibirMensagem("Acesso Negado", false, "",response);
                }
            }
            if(acao.equals("desativar")){
                if(GerenciarLogin.verificarPermissao(request, response)){
                    try{
                        idProduto = Integer.parseInt(idProdutoStr);
                        if(idProduto!=0){
                            p.setIdProduto(idProduto);
                            if(pDAO.desativar(p)){
                                exibirMensagem("Produto desativado com sucesso", true, "gerenciar_produto.do?acao=listarTodos", response);
                            }else{
                                exibirMensagem("Erro ao desativar", false, "", response);
                            }
                        }
                    }catch(NumberFormatException e){
                       exibirMensagem("id de produto invalido", false, "", response); 
                    }
                }else{
                    exibirMensagem("Acesso Negado", false, "",response);
                }
            }
            
            if(acao.equals("listarTodos")){
                
                ArrayList<Produto> listarTodos = new ArrayList<>();
                listarTodos = pDAO.getLista();
                
                    RequestDispatcher disp = getServletContext().getRequestDispatcher("/listar_produto.jsp");
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
            String nome = request.getParameter("nome");
            String quantidadeStr = request.getParameter("quantidade");
            String valorUnitarioStr = request.getParameter("valorUnitario");
            String statusStr = request.getParameter("status");
            String idProdutoStr = request.getParameter("idProduto");
            String idFornecedorStr = request.getParameter("idFornecedor");
            
        try{
            
            int quantidade = 0;
            double valorUnitario = 0;
            int status = 0;
            int idProduto=0;
            int idFornecedor = 0;
            
            
            if(quantidadeStr!= null && !quantidadeStr.isEmpty()){
                try{
                    quantidade = Integer.parseInt(quantidadeStr);
                }catch(NumberFormatException e){
                    erros.add("quantidade inválido");
                }
            }
            
            if(valorUnitarioStr!= null && !valorUnitarioStr.isEmpty()){
                try{
                    valorUnitario = Double.parseDouble(valorUnitarioStr);
                }catch(NumberFormatException e){
                    erros.add("valor Unitario inválido");
                }
            }
            
            if(idProdutoStr!= null && !idProdutoStr.isEmpty()){
                try{
                    idProduto = Integer.parseInt(idProdutoStr);
                }catch(NumberFormatException e){
                    erros.add("ID de produto inválido");
                }
            }
            
            if(statusStr!= null && !statusStr.isEmpty()){
                try{
                    status = Integer.parseInt(statusStr);
                }catch(NumberFormatException e){
                    erros.add("status do produto inválido");
                }
            }
            
            if(idFornecedorStr!= null && !idFornecedorStr.isEmpty()){
                try{
                    idFornecedor = Integer.parseInt(idFornecedorStr);
                }catch(NumberFormatException e){
                    erros.add("idFornecedor do fornecedor inválido");
                }
            }
                        
            if(nome == null || nome.trim().isEmpty())
                erros.add("O campo nome é obrigatório");
                        
            if(erros.size()>0){
                String campos="";
                for(String erro:erros){
                    campos+= "\\n - "+erro;
                }
                exibirMensagem("Preencha o (s) campo(s)"+campos, false,"", response);
            }else{
                Produto p = new Produto();
                p.setIdProduto(idProduto);
                p.setNome(nome);
                p.setQuantidade(quantidade);
                p.setValorUnitario(valorUnitario);
                p.setStatus(status);
                    Fornecedor f = new Fornecedor();
                    f.setIdFornecedor(idFornecedor);
                p.setFornecedor(f);
                
                //Usa DAO para gravar no banco
                ProdutoDAO dao = new ProdutoDAO();
                boolean sucesso = dao.gravar(p);
                
                if(sucesso){
                    exibirMensagem("Produto gravado com sucesso", true, "gerenciar_produto.do?acao=listarTodos", response);
                }else{
                    exibirMensagem("Erro ao gravar os dados do produto", false, "", response);
                }
            }
            
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GerenciarProduto.class.getName()).log(Level.SEVERE, null, ex);
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
