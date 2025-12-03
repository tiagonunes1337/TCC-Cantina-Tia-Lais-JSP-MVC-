/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author 377457
 */
public class VendaProduto {
    private long idVP;
    private int quantidadeVendido;
    private double valorVendido;
    private Venda venda;
    private Produto produto;

    public VendaProduto() {
    }

    public VendaProduto(long idVP, int quantidadeVendido, double valorVendido, Venda venda, Produto produto) {
        this.idVP = idVP;
        this.quantidadeVendido = quantidadeVendido;
        this.valorVendido = valorVendido;
        this.venda = venda;
        this.produto = produto;
    }

    public long getIdVP() {
        return idVP;
    }

    public void setIdVP(long idVP) {
        this.idVP = idVP;
    }

    public int getQuantidadeVendido() {
        return quantidadeVendido;
    }

    public void setQuantidadeVendido(int quantidadeVendido) {
        this.quantidadeVendido = quantidadeVendido;
    }

    public double getValorVendido() {
        return valorVendido;
    }

    public void setValorVendido(double valorVendido) {
        this.valorVendido = valorVendido;
    }

    public Venda getVenda() {
        return venda;
    }

    public void setVenda(Venda venda) {
        this.venda = venda;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }

    @Override
    public String toString() {
        return "VendaProduto{" + "idVP=" + idVP + ", quantidadeVendido=" + quantidadeVendido + ", valorVendido=" + valorVendido + ", venda=" + venda + ", produto=" + produto + '}';
    }
    
    
}
