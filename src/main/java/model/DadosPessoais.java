package model;

import java.sql.Date;

public class DadosPessoais {

    private int id; // ID da tabela DADOS_PESSOAIS
    private int idUser; // FK para USERS
    private Date dataNascimento;
    private String genero;

    public DadosPessoais() {
    }

    public DadosPessoais(int idUser, Date dataNascimento, String genero) {
        this.idUser = idUser;
        this.dataNascimento = dataNascimento;
        this.genero = genero;
    }

    public DadosPessoais(int id, int idUser, Date dataNascimento, String genero) {
        this.id = id;
        this.idUser = idUser;
        this.dataNascimento = dataNascimento;
        this.genero = genero;
    }

    // Getters e Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public Date getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(Date dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }
}
