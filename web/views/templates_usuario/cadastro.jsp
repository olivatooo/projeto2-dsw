<%@page import="br.ufscar.dc.dsw.controller.AuthController"%>
<%@ page pageEncoding="UTF-8" %>
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
    <jsp:param name="title" value="cadastro_usuario"/>
</jsp:include>
<jsp:include page="../helpers/navbar.jsp">
    <jsp:param name="active" value="user"/>
</jsp:include>
<div class="ui text container">
    <center><h1><fmt:message key="user.cadastro.h1"/></h1></center>
        <form id="form" class="ui form" action="cadastro">
                <div class="field">
                    <label for="usuario_id"><fmt:message key="user.cadastro.username"/></label>  
                    <input id="usuario_id" name="usuario_id" type="text" placeholder="<fmt:message key="user.cadastro.username"/>">
                </div>

                 <!-- Password input-->
                <div class="field"> 
                    <label  for="password"><fmt:message key="user.cadastro.password"/></label>
                    <input id="password" name="password" type="password" placeholder="<fmt:message key="user.cadastro.password"/>">
                </div>

                 <!-- Text input-->
                <div class="field">
                    <label for="name"><fmt:message key="user.cadastro.name"/></label>  
                    <input id="name" name="name" type="text" placeholder="<fmt:message key="user.cadastro.name"/>">
                </div>
                 
                <div class="field">
                    <label for="name"><fmt:message key="user.cadastro.roles"/></label>  
                    <input id="papeis" name="papeis" type="text" placeholder="<fmt:message key="user.cadastro.roles"/>">
                </div>
                <input type="submit" class="ui positive button" value="<fmt:message key="allform.submit"/>"> 
        </form>
    <input id="required" type="hidden" value="<fmt:message key="allform.required"/>">
    </div>
<script>
    $(document).ready(function () {
        required = $('#required').val();
        
        form = $('.ui.form');
        form.form({
            on: 'blur',
            fields: {
                usuario_id: {
                    identifier: 'usuario_id',
                    rules: [
                        {
                            type: 'empty',
                            prompt: required
                        }
                    ]
                },
                password: {
                    identifier: 'password',
                    rules: [
                        {
                            type: 'empty',
                            prompt: required
                        }
                    ]
                },
                name: {
                    identifier: 'name',
                    rules: [
                        {
                            type: 'empty',
                            prompt: required
                        }
                    ]
                },
                papeis: {
                    identifier: 'papeis',
                    rules: [
                        {
                            type: 'empty',
                            prompt: required
                        }
                    ]
                }
            }
            ,inline: true,
            onSuccess: function () {
                form.removeClass('success').removeClass('error');
            },
            onFailure: function () {
                window.scrollTo(0, 0);
                form.removeClass('success').removeClass('error');
            }

        }).on('submit', function (e) {
            e.preventDefault();
            if (!form.form('is valid')) return;
            form.addClass('loading');
            action = $('.ui.form').attr('action');
            usuario_id = $('input[name="usuario_id"]').val();
            password = $('input[name="password"]').val();
            name = $('input[name="name"]').val();
            papeis = $('input[name="papeis"]').val();
            $.post(action, {
                usuario_id: usuario_id,
                password: password,
                name: name,
                papeis: papeis
            }).done(function () {
                window.location.href="usuario/lista";
            }).fail(function () {
                form.removeClass('loading');
                alert("<fmt:message key="allform.error"/>");
            });
        });
    });
</script>
<jsp:include page="../helpers/footer.jsp"/>
