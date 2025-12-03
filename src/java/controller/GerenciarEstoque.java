package controller;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Produto;
import modelo.ProdutoDAO;

@WebServlet(name = "GerenciarEstoque", urlPatterns = {"/gerenciar_estoque.do"})
public class GerenciarEstoque extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String acao = request.getParameter("acao");
        
        try {
            ProdutoDAO pDAO = new ProdutoDAO();
            
            // 1. LISTAR NA TELA (Padrão)
            if ("listar".equals(acao)) {
                if (GerenciarLogin.verificarPermissao(request, response)) {
                    ArrayList<Produto> lista = pDAO.getLista();
                    request.setAttribute("listaEstoque", lista);
                    RequestDispatcher disp = getServletContext().getRequestDispatcher("/listar_estoque.jsp");
                    disp.forward(request, response);
                } else {
                    response.getWriter().print("Acesso Negado");
                }
            
            // 2. GERAR PDF (Nova Ação)
            } else if ("gerarPDF".equals(acao)) {
                if (GerenciarLogin.verificarPermissao(request, response)) {
                    ArrayList<Produto> lista = pDAO.getLista();
                    gerarPDF(response, lista);
                } else {
                    response.getWriter().print("Acesso Negado");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Método Auxiliar para desenhar o PDF
    private void gerarPDF(HttpServletResponse response, ArrayList<Produto> lista) throws Exception {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Relatorio_Estoque.pdf");
        
        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();
        
        // Título
        Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.BLACK);
        Paragraph titulo = new Paragraph("Relatório de Saldo em Estoque", fontTitulo);
        titulo.setAlignment(Element.ALIGN_CENTER);
        titulo.setSpacingAfter(20);
        document.add(titulo);
        
        // Data de Emissão
        Paragraph data = new Paragraph("Emissão: " + new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new Date()));
        data.setSpacingAfter(20);
        document.add(data);
        
        // Tabela
        PdfPTable tabela = new PdfPTable(5); // 5 Colunas
        tabela.setWidthPercentage(100);
        tabela.setWidths(new float[]{1, 4, 3, 2, 2}); // Larguras das colunas
        
        // Cabeçalhos
        String[] colunas = {"ID", "Produto", "Fornecedor", "Qtd", "Status"};
        for(String s : colunas){
            PdfPCell cell = new PdfPCell(new Phrase(s, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12)));
            cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(5);
            tabela.addCell(cell);
        }
        
        // Dados
        for(Produto p : lista){
            tabela.addCell(String.valueOf(p.getIdProduto()));
            tabela.addCell(p.getNome());
            
            // Verifica se fornecedor existe para evitar erro
            String nomeFornecedor = (p.getFornecedor() != null) ? p.getFornecedor().getNome_RazaoSocial() : "N/A";
            tabela.addCell(nomeFornecedor);
            
            // Quantidade com destaque visual simples (se for pouco)
            PdfPCell cellQtd = new PdfPCell(new Phrase(String.valueOf(p.getQuantidade())));
            if(p.getQuantidade() < 10) {
                cellQtd.setBackgroundColor(new BaseColor(255, 200, 200)); // Fundo vermelho claro se estiver acabando
            }
            tabela.addCell(cellQtd);
            
            String statusTexto;
            if (p.getStatus() == 2) {
                statusTexto = "Indisponível (Desativado)";
            } else if (p.getQuantidade() > 0) {
                statusTexto = "Disponível";
            } else {
                statusTexto = "Esgotado";
            }
                tabela.addCell(statusTexto);
            }
        
        document.add(tabela);
        document.close();
    }
}