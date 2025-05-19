package model;

public class Users {


    private int idUser;
    private String nome;
    private String email;
    private String senha;
    private String cpf;
    private boolean status;
    private String grupo;

    //metodo construtor vazio para boas praticas
    public Users(String iduser, String name, String email, String senha, String cpf, boolean status, String grupo) {
    }

    //metodo construtor pra instancia visando INSERT
    public Users(String nome, String email, String senha, String cpf, boolean status, String grupo) {
        this.nome = nome;
        this.email = email;
        this.senha = senha;
        this.cpf = cpf;
        this.status = status;
        this.grupo = grupo;
    }

    //metodo construtor pra instancia visando UPDATE/SELECT
    public Users(int idUser, String nome, String email, String senha, String cpf, boolean status, String grupo) {
        this.idUser = idUser;
        this.nome = nome;
        this.email = email;
        this.senha = senha;
        this.cpf = cpf;
        this.status = status;
        this.grupo = grupo;
    }


    public int getIdUser() {
        return idUser;
    }


    public String getNome() {
        return nome;
    }


    public String getEmail() {
        return email;
    }


    public String getSenha() {
        return senha;
    }


    public String getCpf() {
        return cpf;
    }


    public boolean isStatus() {
        return status;
    }


    public String getGrupo() {
        return grupo;
    }


    @Override
    public String toString() {
        return "User{" +
                "idUser=" + idUser +
                ", nome='" + nome + '\'' +
                ", email='" + email + '\'' +
                ", cpf='" + cpf + '\'' +
                ", status=" + status +
                ", grupo='" + grupo + '\'' +
                '}';
    }
}


