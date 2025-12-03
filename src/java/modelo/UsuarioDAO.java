package modelo;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UsuarioDAO extends DataBaseDAO {

    public UsuarioDAO() throws ClassNotFoundException {
    }

    public ArrayList<Usuario> getLista() {

        ArrayList<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuario";

        try {
            this.conectar();
            try (PreparedStatement pstm = conn.prepareStatement(sql);
                 ResultSet rs = pstm.executeQuery()) {

                while (rs.next()) {
                    Usuario u = new Usuario();
                    // CORREÇÃO: Removidos os apelidos "u." (não existem no SELECT *)
                    u.setIdUsuario(rs.getInt("idUsuario"));
                    u.setNome_RazaoSocial(rs.getString("nome_RazaoSocial"));
                    u.setLogin(rs.getString("login"));
                    u.setSenha(rs.getString("senha"));
                    u.setCPF(rs.getString("CPF"));
                    u.setRG(rs.getInt("RG")); 
                    u.setTelefone(rs.getString("telefone"));
                    u.setEndereco(rs.getString("endereco"));
                    u.setEstado(rs.getString("estado"));
                    u.setStatus(rs.getInt("status"));
                    u.setDataNasc(rs.getDate("dataNasc"));

                    try {
                        PerfilDAO pDAO = new PerfilDAO();
                        u.setPerfil(pDAO.getCarregaPorID(rs.getInt("Perfil_idPerfil")));
                    } catch (ClassNotFoundException ex) {
                        Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    lista.add(u);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            this.desconectar();
        }
        return lista;
    }

    public boolean gravar(Usuario u) {
        // ... (Seu método gravar está OK, pois não usa ResultSet) ...
        // [Código do 'gravar' omitido por ser idêntico]
        boolean sucesso = false;
        String sql;
        
        if(u.getIdUsuario()==0){
            sql = "INSERT INTO usuario (nome_RazaoSocial, login, senha, CPF, RG, telefone, endereco, estado, dataNasc, status, Perfil_idPerfil) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        }else{
            sql = "UPDATE usuario SET nome_RazaoSocial=?, login=?, senha=?, CPF=?, RG=?, telefone=?, endereco=?, estado=?, dataNasc=?, status=?, Perfil_idPerfil=? WHERE idUsuario=?";
        }
        try{
            this.conectar();
            try(PreparedStatement pstm = conn.prepareStatement(sql)){
                pstm.setString(1, u.getNome_RazaoSocial());
                pstm.setString(2, u.getLogin());
                pstm.setString(3, u.getSenha());
                pstm.setString(4, u.getCPF());
                pstm.setInt(5, u.getRG());
                pstm.setString(6, u.getTelefone());
                pstm.setString(7, u.getEndereco());
                pstm.setString(8, u.getEstado());
                pstm.setDate(9,new Date(u.getDataNasc().getTime()));
                pstm.setInt(10, u.getStatus());
                pstm.setInt(11,u.getPerfil().getIdPerfil());
                if(u.getIdUsuario()>0){
                    pstm.setInt(12, u.getIdUsuario());
                }
                int rowsAffected = pstm.executeUpdate();
                if(rowsAffected > 0){
                    sucesso = true;
                }
            }
        }catch(SQLException e){
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, e);
        }finally{
            this.desconectar();
        }
        return sucesso;
    }

    public Usuario getCarregaPorID(int idUsuario) {

        Usuario u = null;
        String sql = "SELECT * FROM usuario WHERE idUsuario = ?";
        try {
            this.conectar();
            try (PreparedStatement pstm = conn.prepareStatement(sql)) {
                pstm.setInt(1, idUsuario);

                try (ResultSet rs = pstm.executeQuery()) {
                    if (rs.next()) {
                        u = new Usuario();
                        // CORREÇÃO: Removidos os apelidos "u."
                        u.setIdUsuario(rs.getInt("idUsuario"));
                        u.setNome_RazaoSocial(rs.getString("nome_RazaoSocial"));
                        u.setLogin(rs.getString("login"));
                        u.setSenha(rs.getString("senha"));
                        u.setCPF(rs.getString("CPF"));
                        u.setRG(rs.getInt("RG"));
                        u.setTelefone(rs.getString("telefone"));
                        u.setEndereco(rs.getString("endereco"));
                        u.setEstado(rs.getString("estado"));
                        u.setStatus(rs.getInt("status"));
                        u.setDataNasc(rs.getDate("dataNasc"));

                        try {
                            PerfilDAO pDAO = new PerfilDAO();
                            u.setPerfil(pDAO.getCarregaPorID(rs.getInt("Perfil_idPerfil")));
                        } catch (ClassNotFoundException ex) {
                            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            this.desconectar();
        }
        return u;
    }

    public boolean desativar(Usuario u) {
        // ... (Seu método desativar está OK) ...
        // [Código omitido por ser idêntico]
         boolean sucesso = false;
        try{
            this.conectar();
            String SQL = "UPDATE usuario SET status=2 WHERE idUsuario=?";
            try(PreparedStatement pstm = conn.prepareStatement(SQL)){
                pstm.setInt(1, u.getIdUsuario());
                int rowsffected = pstm.executeUpdate();
                if(rowsffected > 0){
                    sucesso = true;
                }
            }
        
        }catch(SQLException e){
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, e);
        }finally{
            this.desconectar();
        }
        return sucesso;
    }

    public Usuario getRecuperarUsuario(String login) {

        Usuario u = null;
        // CORREÇÃO: SQL precisa ter o 'u.' no WHERE
        String sql = "SELECT u.*, p.nome FROM usuario u INNER JOIN perfil p ON p.idPerfil = u.Perfil_idPerfil WHERE u.login = ?";
        
        try {
            this.conectar();
            try (PreparedStatement pstm = conn.prepareStatement(sql)) {
                pstm.setString(1, login);

                try (ResultSet rs = pstm.executeQuery()) {
                    if (rs.next()) {
                        u = new Usuario();
                        // CORREÇÃO: Removidos os apelidos "u." do ResultSet
                        u.setIdUsuario(rs.getInt("idUsuario"));
                        u.setNome_RazaoSocial(rs.getString("nome_RazaoSocial"));
                        u.setLogin(rs.getString("login"));
                        u.setSenha(rs.getString("senha"));
                        u.setCPF(rs.getString("CPF"));
                        u.setRG(rs.getInt("RG"));
                        u.setTelefone(rs.getString("telefone"));
                        u.setEndereco(rs.getString("endereco"));
                        u.setEstado(rs.getString("estado"));
                        u.setStatus(rs.getInt("status"));
                        u.setDataNasc(rs.getDate("dataNasc"));

                        try {
                            PerfilDAO pDAO = new PerfilDAO();
                            // A FK no ResultSet não tem o "u."
                            u.setPerfil(pDAO.getCarregaPorID(rs.getInt("Perfil_idPerfil"))); 
                        } catch (ClassNotFoundException ex) {
                            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, "ERRO NO SQL DO LOGIN", e);
        } finally {
            this.desconectar();
        }
        return u; // Retorna null se o SQL falhar ou o usuário não existir
    }
}