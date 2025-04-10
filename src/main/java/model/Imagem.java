package model;

public class Imagem {

    private int idImage;
    private int produtoId;
    private String nomeArquivo;
    private String caminhoArquivo;
    private boolean imagemPadrao;

    public Imagem(int idImage, int produtoId, String nomeArquivo, String caminhoArquivo, boolean imagemPadrao) {
        this.idImage = idImage;
        this.produtoId = produtoId;
        this.nomeArquivo = nomeArquivo;
        this.caminhoArquivo = caminhoArquivo;
        this.imagemPadrao = imagemPadrao;
    }

    public int getIdImage() {
        return idImage;
    }

    public int getProdutoId() {
        return produtoId;
    }

    public void setProdutoId(int produtoId) {
        this.produtoId = produtoId;
    }

    public String getNomeArquivo() {
        return nomeArquivo;
    }

    public String getCaminhoArquivo() {
        return caminhoArquivo;
    }

    public boolean isImagemPadrao() {
        return imagemPadrao;
    }

}
