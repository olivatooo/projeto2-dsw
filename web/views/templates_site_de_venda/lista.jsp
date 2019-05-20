<%@page import="br.ufscar.dc.dsw.controller.AuthController"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="br.ufscar.dc.dsw.i18n.text" />
<c:set var="laguage" value="${pageContext.response.locale}"/>
<fmt:setLocale value="${language}"/>

<jsp:include page="/views/helpers/header.jsp">
    <jsp:param name="title" value="site_list"/>
</jsp:include>
<jsp:include page="/views/helpers/navbar.jsp">
    <jsp:param name="active" value="nothing"/>
</jsp:include>

<div class="ui container">
    <center>
        <h1><fmt:message key="site.list.h1"/></h1>
        <div class="ui icon input">
            <input type="text" id="java_is_horrible" onkeyup="filter()">
            <i class="search icon"></i>
        </div>
        <br>
    </center>
<!--    <div class="ui centered grid">
        <div class="six wide column">
            <form class="ui form" action="lista" method="POST">
                <div class="fields">
                    <div class="twelve wide field">
                        <label><fmt:message key="site.list.busca"/></label>
                        <input type="text" id="busca" name="busca"/>
                    </div>
                    <div class="four wide field">
                        <input class="ui button" type="submit" style="margin-top: 24px; width: 100%">
                    </div>
                </div>
            </form>
        </div>
    </div>-->
    <table id="java_is_terrible" class="ui sortable celled table">
        <thead>
            <tr>
                <th><fmt:message key="site.list.url"/></th>
                <th><fmt:message key="site.list.nome"/></th>
                <th><fmt:message key="site.list.telefone"/></th>
                <th><fmt:message key="site.list.email"/></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="site" items="${listaSite}">
                <tr>
                    <td><c:out value="${site.url}" /></td>
                    <td><c:out value="${site.nome}" /></td>
                    <td><c:out value="${site.telefone}" /></td>
                    <td><c:out value="${site.email}" /></td>
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
