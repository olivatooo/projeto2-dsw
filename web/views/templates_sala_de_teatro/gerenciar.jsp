<%@page import="br.ufscar.dc.dsw.controller.AuthController"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="br.ufscar.dc.dsw.i18n.text" />
<c:set var="laguage" value="${pageContext.response.locale}"/>
<fmt:setLocale value="${language}"/>

<%             
    if ( !AuthController.canAccess(request, response, "admin") )
        return ; 
%>

<jsp:include page="/views/helpers/header.jsp">
    <jsp:param name="title" value="teatros_gerenciar"/>
</jsp:include>
<jsp:include page="/views/helpers/navbar.jsp">
    <jsp:param name="active" value="nothing"/>
</jsp:include>
<div class="ui container">

    <center>
        <h1><fmt:message key="teatro.gerenciamento.h1"/></h1>
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
                <th><fmt:message key="teatro.list.cidade"/></th>
                <th><fmt:message key="teatro.list.email"/></th>
                <th><fmt:message key="teatro.list.cnpj"/></th>
                <th><fmt:message key="teatro.list.nome"/></th>
                <th><fmt:message key="teatro.list.email_vendas"/></th>
                <th><fmt:message key="teatro.list.actions"/></th>
            </tr> 
        </thead>
        <tbody>
            <c:forEach var="teatro" items="${listaTeatros}">
                <tr>
                    <td><c:out value="${teatro.cidade}" /></td>
                    <td><c:out value="${teatro.email}" /></td>
                    <td><c:out value="${teatro.cnpj}" /></td>
                    <td><c:out value="${teatro.nome}" /></td>
                    <td><c:out value="${teatro.site_de_venda_email}" /></td>
                    <td>
                        <a href="edicao_form?id=<c:out value='${teatro.cnpj}' />"><fmt:message key="crud.edit"/></a>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="remocao?cnpj=<c:out value='${teatro.cnpj}' />"
                           onclick="return confirm('<fmt:message key="allform.excluir"/>');">
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
