package model;

public class CarrinhoItem {

    private Produtos produto;
    private int quantidade;

    public CarrinhoItem(Produtos produto, int quantidade) {
        this.produto = produto;
        this.quantidade = quantidade;
    }

    public Produtos getProduto() {
        return produto;
    }

    public void setProduto(Produtos produto) {
        this.produto = produto;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }
}
