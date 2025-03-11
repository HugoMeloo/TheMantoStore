package model;

public class Produtos {

    private int id;
    private String nomeProduto;
    private double avaliacao;
    private String descricao;
    private double preco;
    private int qtdEstoque;
    private boolean status;

    public Produtos(String nome) {
        this.nomeProduto = nome;
    }

    public Produtos(int id, String nomeProduto, double avaliacao, String descricao, double preco, int qtdEstoque, boolean status) {
        this.id = id;
        this.nomeProduto = nomeProduto;
        this.avaliacao = avaliacao;
        this.descricao = descricao;
        this.preco = preco;
        this.qtdEstoque = qtdEstoque;
        this.status = status;

    }

    public int getId() {
        return id;
    }

    public String getNomeProduto() {
        return nomeProduto;
    }

    public double getAvaliacao() {
        return avaliacao;
    }

    public String getDescricao() {
        return descricao;
    }

    public double getPreco() {
        return preco;
    }

    public int getQtdEstoque() {
        return qtdEstoque;
    }

    public boolean isStatus() {
        return status;
    }

}
