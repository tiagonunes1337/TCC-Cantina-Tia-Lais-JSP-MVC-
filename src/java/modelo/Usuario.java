/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.util.Date;
import modelo.Perfil;

/**
 *
 * @author adm_pfelacio
 */
public class Usuario {
    
    private int idUsuario;
    private String nome_RazaoSocial;
    private String login;
    private String senha;
    private String CPF;
    private int RG;
    private String telefone;
    private String endereco;
    private String estado;
    private Date dataNasc;
    private int status;
    private Perfil perfil;

    public Usuario() {
    }

    public Usuario(int idUsuario, String nome_RazaoSocial, String login, String senha, String CPF, int RG, String telefone, String endereco, String estado, Date dataNasc, int status, Perfil perfil) {
        this.idUsuario = idUsuario;
        this.nome_RazaoSocial = nome_RazaoSocial;
        this.login = login;
        this.senha = senha;
        this.CPF = CPF;
        this.RG = RG;
        this.telefone = telefone;
        this.endereco = endereco;
        this.estado = estado;
        this.dataNasc = dataNasc;
        this.status = status;
        this.perfil = perfil;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNome_RazaoSocial() {
        return nome_RazaoSocial;
    }

    public void setNome_RazaoSocial(String nome_RazaoSocial) {
        this.nome_RazaoSocial = nome_RazaoSocial;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getCPF() {
        return CPF;
    }

    public void setCPF(String CPF) {
        this.CPF = CPF;
    }

    public int getRG() {
        return RG;
    }

    public void setRG(int RG) {
        this.RG = RG;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getDataNasc() {
        return dataNasc;
    }

    public void setDataNasc(Date dataNasc) {
        this.dataNasc = dataNasc;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Perfil getPerfil() {
        return perfil;
    }

    public void setPerfil(Perfil perfil) {
        this.perfil = perfil;
    }

    @Override
    public String toString() {
        return "Usuario{" + "idUsuario=" + idUsuario + ", nome=" + nome_RazaoSocial + ", login=" + login + ", senha=" + senha + ", CPF=" + CPF + ", RG=" + RG + ", telefone=" + telefone + ", endereco=" + endereco + ", estado=" + estado + ", dataNasc=" + dataNasc + ", status=" + status + ", perfil=" + perfil + '}';
    }
    
}
