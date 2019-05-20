<%@page import="br.ufscar.dc.dsw.controller.AuthController"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="br.ufscar.dc.dsw.i18n.text" />
<c:set var="laguage" value="${pageContext.response.locale}"/>
<fmt:setLocale value="${language}"/>

<jsp:include page="/views/helpers/header.jsp">
    <jsp:param name="title" value="promocao_gerenciar"/>
</jsp:include>
<jsp:include page="/views/helpers/navbar.jsp">
    <jsp:param name="active" value="nothing"/>
</jsp:include>
<div class="ui container">

    <center>
        <h1><fmt:message key="promocao.gerenciamento.h1"/></h1>
    </center>
    <br>
    <div style="float: right">
        <div class="ui icon input">
            <input type="text" id="java_is_horrible" onkeyup="filter()">
            <i class="search icon"></i>
        </div>
        <a class="ui positive button" href="cadastro"><i class="plus icon" style="margin-left: 5px"></i></a>
    </div>
    
    <br>
    <br>
    
    <table id="java_is_terrible" class="ui sortable celled table">
        <thead>
            <tr>
                <th><fmt:message key="promocao.list.peca_nome"/></th>
                <th><fmt:message key="promocao.list.preco"/></th>
                <th><fmt:message key="promocao.list.endereco"/></th>
                <th><fmt:message key="promocao.list.cnpj"/></th> <!-- Mudar para nome do teatro? -->
                <th><fmt:message key="promocao.list.data_hora"/></th> <!-- Mudar para nome do teatro? -->
                <th><fmt:message key="teatro.list.actions"/></th>
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
                    <td>
                        <a href="edicao_form?id=<c:out value='${prom.id_promocao}' />"><fmt:message key="crud.edit"/></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="remocao?id=<c:out value='${prom.id_promocao}' />"
                       onclick="return confirm('<fmt:message key="allform.excluir"/>);">
                        <fmt:message key="crud.delete"/>
                    </a>
                </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<script>
    $(document).ready(function () {
        $('table').tablesort();
    });
    
function hasInTd(filter, td) {
    txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
          return true;
      }
      return false;
}

function filter() {
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("java_is_horrible");
  filter = input.value.toUpperCase();
  table = document.getElementById("java_is_terrible");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    tds = tr[i].getElementsByTagName("td");
    if (tds.length) {
        tr[i].style.display = "none";
    }
    for (j = 0; j < tds.length; j++) {
        td = tds[j];
        if (hasInTd(filter, td)) {
            tr[i].style.display = "";
        }
    }       
  }
}

</script>
<jsp:include page="/views/helpers/footer.jsp"/>
