<%@page import="br.ufscar.dc.dsw.controller.AuthController"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="br.ufscar.dc.dsw.i18n.text" />
<c:set var="laguage" value="${pageContext.response.locale}"/>
<fmt:setLocale value="${language}"/>

<jsp:include page="/views/helpers/header.jsp">
    <jsp:param name="title" value="site_gerenciar"/>
</jsp:include>
<jsp:include page="/views/helpers/navbar.jsp">
    <jsp:param name="active" value="nothing"/>
</jsp:include>
<div class="ui container">

    <center>
        <h1><fmt:message key="site.gerenciamento.h1"/></h1>
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
                <th><fmt:message key="site.list.url"/></th>
                <th><fmt:message key="site.list.nome"/></th>
                <th><fmt:message key="site.list.telefone"/></th>
                <th><fmt:message key="site.list.email"/></th>
                <th><fmt:message key="teatro.list.actions"/></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="site" items="${listaSite}">
                <tr>
                    <td><c:out value="${site.url}" /></td>
                    <td><c:out value="${site.nome}" /></td>
                    <td><c:out value="${site.telefone}" /></td>
                    <td><c:out value="${site.email}" /></td>
                    <td>
                        <a href="edicao_form?id=<c:out value='${site.email}' />"><fmt:message key="crud.edit"/></a>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="remocao?id=<c:out value='${site.email}' />"
                           onclick="return confirm('Tem certeza de que deseja excluir este item?');">
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
