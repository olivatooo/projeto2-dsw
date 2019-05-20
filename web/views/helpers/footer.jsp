<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="br.ufscar.dc.dsw.i18n.text" />
<c:set var="laguage" value="${pageContext.response.locale}"/>
<fmt:setLocale value="${language}"/>

        </div>  
        <div class="ui inverted vertical footer segment mg-top">
            <center class="ui text container">
                <p class="ui text small">
                <fmt:message key="footer.text"/><br>
                Alcides Mignoso<br>
                Gabriel Olivato<br>
                Igor R. Magollo<br>
                </p>
            </center>
        </div>
    </body>
</html>
