<%@page import="br.ufscar.dc.dsw.controller.AuthController"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="br.ufscar.dc.dsw.i18n.text" />
<c:set var="laguage" value="${pageContext.response.locale}"/>
<fmt:setLocale value="${language}"/>

<c:if test="${site == null}">
    <jsp:include page="../helpers/header.jsp">
        <jsp:param name="title" value="site_cadastro"/>
    </jsp:include>
</c:if>
<c:if test="${site != null}">
    <jsp:include page="../helpers/header.jsp">
        <jsp:param name="title" value="site_edit"/>
    </jsp:include>
</c:if>
<jsp:include page="../helpers/navbar.jsp">
    <jsp:param name="active" value="nothing"/>
</jsp:include>
<div class="ui text container">
<center>
    <h1>
        <c:if test="${site == null}">
            <fmt:message key="site.cadastro.h1"/>
        </c:if>
        <c:if test="${site != null}">
            <fmt:message key="site.edit.h1"/>
        </c:if>
    </h1>
</center>
        <form class="ui form">
            <div class="fields">
                <div class="twelve wide field">
                    <label for="site_de_venda_email"><fmt:message key="site.list.email"/></label>  
                    <input value="<c:out value='${site.email}'/>" id="site_de_venda_email" name="email" type="text"
                           <c:if test="${site != null}">disabled=""</c:if>>
                </div>

                <div class="four wide field">
                    <label  for="password"><fmt:message key="site.cadastro.password"/></label>
                    <input id="password" name="password" type="password"
                           value="<c:out value="${site.senha}"/>" <c:if test="${site != null}">disabled</c:if>>
                </div>
            </div>
            
            <div class="fields">
                <div class="eight wide field">
                    <label for="nome"><fmt:message key="site.list.nome"/></label>  
                    <input  value="<c:out value='${site.nome}'/>" id="nome" name="nome" type="text">
                </div>
                <div class="eight wide field">
                    <label for="telefone"><fmt:message key="site.list.telefone"/></label>
                    <input  value="<c:out value='${site.telefone}'/>" id="telefone" name="telefone" type="text">
                </div>
            </div>
            
            <div class="field">
                <label for="url"><fmt:message key="site.list.url"/></label>
                <input  value="<c:out value='${site.url}'/>" id="url" name="url" type="text">
            </div>
            
            <div class="ui negative message hidden">
                <p><fmt:message key="allform.error"/></p>
            </div>
            <input type="submit" class="ui positive button">
    </form>
</div>
<script>
    $(document).ready(function () {
       form = $('.ui.form');
       email = $('#site_de_venda_email');
       password = $('#password');
       nome = $('#nome');
       telefone = $('#telefone');
       url = $('#url');
       action = <c:if test="${site == null}">'cadastro'</c:if><c:if test="${site != null}">'edicao'</c:if>;
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
               telefone: {
                   identifier: 'telefone',
                   rules: [
                       {
                           type: 'empty',
                           prompt: '<fmt:message key="allform.required"/>'
                       }
                   ]
               },
               url: {
                   identifier: 'url',
                   rules: [
                       {
                           type: 'empty',
                           prompt: '<fmt:message key="allform.required"/>'
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
                telefone: telefone.val(),
                url: url.val()
            }).done(function() {
                window.location.href = '/projeto1_dsw/site-de-venda/gerenciar';
            }).fail(function() {
                form.removeClass('loading');
                $('.ui.message').show();
            });
       });
       
    });
</script>
<jsp:include page="../helpers/footer.jsp"/>
