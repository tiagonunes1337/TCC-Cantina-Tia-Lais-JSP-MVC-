/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author 377457
 */
public class VendaDAO extends DataBaseDAO {
    
    public VendaDAO() throws ClassNotFoundException {
    }
    
  public boolean gravar(Venda v) {
    boolean sucesso = false;
    String sql;

    if (v.getIdVendas() == 0) {
        sql = "INSERT INTO vendas (Total, Usuario_idUsuario, Cliente_idCliente , status, dataVenda) VALUES (?,?,?,?,now())";
    } else {
        sql = "UPDATE vendas SET Total=?, Usuario_idUsuario=?, Cliente_idCliente=?, status=? WHERE idVendas=?";
    }
    
    try {
        this.conectar();

        if (v.getIdVendas() > 0) {
            String sqlBuscaAntigos = "SELECT Produto_idProduto, quantidade FROM vendas_produto WHERE Vendas_idVendas = ?";
            try (PreparedStatement pstmBusca = conn.prepareStatement(sqlBuscaAntigos)) {
                pstmBusca.setInt(1, v.getIdVendas());
                try (ResultSet rs = pstmBusca.executeQuery()) {
                    while (rs.next()) {
                        String sqlDevolve = "UPDATE produto SET quantidade = quantidade + ? WHERE idProduto = ?";
                        try (PreparedStatement pstmDevolve = conn.prepareStatement(sqlDevolve)) {
                            pstmDevolve.setInt(1, rs.getInt("quantidade"));
                            pstmDevolve.setInt(2, rs.getInt("Produto_idProduto"));
                            pstmDevolve.executeUpdate();
                        }
                    }
                }
            }
            String sqlLimpa = "DELETE FROM vendas_produto WHERE Vendas_idVendas = ?";
            try (PreparedStatement pstmLimpa = conn.prepareStatement(sqlLimpa)) {
                pstmLimpa.setInt(1, v.getIdVendas());
                pstmLimpa.executeUpdate();
            }
        }
        try (PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstm.setDouble(1, v.getTotal());
            pstm.setInt(2, v.getVendedor().getIdUsuario());
            pstm.setInt(3, v.getCliente().getIdCliente());
            pstm.setInt(4, v.getStatus());
            
            if (v.getIdVendas() > 0) {
                pstm.setInt(5, v.getIdVendas());
            }
            
            int rowsAffected = pstm.executeUpdate();

            if (rowsAffected > 0) {
                if (v.getIdVendas() == 0) {
                    ResultSet rs = pstm.getGeneratedKeys();
                    if (rs.next()) {
                        v.setIdVendas(rs.getInt(1)); 
                    }
                }
                if (v.getCarrinho() != null) {
                    for (VendaProduto vp : v.getCarrinho()) {
                        // Insere o item na venda
                        String sql_item = "INSERT INTO vendas_produto (Vendas_idVendas, Produto_idProduto, quantidade, valorDeVenda) Values (?,?,?,?)";
                        try (PreparedStatement pstm_item = conn.prepareStatement(sql_item)) {
                            pstm_item.setInt(1, v.getIdVendas());
                            pstm_item.setInt(2, vp.getProduto().getIdProduto());
                            pstm_item.setInt(3, vp.getQuantidadeVendido());
                            pstm_item.setDouble(4, vp.getValorVendido());
                            pstm_item.executeUpdate();
                        }

                        // Baixa do estoque (SUBTRAI)
                        String sql_baixa = "UPDATE produto SET quantidade = quantidade - ? WHERE idProduto = ?";
                        try (PreparedStatement pstm_baixa = conn.prepareStatement(sql_baixa)) {
                            pstm_baixa.setInt(1, vp.getQuantidadeVendido()); 
                            pstm_baixa.setInt(2, vp.getProduto().getIdProduto());
                            pstm_baixa.executeUpdate();
                        }
                    }
                }
                
                sucesso = true; 
            }
        }
    } catch (SQLException e) {
        Logger.getLogger(VendaDAO.class.getName()).log(Level.SEVERE, "Erro ao gravar venda", e);
    } finally {
        this.desconectar();
    }
    return sucesso;
}
    
    public ArrayList<Venda> getLista() throws ClassNotFoundException{
        
        ArrayList<Venda> lista = new ArrayList<>();
        String sql = "SELECT * FROM vendas";
        
        try{
            ClienteDAO cDAO = new ClienteDAO();
            UsuarioDAO uDAO = new UsuarioDAO();
            this.conectar();
            //Usando try-with-resources para PreparedStatement e ResultSet
            try(PreparedStatement pstm = conn.prepareStatement(sql);
                ResultSet rs = pstm.executeQuery()){
                
                while(rs.next()){
                    Venda v =new Venda();
                    v.setIdVendas(rs.getInt("idVendas"));
                    v.setDataVenda(rs.getDate("dataVenda"));
                    v.setTotal(rs.getDouble("Total"));
                    v.setStatus(rs.getInt("status"));
                    v.setCliente(cDAO.getCarregaPorID(rs.getInt("Cliente_idCliente")));
                    v.setVendedor(uDAO.getCarregaPorID(rs.getInt("Usuario_idUsuario")));
                    
                    lista.add(v);
                }
            }
        }catch(SQLException e){
            Logger.getLogger(VendaDAO.class.getName()).log(Level.SEVERE, null,e);
        }finally{
            this.desconectar();
        }
    
     return lista;
    }
    
    
    public Venda getCarregaPorID(int idVenda) throws ClassNotFoundException{
        
        Venda v =null;
        String sql = "SELECT * FROM vendas WHERE idVendas = ?";
        try{
            ClienteDAO cDAO = new ClienteDAO();
            UsuarioDAO uDAO = new UsuarioDAO();
            this.conectar();
            try(PreparedStatement pstm = conn.prepareStatement(sql)){
                pstm.setInt(1, idVenda);
                
                try(ResultSet rs = pstm.executeQuery()){
                    if(rs.next()){
                        v = new Venda();
                        v.setIdVendas(rs.getInt("idVendas"));
                        v.setDataVenda(rs.getDate("dataVenda"));
                        v.setTotal(rs.getDouble("Total"));
                        v.setStatus(rs.getInt("status"));
                        v.setCliente(cDAO.getCarregaPorID(rs.getInt("Cliente_idCliente")));
                        v.setVendedor(uDAO.getCarregaPorID(rs.getInt("Usuario_idUsuario")));
                        v.setCarrinho(this.itensVenda(idVenda));
   
                    }
                }
                
            }
            
        }catch(SQLException e){
            Logger.getLogger(VendaDAO.class.getName()).log(Level.SEVERE, null, e);
        }finally{
            this.desconectar();
        }    
        return v;
    }
    
    public ArrayList<VendaProduto> itensVenda(int idVenda) {
        
        ArrayList<VendaProduto> lista = new ArrayList<>();
        String sql = "SELECT * FROM vendas_produto WHERE idVendas = ?";
        
        try{
            ProdutoDAO pDAO = new ProdutoDAO();
            this.conectar();
            //Usando try-with-resources para PreparedStatement e ResultSet
            try(PreparedStatement pstm = conn.prepareStatement(sql);
                ResultSet rs = pstm.executeQuery()){
                
                while(rs.next()){
                    VendaProduto vp =new VendaProduto();
                    vp.setIdVP(rs.getInt("idVP"));
                    vp.setQuantidadeVendido(rs.getInt("quantidade"));
                    vp.setValorVendido(rs.getDouble("valorDaVenda"));
                    vp.setProduto(pDAO.getCarregaPorID(rs.getInt("idProduto")));
                    
                    lista.add(vp);
                }
            }
        }catch(SQLException e){
            Logger.getLogger(VendaDAO.class.getName()).log(Level.SEVERE, null,e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(VendaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            this.desconectar();
        }
    
     return lista;
    }
    
    public boolean desativar(Venda v) {
    boolean sucesso = false;
    
    try {
        this.conectar();        
        String sqlItens = "SELECT Produto_idProduto, quantidade FROM vendas_produto WHERE Vendas_idVendas = ?";
        
        try (PreparedStatement pstmItens = conn.prepareStatement(sqlItens)) {
            pstmItens.setInt(1, v.getIdVendas());
            
            try (ResultSet rs = pstmItens.executeQuery()) {
                // Para cada item encontrado nessa venda...
                while (rs.next()) {
                    int idProduto = rs.getInt("Produto_idProduto");
                    int qtdVendida = rs.getInt("quantidade");
                    
                    // PASSO 2: Devolver a quantidade ao estoque (SOMA)
                    // UPDATE produto SET quantidade = quantidade + ?
                    String sqlEstorno = "UPDATE produto SET quantidade = quantidade + ? WHERE idProduto = ?";
                    
                    try (PreparedStatement pstmEstorno = conn.prepareStatement(sqlEstorno)) {
                        pstmEstorno.setInt(1, qtdVendida); // Devolve a quantidade
                        pstmEstorno.setInt(2, idProduto);  // Para o produto correto
                        pstmEstorno.executeUpdate();
                    }
                }
            }
        }
        
        // PASSO 3: Agora sim, marca a venda como cancelada (Status 2)
        String sqlStatus = "UPDATE vendas SET status=2 WHERE idVendas=?";
        try (PreparedStatement pstm = conn.prepareStatement(sqlStatus)) {
            pstm.setInt(1, v.getIdVendas());
            int rowsAffected = pstm.executeUpdate();
            if (rowsAffected > 0) {
                sucesso = true;
            }
        }
        
    } catch (SQLException e) {
        Logger.getLogger(VendaDAO.class.getName()).log(Level.SEVERE, "Erro ao cancelar venda e estornar estoque", e);
    } finally {
        this.desconectar();
    }
    
    return sucesso;
}
    
    public boolean finalizar(Venda v) {
    boolean sucesso = false;
    try {
        this.conectar();

        // 1. Descobrir o Status Atual
        int statusAtual = 0;
        String sqlCheck = "SELECT status FROM vendas WHERE idVendas = ?";
        try (PreparedStatement pstmCheck = conn.prepareStatement(sqlCheck)) {
            pstmCheck.setInt(1, v.getIdVendas());
            try (ResultSet rs = pstmCheck.executeQuery()) {
                if (rs.next()) {
                    statusAtual = rs.getInt("status");
                }
            }
        }

        // 2. Se estava CANCELADA (2), precisa baixar o estoque de novo
        if (statusAtual == 2) {
            String sqlItens = "SELECT Produto_idProduto, quantidade FROM vendas_produto WHERE Vendas_idVendas = ?";
            try (PreparedStatement pstmItens = conn.prepareStatement(sqlItens)) {
                pstmItens.setInt(1, v.getIdVendas());
                try (ResultSet rs = pstmItens.executeQuery()) {
                    while (rs.next()) {
                        String sqlBaixa = "UPDATE produto SET quantidade = quantidade - ? WHERE idProduto = ?";
                        try (PreparedStatement pstmBaixa = conn.prepareStatement(sqlBaixa)) {
                            pstmBaixa.setInt(1, rs.getInt("quantidade"));
                            pstmBaixa.setInt(2, rs.getInt("Produto_idProduto"));
                            pstmBaixa.executeUpdate();
                        }
                    }
                }
            }
        }

        // 3. Atualiza o Status para Finalizada (3)
        String SQL = "UPDATE vendas SET status=3 WHERE idVendas=?";
        try (PreparedStatement pstm = conn.prepareStatement(SQL)) {
            pstm.setInt(1, v.getIdVendas());
            if (pstm.executeUpdate() > 0) {
                sucesso = true;
            }
        }

    } catch (Exception e) {
        Logger.getLogger(VendaDAO.class.getName()).log(Level.SEVERE, null, e);
    } finally {
        this.desconectar();
    }
    return sucesso;
}
    
    public ArrayList<Venda> getVendasPorCliente(int idCliente) throws ClassNotFoundException{
        
        ArrayList<Venda> lista = new ArrayList<>();
        String sql = "SELECT * FROM vendas WHERE Cliente_idCliente=?";
        
        try{
            ClienteDAO cDAO = new ClienteDAO();
            UsuarioDAO uDAO = new UsuarioDAO();
            this.conectar();
            //Usando try-with-resources para PreparedStatement e ResultSet
            try(PreparedStatement pstm = conn.prepareStatement(sql)){
                pstm.setInt(1, idCliente);
                try(ResultSet rs = pstm.executeQuery()){
                    while(rs.next()){
                        Venda v =new Venda();
                        v.setIdVendas(rs.getInt("idVendas"));
                        v.setDataVenda(rs.getDate("dataVenda"));
                        v.setTotal(rs.getDouble("Total"));
                        v.setStatus(rs.getInt("status"));
                        v.setCliente(cDAO.getCarregaPorID(rs.getInt("Cliente_idCliente")));
                        v.setVendedor(uDAO.getCarregaPorID(rs.getInt("Usuario_idUsuario")));
                            lista.add(v);
                    }
                }
            }
        }catch(SQLException e){
            Logger.getLogger(VendaDAO.class.getName()).log(Level.SEVERE, null,e);
        }finally{
            this.desconectar();
        }
    
     return lista;
    }
    
    // Arquivo: VendaDAO.java (Adicione este método)
    public ArrayList<Venda> getListaPorData(java.util.Date dataInicio, java.util.Date dataFim) throws ClassNotFoundException{
        ArrayList<Venda> lista = new ArrayList<>();
        // SQL para buscar vendas dentro do intervalo de datas
        String sql="SELECT * FROM vendas WHERE dataVenda BETWEEN ? AND ?";
        try {
            this.conectar();
                ClienteDAO cDAO = new ClienteDAO();
                UsuarioDAO uDAO = new UsuarioDAO();

                try (PreparedStatement pstm = conn.prepareStatement(sql)) {
                // Converte as datas util.Date para sql.Date
                    java.sql.Date dataInicioSql = new java.sql.Date(dataInicio.getTime());
                    java.sql.Date dataFimSql = new java.sql.Date(dataFim.getTime());

                    pstm.setDate(1, dataInicioSql);
                    pstm.setDate(2, dataFimSql);

                    try (ResultSet rs = pstm.executeQuery()) {
                        while (rs.next()) {
                        Venda v = new Venda();
                        v.setIdVendas(rs.getInt("idVendas"));
                        v.setDataVenda(rs.getDate("dataVenda"));
                        v.setTotal(rs.getDouble("Total"));
                        v.setStatus(rs.getInt("status"));

                        // Carrega FKs
                        v.setCliente(cDAO.getCarregaPorID(rs.getInt("Cliente_idCliente")));
                        v.setVendedor(uDAO.getCarregaPorID(rs.getInt("Usuario_idUsuario")));

                        lista.add(v);
                        }
                    }
                }
        } catch (SQLException e) {
            Logger.getLogger(VendaDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            this.desconectar();
        }
    return lista;
    }

}
