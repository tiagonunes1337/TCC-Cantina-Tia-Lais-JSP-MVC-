
package modelo;
import modelo.Fornecedor;

public class Produto {
    private int idProduto;
    private String nome;
    private int quantidade;
    private double valorUnitario;
    private int status;
    private Fornecedor fornecedor;

    public Produto() {
    }

    public Produto(int idProduto, String nome, int quantidade,double valorUnitario, int status, Fornecedor fornecedor) {
        this.idProduto = idProduto;
        this.nome = nome;
        this.quantidade = quantidade;
        this.valorUnitario = valorUnitario;
        this.status = status;
        this.fornecedor = fornecedor;
    }

    public int getIdProduto() {
        return idProduto;
    }

    public void setIdProduto(int idProduto) {
        this.idProduto = idProduto;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
    
    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public double getValorUnitario() {
        return valorUnitario;
    }

    public void setValorUnitario(double valorUnitario) {
        this.valorUnitario = valorUnitario;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Fornecedor getFornecedor() {
        return fornecedor;
    }

    public void setFornecedor(Fornecedor fornecedor) {
        this.fornecedor = fornecedor;
    }

    @Override
    public String toString() {
        return "Produto{" + "idProduto=" + idProduto + ", nome=" + nome + ", quantidade=" + quantidade + ", valorUnitario=" + valorUnitario + ", status=" + status + ", fornecedor=" + fornecedor + '}';
    }


    
    
}
