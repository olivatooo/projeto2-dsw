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

<jsp:include page="../helpers/header.jsp">
    <jsp:param name="title" value="user_list"/>
</jsp:include>
<jsp:include page="../helpers/navbar.jsp">
    <jsp:param name="active" value="user_list"/>
</jsp:include>

<div class="ui text container">
    <center><h1><fmt:message key="user.lista.h1"/></h1></center>
<table class="ui sortable celled table">
    <thead>
        <tr>
            <th><fmt:message key="user.lista.username"/></th>
            <th><fmt:message key="user.lista.name"/></th>
            <th><fmt:message key="user.lista.createdat"/></th>
        </tr>
  </thead>
  <tbody>
      
      <c:forEach var="user" items="${listaUsuario}">
          <tr>
              <td><c:out value="${user.getEmail()}"/></td>
              <td><c:out value="${user.getNome()}"/></td>
              <td><c:out value="${user.getData_criacao()}"/></td>
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


<jsp:include page="../helpers/footer.jsp"/>


