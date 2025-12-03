/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Cliente;
import modelo.ClienteDAO;
import modelo.Produto;
import modelo.ProdutoDAO;
import modelo.Usuario;
import modelo.Venda;
import modelo.VendaProduto;
import modelo.VendaDAO;

/**
 *
 * @author 377457
 */
public class GerenciarVenda extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GerenciarVenda</title>");            
            out.println("</head>");
            out.println("<body>");
            HttpSession sessao = request.getSession();
            Usuario ulogado = (Usuario) request.getSession().getAttribute("ulogado");
            Venda v = new Venda();
            Cliente c = new Cliente();
            try{
                ClienteDAO cDAO = new ClienteDAO();
                ProdutoDAO pDAO = new ProdutoDAO();
                VendaDAO vDAO = new VendaDAO();
                
                String acao = request.getParameter("acao");
                //modificação
                String idVendasStr = request.getParameter("idVendas"); 
                int idVendas = (idVendasStr != null && !idVendasStr.isEmpty()) ? Integer.parseInt(idVendasStr) : 0;
                
                ArrayList<VendaProduto> carrinho = new ArrayList<>();
                if(acao.equals("alterar")){
                    if(GerenciarLogin.verificarPermissao(request, response)){
                        if(idVendas > 0){
                            // Usa o método getCarregaPorID do VendaDAO
                            v = vDAO.getCarregaPorID(idVendas);
                            if(v.getIdVendas() > 0){
                                // Coloca o objeto Venda na sessão para ser editado no form_venda.jsp
                                sessao.setAttribute("venda", v); 
                                response.sendRedirect("form_venda.jsp"); 
                            } else {
                                exibirMensagem("Venda não encontrada", false, "", response);
                            }
                        } else {
                            exibirMensagem("ID de Venda inválido para alteração", false, "", response);
                        }
                    } else {
                        exibirMensagem("Acesso Negado", false, "", response);
                    }
                }
                if(acao.equals("desativar")){
                    if(GerenciarLogin.verificarPermissao(request, response)){
                        if(idVendas > 0){
                            v.setIdVendas(idVendas);
                            if(vDAO.desativar(v)){
                                exibirMensagem("Venda cancelada com sucesso!", true, "gerenciar_venda.do?acao=listarTodos", response);
                            } else {
                                exibirMensagem("Erro ao cancelar a venda!", false, "", response);
                            }
                        } else {
                            exibirMensagem("ID de Venda inválido para desativação", false, "", response);
                        }
                    } else {
                        exibirMensagem("Acesso Negado", false, "", response);
                    }
                }
                if(acao.equals("finalizar")){
                    if(GerenciarLogin.verificarPermissao(request, response)){
                        if(idVendas > 0){
                            v.setIdVendas(idVendas);
                            if(vDAO.finalizar(v)){
                                exibirMensagem("Venda finalizada com sucesso!", true, "gerenciar_venda.do?acao=listarTodos", response);
                            } else {
                                exibirMensagem("Erro ao finalizar a venda!", false, "", response);
                            }
                        } else {
                            exibirMensagem("ID de Venda inválido para finalizar a venda", false, "", response);
                        }
                    } else {
                        exibirMensagem("Acesso Negado", false, "", response);
                    }
                }
                if(acao.equals("novaVenda")){
                    if(GerenciarLogin.verificarPermissao(request, response)){
                        String idClienteStr = request.getParameter("idCliente");
                        int idCliente = Integer.parseInt(idClienteStr);
                        c = cDAO.getCarregaPorID(idCliente);
                        v.setCliente(c);
                        v.setVendedor(ulogado);
                        v.setStatus(1);
                        v.setCarrinho(new ArrayList<VendaProduto>());
                        sessao.setAttribute("venda", v);
                        response.sendRedirect("form_venda.jsp");
                    }else{
                        exibirMensagem("Acesso Negado", false, "", response);
                    }
                }
                if (acao.equals("AdicionarProduto")) {
                    if (GerenciarLogin.verificarPermissao(request, response)) {
                        v = (Venda) sessao.getAttribute("venda");
                        Produto p = new Produto();

                        try {
                            int idProduto = Integer.parseInt(request.getParameter("idProduto"));
                            int qtdSolicitada = Integer.parseInt(request.getParameter("quantidade"));

                            // 1. Busca o estoque ATUAL no banco
                            p = pDAO.getCarregaPorID(idProduto);
                            int estoqueDisponivel = p.getQuantidade();

                            // 2. Verifica quanto desse produto JÁ TEM no carrinho
                            carrinho = v.getCarrinho();
                            int qtdNoCarrinho = 0;
                            for (VendaProduto item : carrinho) {
                                if (item.getProduto().getIdProduto() == idProduto) {
                                    qtdNoCarrinho += item.getQuantidadeVendido();
                                }
                            }


                            if ((qtdSolicitada + qtdNoCarrinho) > estoqueDisponivel) {
                                exibirMensagem("Estoque insuficiente! Você tem " + estoqueDisponivel + 
                                               " e tentou adicionar um total de " + (qtdSolicitada + qtdNoCarrinho), false, "", response);
                            } else {
                                // Se tiver estoque, prossegue com a adição normal
                                boolean produtoExistente = false;
                                for (VendaProduto item : carrinho) {
                                    if (item.getProduto().getIdProduto() == idProduto) {
                                        item.setQuantidadeVendido(item.getQuantidadeVendido() + qtdSolicitada);
                                        produtoExistente = true;
                                        break;
                                    }
                                }

                                if (!produtoExistente) {
                                    VendaProduto vp = new VendaProduto();
                                    vp.setProduto(p);
                                    vp.setQuantidadeVendido(qtdSolicitada);
                                    vp.setValorVendido(p.getValorUnitario());
                                    carrinho.add(vp);
                                }

                                v.setCarrinho(carrinho);
                                sessao.setAttribute("venda", v);
                                response.sendRedirect("form_venda.jsp");
                            }

                        } catch (Exception e) {
                             exibirMensagem("Erro ao processar produto: " + e.getMessage(), false, "", response);
                        }

                    } else {
                        exibirMensagem("Acesso negado", false, "", response);
                    }
                }
                if(acao.equals("retirarProduto")){
                    if(GerenciarLogin.verificarPermissao(request, response)){
                        v = (Venda) sessao.getAttribute("venda");
                        int index = Integer.parseInt(request.getParameter("index"));
                        carrinho = v.getCarrinho();
                        carrinho.remove(index);
                        v.setCarrinho(carrinho);
                        sessao.setAttribute("venda", v);
                        response.sendRedirect("form_visualizar_carrinho.jsp");
                    }else{
                        exibirMensagem("Acesso negado", false, "", response);
                    }    
                }
                if(acao.equals("gravar")){
                    if(GerenciarLogin.verificarPermissao(request, response)){
                        try{
                            v = (Venda) sessao.getAttribute("venda");
                            if(vDAO.gravar(v)){
                                exibirMensagem("Venda gravada com sucesso!",true,"gerenciar_venda.do?acao=listarTodos",response);
                            }else{
                                exibirMensagem("Erro ao gravar a venda!",false,"",response);
                            }
                        }catch(Exception e){
                            out.print("Erro"+e);
                        }
                    }else{
                        exibirMensagem("Acesso negado", false, "", response);
                    }
                }
                if(acao.equals("listarVendaPorCliente")){
                    
                    String idClienteStr = request.getParameter("idCliente");
                        int idCliente = Integer.parseInt(idClienteStr);
                        ArrayList<Venda> listarVendaPorCliente = vDAO.getVendasPorCliente(idCliente);
                    RequestDispatcher disp = getServletContext().getRequestDispatcher("/listar_venda.jsp");
                    request.setAttribute("listarVendaPorCliente", listarVendaPorCliente);
                    disp.forward(request, response);
                }
                if(acao.equals("listarTodos")){
                    ArrayList<Venda> listarTodos = new ArrayList<>();
                    listarTodos = vDAO.getLista();
                    RequestDispatcher disp = getServletContext().getRequestDispatcher("/listar_venda.jsp");
                    request.setAttribute("listarTodos", listarTodos);
                    disp.forward(request, response);
                }
                
                
            }catch(Exception e){
                out.print("erro" + e);
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

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
       processRequest(request, response);
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
        processRequest(request, response);
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
