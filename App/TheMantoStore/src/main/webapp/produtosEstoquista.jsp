<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestão de Produtos</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container d-flex justify-content-between align-items-center">
            <a class="navbar-brand" href="#">Gestão de Produtos</a>
            <form class="d-flex w-50">
                <div class="input-group">
                    <input type="text" id="filtroNome" class="form-control rounded-pill ps-2" placeholder="Buscar produto..." onkeyup="filtrarProdutos()" style="height: 45px;">
                </div>
            </form>
            <a href="/logout" class="btn btn-danger">Sair</a>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="text-center">Produtos</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Código</th>
                    <th>Nome</th>
                    <th>Preço</th>
                    <th>Quantidade</th>
                    <th>Status</th>
                    <th>Opções</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="produto" items="${produtos}" varStatus="status">
                        <tr>
                            <td>${produto.id}</td>
                            <td>${produto.nomeProduto}</td>
                            <td>${produto.preco}</td>
                            <td>${produto.qtdEstoque}</td>
                            <td>${produto.status ? 'Ativo' : 'Inativo'}</td>
                            <td>
                                <a href="/editarProduto/${produto.codigo}" class="btn btn-warning btn-sm">Editar</a>
                            </td>
                        </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
