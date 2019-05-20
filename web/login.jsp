<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="br.ufscar.dc.dsw.i18n.text" />
<c:set var="laguage" value="${pageContext.response.locale}"/>
<fmt:setLocale value="${language}"/>

<jsp:include page="views/helpers/header.jsp">
    <jsp:param name="title" value="login"/>
</jsp:include>
<jsp:include page="views/helpers/navbar.jsp">
        <jsp:param name="active" value="login"/>
</jsp:include>
    <center class="ui text container">
        <div class="ui segment">       
            <h2 class="ui icon header">
                <i class="user icon"></i>
                <div class="content">
                    <fmt:message key="login.text"/>
                </div>
            </h2>
            <div class="six wide column">
                <form class="ui form">

                    <div class="field">
                        <input  name="username" type="text" placeholder="<fmt:message key="login.placeholder.username"/>">
                    </div>
                    <div class="field">
                        <input name="password" type="password" placeholder="<fmt:message key="login.placeholder.password"/>">
                    </div>
                    <div class="ui negative message hidden">
                        <p><fmt:message key="login.incorrect"/></p>
                     </div>
                    <button type="submit" class="ui positive button"><fmt:message key="login.text.submit_button"/></button>
                </form>
            </div>
        </div>
        <br><br>
    </center>
    <script>
        $(document).ready(function () {
            form = $('.ui.form');
            form.form({
               fields: {
                   username: {
                       identifier: 'username',
                       rules: [
                           {
                               type: 'empty',
                               prompt: '<fmt:message key="allform.required"/>'
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
                   } 
               },
               inline: true,
               on: 'blur',
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
                username = $('input[name="username"]').val();
                password = $('input[name="password"]').val();
                poster = $.post('/projeto1_dsw/auth/', {
                    username: username,
                    password: password
                }, 'json').done(function() {
                    window.location.href = '/projeto1_dsw';
                }).fail(function() {
                    $('.ui.message').show();
                    form.removeClass('loading');
                });
            });
        });
    </script>
<jsp:include page="views/helpers/footer.jsp"/>
