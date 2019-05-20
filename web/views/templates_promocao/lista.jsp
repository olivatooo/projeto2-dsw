<%@page import="br.ufscar.dc.dsw.controller.AuthController"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="br.ufscar.dc.dsw.i18n.text" />
<c:set var="laguage" value="${pageContext.response.locale}"/>
<fmt:setLocale value="${language}"/>

<jsp:include page="/views/helpers/header.jsp">
    <jsp:param name="title" value="promocao_list"/>
</jsp:include>
<jsp:include page="/views/helpers/navbar.jsp">
    <jsp:param name="active" value="nothing"/>
</jsp:include>

<div class="ui container">
    <center>
        <h1><fmt:message key="promocao.list.h1"/></h1>
        <br>
    </center>
    <div class="ui centered grid">
        <div class="six wide column">
            <form class="ui form" action="lista" method="POST">
                <div class="fields">
                    <div class="twelve wide field">
                        <label><fmt:message key="promocao.list.busca"/></label>
                        <input type="text" id="busca" name="busca"/>
                    </div>
                    <div class="four wide field">
                        <input class="ui button" type="submit" style="margin-top: 24px; width: 100%">
                    </div>
                </div>
            </form>
        </div>
    </div>
    <table class="ui sortable celled table">
        <thead>
            <tr>
                <th><fmt:message key="promocao.list.peca_nome"/></th>
                <th><fmt:message key="promocao.list.preco"/></th>
                <th><fmt:message key="promocao.list.endereco"/></th>
                <th><fmt:message key="promocao.list.cnpj"/></th> <!-- Mudar para nome do teatro? -->
                <th><fmt:message key="promocao.list.data_hora"/></th> <!-- Mudar para nome do teatro? -->
            </tr>
        </thead>
        <tbody>
            <c:forEach var="prom" items="${listaPromocao}">
                <tr>
                    <td><c:out value="${prom.nome_peca}" /></td>
                    <td><c:out value="${prom.preco}" /></td>
                    <td><c:out value="${prom.endereco_url}" /></td>
                    <td><c:out value="${prom.cnpj_teatro}" /></td>
                    <td><c:out value="${prom.datetime}" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
            <script>
                $(document).ready(function () {
                   $('table').tablesort(); 
                });
            </script>

<jsp:include page="/views/helpers/footer.jsp"/>
