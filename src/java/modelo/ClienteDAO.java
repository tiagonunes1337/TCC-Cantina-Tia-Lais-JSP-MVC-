package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ClienteDAO extends DataBaseDAO{
    public ClienteDAO() throws ClassNotFoundException{}
    
    public ArrayList<Cliente> getLista(){
        
        ArrayList<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM Cliente";
        
        try{
            //abre a conexao com o banco
            this.conectar();
            //Usando try-with-resources para PreparedStatement e ResultSet
            try(PreparedStatement pstm = conn.prepareStatement(sql);
                ResultSet rs = pstm.executeQuery()){
                
                while(rs.next()){
                    Cliente c = new Cliente();
                    c.setIdCliente(rs.getInt("idCliente"));
                    c.setNome_RazaoSocial(rs.getString("nome_RazaoSocial"));
                    c.setTipo(rs.getInt("tipo"));
                    c.setCPF_CNPJ(rs.getString("CPF_CNPJ"));
                    c.setStatus(rs.getInt("status"));
                    lista.add(c);
                }
            }
        }catch(SQLException e){
            Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, null,e);
        }finally{
            this.desconectar();
        }
    
     return lista;
    }
    
    public boolean gravar(Cliente c){
        
        boolean sucesso = false;
        String sql;
        
        //define a query dependendo do IdFornecedor
        if(c.getIdCliente()==0){
            sql = "INSERT INTO Cliente (nome_RazaoSocial, tipo, CPF_CNPJ, status) VALUES (?,?,?,?)";
        }else{
            sql = "UPDATE Cliente SET nome_RazaoSocial=?, tipo=?, CPF_CNPJ=?, status=? WHERE idCliente=?";
        }
        try{
            this.conectar();
            //Usando try-with-resources para garantir fechamento do PreparedStatement
            try(PreparedStatement pstm = conn.prepareStatement(sql)){
                pstm.setString(1, c.getNome_RazaoSocial());
                pstm.setInt(2,c.getTipo());
                pstm.setString(3, c.getCPF_CNPJ());
                pstm.setInt(4,c.getStatus());
                
                //verifica se o idFornecedor é maior que zero, se for realiza o UPDaTE
                if(c.getIdCliente()>0){
                    pstm.setInt(5, c.getIdCliente());
                }
                int rowsAffected = pstm.executeUpdate();
                if(rowsAffected > 0){
                    sucesso = true;// a operação foi bem sucedida
                }
                
            }
        }catch(SQLException e){
            Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, null, e);
        }finally{
            this.desconectar();
        }
        return sucesso;
    
    }
    
    public Cliente getCarregaPorID(int idCliente){
        
        Cliente c =null;
        String sql = "SELECT * FROM Cliente WHERE idCliente = ?";
        try{
            this.conectar();
            try(PreparedStatement pstm = conn.prepareStatement(sql)){
                pstm.setInt(1, idCliente);
                
                try(ResultSet rs = pstm.executeQuery()){
                    if(rs.next()){
                        c = new Cliente();
                        c.setIdCliente(rs.getInt("idCliente"));
                        c.setNome_RazaoSocial(rs.getString("nome_RazaoSocial"));
                        c.setTipo(rs.getInt("tipo"));
                        c.setCPF_CNPJ(rs.getString("CPF_CNPJ"));
                        c.setStatus(rs.getInt("status"));
                        
                    }
                }
                
            }
            
        }catch(SQLException e){
            Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, null, e);
        }finally{
            this.desconectar();
        }    
        return c;
    }
    
    public boolean desativar(Cliente c){
    
        boolean sucesso = false;
        try{
            this.conectar();
            String SQL = "UPDATE Cliente SET status=2 WHERE idCliente=?";
            try(PreparedStatement pstm = conn.prepareStatement(SQL)){
                pstm.setInt(1, c.getIdCliente());
                int rowsffected = pstm.executeUpdate();
                if(rowsffected > 0){
                    sucesso = true;
                }
            }
        
        }catch(SQLException e){
            Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, null, e);
        }finally{
            this.desconectar();
        }
        return sucesso;
    }
}