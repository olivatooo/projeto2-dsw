<%-- 
    Document   : 404
    Created on : 26/04/2019, 16:55:09
    Author     : igor
--%>

<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="br.ufscar.dc.dsw.i18n.text" />
<c:set var="laguage" value="${pageContext.response.locale}"/>
<fmt:setLocale value="${language}"/>
<jsp:include page="/views/helpers/header.jsp">
    <jsp:param name="title" value="500"/>
</jsp:include>
<jsp:include page="/views/helpers/navbar.jsp">
    <jsp:param name="active" value="nothing"/>
</jsp:include>

<div class="ui text container segment">
    <h1><fmt:message key="500.header"/></h1>
    <p><fmt:message key="500.message"/></p>
    
</div>


<jsp:include page="views/helpers/footer.jsp"/>
