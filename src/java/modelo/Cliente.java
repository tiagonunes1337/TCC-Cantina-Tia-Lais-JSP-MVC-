/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

public class Cliente {
    private int idCliente;
    private String nome_RazaoSocial;
    private int tipo;
    private String CPF_CNPJ;
    private int status;

    public Cliente() {
    }

    public Cliente(int idCliente, String nome_RazaoSocial,int tipo, String CPF_CNPJ, int status) {
        this.idCliente = idCliente;
        this.nome_RazaoSocial = nome_RazaoSocial;
        this.tipo = tipo;
        this.CPF_CNPJ = CPF_CNPJ;
        this.status = status;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getNome_RazaoSocial() {
        return nome_RazaoSocial;
    }

    public void setNome_RazaoSocial(String nome_RazaoSocial) {
        this.nome_RazaoSocial = nome_RazaoSocial;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }
    
    public String getCPF_CNPJ() {
        return CPF_CNPJ;
    }

    public void setCPF_CNPJ(String CPF_CNPJ) {
        this.CPF_CNPJ = CPF_CNPJ;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Cliente{" + "idCliente=" + idCliente + ", nome_RazaoSocial=" + nome_RazaoSocial + ", tipo=" + tipo + ", CPF_CNPJ=" + CPF_CNPJ + ", status=" + status + '}';
    }

    

}
