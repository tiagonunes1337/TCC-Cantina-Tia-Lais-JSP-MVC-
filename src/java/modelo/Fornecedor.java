
package modelo;

public class Fornecedor {
    private int idFornecedor;
    private String nome_RazaoSocial ;
    private String endereco;
    private String estado;
    private String CNPJ;
    private String telefone ;
    private int status;

    public Fornecedor() {
    }

    public Fornecedor(int idFornecedor, String nome_RazaoSocial, String endereco, String estado, String CNPJ, String telefone, int status) {
        this.idFornecedor = idFornecedor;
        this.nome_RazaoSocial = nome_RazaoSocial;
        this.endereco = endereco;
        this.estado = estado;
        this.CNPJ = CNPJ;
        this.telefone = telefone;
        this.status = status;
    }

    public int getIdFornecedor() {
        return idFornecedor;
    }

    public void setIdFornecedor(int idFornecedor) {
        this.idFornecedor = idFornecedor;
    }

    public String getNome_RazaoSocial() {
        return nome_RazaoSocial;
    }

    public void setNome_RazaoSocial(String nome_RazaoSocial) {
        this.nome_RazaoSocial = nome_RazaoSocial;
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

    public String getCNPJ() {
        return CNPJ;
    }

    public void setCNPJ(String CNPJ) {
        this.CNPJ = CNPJ;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Fornecedor{" + "idFornecedor=" + idFornecedor + ", nome_RazaoSocial=" + nome_RazaoSocial + ", endereco=" + endereco + ", estado=" + estado + ", CNPJ=" + CNPJ + ", telefone=" + telefone + ", status=" + status + '}';
    }

      
}
