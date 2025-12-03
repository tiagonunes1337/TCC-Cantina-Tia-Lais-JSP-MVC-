/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author 377457
 */
public class Venda {
    private int idVendas;
    private Date dataVenda;
    private double Total;
    private Usuario vendedor;
    private Cliente cliente;
    private ArrayList<VendaProduto> carrinho;
    private int status;

    public Venda() {
    }

    public Venda(int idVendas, Date dataVenda, double Total, Usuario vendedor, Cliente cliente, ArrayList<VendaProduto> carrinho, int status) {
        this.idVendas = idVendas;
        this.dataVenda = dataVenda;
        this.Total = Total;
        this.vendedor = vendedor;
        this.cliente = cliente;
        this.carrinho = carrinho;
        this.status = status;
    }

    public int getIdVendas() {
        return idVendas;
    }

    public void setIdVendas(int idVendas) {
        this.idVendas = idVendas;
    }

    public Date getDataVenda() {
        return dataVenda;
    }

    public void setDataVenda(Date dataVenda) {
        this.dataVenda = dataVenda;
    }

    public double getTotal() {
        return Total;
    }

    public void setTotal(double Total) {
        this.Total = Total;
    }
    
    public Usuario getVendedor() {
        return vendedor;
    }

    public void setVendedor(Usuario vendedor) {
        this.vendedor = vendedor;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public ArrayList<VendaProduto> getCarrinho() {
        return carrinho;
    }

    public void setCarrinho(ArrayList<VendaProduto> carrinho) {
        this.carrinho = carrinho;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Venda{" + "idVendas=" + idVendas + ", dataVenda=" + dataVenda + ", Total=" + Total + ", vendedor=" + vendedor + ", cliente=" + cliente + ", carrinho=" + carrinho + ", status=" + status + '}';
    }

    

    
}
