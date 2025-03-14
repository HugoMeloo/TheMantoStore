package model;

import java.util.List;

public class Produtos {
    private int id;
    private String nomeProduto;
    private double avaliacao;
    private String descricao;
    private double preco;
    private int qtdEstoque;
    private boolean status;
    private List<Imagem> imagens; // Adicionando suporte para imagens

    // Construtor atualizado (sem imagens)
    public Produtos(int id, String nomeProduto, double avaliacao, String descricao, double preco, int qtdEstoque, boolean status) {
        this.id = id;
        this.nomeProduto = nomeProduto;
        this.avaliacao = avaliacao;
        this.descricao = descricao;
        this.preco = preco;
        this.qtdEstoque = qtdEstoque;
        this.status = status;
    }

    // Getter e Setter para imagens
    public List<Imagem> getImagens() {
        return imagens;
    }

    public void setImagens(List<Imagem> imagens) {
        this.imagens = imagens;
    }

    // Outros Getters e Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomeProduto() {
        return nomeProduto;
    }

    public void setNomeProduto(String nomeProduto) {
        this.nomeProduto = nomeProduto;
    }

    public double getAvaliacao() {
        return avaliacao;
    }

    public void setAvaliacao(double avaliacao) {
        this.avaliacao = avaliacao;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public double getPreco() {
        return preco;
    }

    public void setPreco(double preco) {
        this.preco = preco;
    }

    public int getQtdEstoque() {
        return qtdEstoque;
    }

    public void setQtdEstoque(int qtdEstoque) {
        this.qtdEstoque = qtdEstoque;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
