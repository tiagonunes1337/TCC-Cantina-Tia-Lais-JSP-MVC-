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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Venda;
import modelo.VendaDAO;


@WebServlet(name = "GerenciarRelatorio", urlPatterns = {"/gerenciar_relatorio.do"})
public class GerenciarRelatorio extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (GerenciarLogin.verificarPermissao(request, response)) {
            RequestDispatcher disp = getServletContext().getRequestDispatcher("/form_relatorio_venda.jsp");
            disp.forward(request, response);
        } else {
            exibirMensagem("Acesso Negado", false, "", response);
        }
    }

    // doPost: Processa o relatório (Tela ou PDF)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String acao = request.getParameter("acao");
        
        try {
            if (GerenciarLogin.verificarPermissao(request, response)) {
                
                // 1. Pegar e Validar Datas
                String dataInicioStr = request.getParameter("dataInicio");
                String dataFimStr = request.getParameter("dataFim");

                if (dataInicioStr == null || dataInicioStr.isEmpty() || dataFimStr == null || dataFimStr.isEmpty()) {
                    exibirMensagem("Por favor, preencha ambas as datas.", false, "form_relatorio_venda.jsp", response);
                    return;
                }

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dataInicio = sdf.parse(dataInicioStr);
                Date dataFim = sdf.parse(dataFimStr);
                
                // 2. Buscar Dados no Banco
                VendaDAO vDAO = new VendaDAO();
                ArrayList<Venda> lista = vDAO.getListaPorData(dataInicio, dataFim);
                
                // 3. Decidir: Tela ou PDF?
                if ("gerarPDF".equals(acao)) {
                    
                    // --- LÓGICA DE GERAÇÃO DE PDF (iText) ---
                    response.setContentType("application/pdf");
                    response.setHeader("Content-Disposition", "attachment; filename=Relatorio_Vendas.pdf");
                    
                    Document document = new Document();
                    PdfWriter.getInstance(document, response.getOutputStream());
                    
                    document.open();
                    
                    // Título
                    Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.BLACK);
                    Paragraph titulo = new Paragraph("Relatório de Vendas - Cantina da Tia Laís", fontTitulo);
                    titulo.setAlignment(Element.ALIGN_CENTER);
                    titulo.setSpacingAfter(20);
                    document.add(titulo);
                    
                    // Subtítulo (Período)
                    SimpleDateFormat sdfBr = new SimpleDateFormat("dd/MM/yyyy");
                    Paragraph periodo = new Paragraph("Período: " + sdfBr.format(dataInicio) + " até " + sdfBr.format(dataFim));
                    periodo.setSpacingAfter(20);
                    periodo.setAlignment(Element.ALIGN_CENTER);
                    document.add(periodo);
                    
                    // Tabela
                    PdfPTable tabela = new PdfPTable(5); // 5 Colunas
                    tabela.setWidthPercentage(100);
                    tabela.setWidths(new float[]{1, 3, 3, 2, 2}); // Largura relativa das colunas
                    
                    // Cabeçalhos
                    String[] colunas = {"ID", "Vendedor", "Cliente", "Data", "Total"};
                    for(String s : colunas){
                        PdfPCell cell = new PdfPCell(new Phrase(s, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12)));
                        cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
                        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                        cell.setPadding(5);
                        tabela.addCell(cell);
                    }
                    
                    // Dados
                    for(Venda v : lista){
                        tabela.addCell(String.valueOf(v.getIdVendas()));
                        tabela.addCell(v.getVendedor().getNome_RazaoSocial());
                        tabela.addCell(v.getCliente().getNome_RazaoSocial());
                        tabela.addCell(sdfBr.format(v.getDataVenda()));
                        tabela.addCell("R$ " + String.format("%.2f", v.getTotal()));
                    }
                    
                    document.add(tabela);
                    document.close();
                    
                } else {
                    // --- LÓGICA DE LISTAR NA TELA (Padrão) ---
                    request.setAttribute("vendasFiltradas", lista);
                    RequestDispatcher disp = getServletContext().getRequestDispatcher("/listar_relatorio_venda.jsp");
                    disp.forward(request, response);
                }

            } else {
                exibirMensagem("Acesso Negado", false, "", response);
            }

        } catch (Exception e) {
            Logger.getLogger(GerenciarRelatorio.class.getName()).log(Level.SEVERE, "Erro no relatório", e);
            // Se for erro de PDF, não dá pra exibir alert facilmente pois o stream já abriu
            if(!"gerarPDF".equals(acao)){
                exibirMensagem("Erro ao gerar relatório: " + e.getMessage(), false, "", response);
            }
        }
    }

    private void exibirMensagem(String mensagem, boolean resposta, String link, HttpServletResponse response) {
        try {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('" + mensagem.replace("'", "\\'") + "');");
            if (resposta && link != null && !link.isEmpty()) {
                out.println("location.href='" + link + "';");
            } else {
                out.println("history.back();");
            }
            out.println("</script>");
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}