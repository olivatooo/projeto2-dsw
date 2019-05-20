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

<c:if test="${teatro == null}">
    <jsp:include page="../helpers/header.jsp">
        <jsp:param name="title" value="teatros_cadastro"/>
    </jsp:include>
</c:if>
<c:if test="${teatro != null}">
    <jsp:include page="../helpers/header.jsp">
        <jsp:param name="title" value="teatros_edit"/>
    </jsp:include>
</c:if>
<jsp:include page="../helpers/navbar.jsp">
    <jsp:param name="active" value="teatros"/>
</jsp:include>

<div class="ui text container">
<center>
    <h1>
        <c:if test="${teatro == null}">
            <fmt:message key="teatro.cadastro.h1"/>
        </c:if>
        <c:if test="${teatro != null}">
            <fmt:message key="teatro.editar.h1"/>
        </c:if>
    </h1>
</center>
    <form class="ui form" method="post">


        <div class="field">
            <label for="sala_de_teatro_email"><fmt:message key="teatro.list.email"/></label>  
            <input id="sala_de_teatro_email" name="email" type="text" placeholder="example@gmail.com"
                   value="<c:out value="${teatro.email}"/>"
                   >
        </div>

        <!-- Password input-->
        <div class="field">
            <label  for="password"><fmt:message key="teatro.cadastro.password"/></label>
            <input id="password" name="password" type="password" placeholder="<fmt:message key="teatro.cadastro.password"/>"
                   value="<c:out value="${teatro.senha}"/>" <c:if test="${teatro != null}">disabled</c:if>>
        </div>

        <!-- Text input-->
        <div class="field">
            <label for="nome"><fmt:message key="teatro.list.nome"/></label>  
            <input id="nome" name="nome" type="text" placeholder="<fmt:message key="teatro.list.nome"/>"
                   value="<c:out value="${teatro.nome}"/>">
        </div>

        <div class="field">
            <label for="cnpj"><fmt:message key="teatro.list.cnpj"/></label>  
            <input id="cnpj" name="cnpj" type="text" placeholder="<fmt:message key="teatro.list.cnpj"/>"
                   value="<c:out value="${teatro.cnpj}"/>" <c:if test="${teatro != null}">disabled=""</c:if>>
        </div>

        <div class="field">
            <label for="cidade"><fmt:message key="teatro.list.cidade"/></label>  
            <input id="cidade" name="cidade" type="text" placeholder="<fmt:message key="teatro.list.cidade"/>"
                   value="<c:out value="${teatro.cidade}"/>">
        </div>
        
        <div class="field">
            <label for="site_de_venda_email"><fmt:message key="teatro.list.email_vendas"/></label>  
            <select id="site_de_venda_email" name="site_de_venda_email" class="ui fuid dropdown" 
                    value="<c:out value="${teatro.site_de_venda_email}"/>">
                    <c:forEach var="x" items="${listaSites}">    
                        <option value="<c:out value="${x.email}" />"><c:out value="${x.email}"/> - <c:out value="${x.nome}"/></option> 
                    </c:forEach>
            </select>
        </div>
        <div class="ui negative message hidden">
            <p><fmt:message key="allform.error"/></p>
        </div>
        <input type="submit" class="ui positive button" value="<fmt:message key="allform.submit"/>">
    </form>
</div>
<script>
    $(document).ready(function () {
       form = $('.ui.form');
       email = $('#sala_de_teatro_email');
       password = $('#password');
       nome = $('#nome');
       cnpj = $('#cnpj');
       cidade = $('#cidade');
       site_de_venda_email = $('#site_de_venda_email');
       action = <c:if test="${teatro == null}">'cadastro'</c:if><c:if test="${teatro != null}">'edicao'</c:if>;
       form.form({
           fields: {
               email: {
                   identifier: 'email',
                   rules: [
                       {
                           type: 'empty',
                           prompt: '<fmt:message key="allform.required"/>'
                       },
                       {
                           type: 'email',
                           prompt: '<fmt:message key="allform.email"/>'
                       }
                   ]
               },
               password: {
                   identifier: 'password',
                   rules: [
                       {
                           type: 'empty',
                           prompt: '<fmt:message key="allform.required"/>'
                       }
                   ]
               },
               nome: {
                   identifier: 'nome',
                   rules: [
                       {
                           type: 'empty',
                           prompt: '<fmt:message key="allform.required"/>'
                       }
                   ]
               },
               cnpj: {
                   identifier: 'cnpj',
                   rules: [
                       {
                           type: 'empty',
                           prompt: '<fmt:message key="allform.required"/>'
                       }
                   ]
               },
               cidade: {
                   identifier: 'cidade',
                   rules: [
                       {
                           type: 'empty',
                           prompt: '<fmt:message key="allform.required"/>'
                       }
                   ]
               },
               site_de_venda_email: {
                   identifier: 'site_de_venda_email',
                   rules: [
                       {
                           type: 'empty',
                           prompt: '<fmt:message key="allform.required"/>'
                       },
                       {
                           type: 'email',
                           prompt: '<fmt:message key="allform.email"/>'
                       }
                   ]
               }
           },
           on: 'blur',
           inline: true,
           onSuccess: function () {
                form.removeClass('success').removeClass('error');
            },
            onFailure: function () {
                window.scrollTo(0, 0);
                form.removeClass('success').removeClass('error');
            }
       }).on('submit', function(e) {
            e.preventDefault();
            if (!form.form('is valid')) return;
            form.addClass('loading');
            $.post(action, {
                email: email.val(),
                password: password.val(),
                nome: nome.val(),
                cnpj: cnpj.val(),
                cidade: cidade.val(),
                site_de_venda_email: site_de_venda_email.val()
            }).done(function() {
                window.location.href = '/projeto1_dsw/sala-de-teatro/garenciar';
            }).fail(function() {
                form.removeClass('loading');
                $('.ui.message').show();
            });
       });
       
    });
</script>

<jsp:include page="../helpers/footer.jsp"/>
