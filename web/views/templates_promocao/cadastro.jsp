<%@page import="br.ufscar.dc.dsw.controller.AuthController"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="br.ufscar.dc.dsw.i18n.text" />
<c:set var="laguage" value="${pageContext.response.locale}"/>
<fmt:setLocale value="${language}"/>

<c:if test="${prom == null}">
    <jsp:include page="../helpers/header.jsp">
        <jsp:param name="title" value="promocao_cadastro"/>
    </jsp:include>
</c:if>
<c:if test="${prom != null}">
    <jsp:include page="../helpers/header.jsp">
        <jsp:param name="title" value="promocao_edit"/>
    </jsp:include>
</c:if>
<jsp:include page="../helpers/navbar.jsp">
    <jsp:param name="active" value="promocao"/>
</jsp:include>

<div class="ui text container">
    <center>
        <h1>
            <c:if test="${teatro == null}">
                <fmt:message key="promocao.cadastro.h1"/>
            </c:if>
            <c:if test="${teatro != null}">
                <fmt:message key="promocao.editar.h1"/>
            </c:if>
        </h1>
    </center>
    <form class="ui form" method="post">
        <c:if test="${prom != null}">
            <div class="field">
                <label for="id_promocao">ID</label>  
                <input value="<c:out value='${prom.id_promocao}'/>" id="id_promocao" name="id_promocao" type="text" disabled>
            </div>
        </c:if>
        <div class="field">
            <label for="nome_peca"><fmt:message key="promocao.list.peca_nome"/></label>  
            <input value="<c:out value='${prom.nome_peca}'/>" id="nome_peca" name="nome_peca" type="text">
        </div>
        <div class="field">
            <label for="preco"><fmt:message key="promocao.list.preco"/></label>  
            <input value="<c:out value='${prom.preco}'/>" id="preco" name="preco" type="text">
        </div>
        <div class="field">
            <label for="datetime"><fmt:message key="promocao.list.data_hora"/></label>  
            <input value="<c:out value='${prom.datetime}'/>" id="datetime" name="datetime" type="text" placeholder="DD/MM/YY HH:MM:SS">
        </div>
        <div class="field">
            <label for="endereco_url"><fmt:message key="promocao.list.endereco"/></label>  
            <select id="endereco_url" name="endereco_url" value="<c:out value='${prom.endereco_url}'/>">
                <c:forEach var="end" items="${listaUrl}">    
                        <option value="<c:out value="${end.email}" />"><c:out value="${end.email}"/></option> 
                </c:forEach>
            </select>              
        </div>
        <div class="field">
            <label for="cnpj_teatro"><fmt:message key="promocao.cadastro.sala_teatro"/></label>  
            <select id="cnpj_teatro" name="cnpj_teatro">
                <c:forEach var="sala" items="${listaSalas}">    
                    <c:choose>
                        <c:when test="${sala.cnpj == prom.cnpj_teatro}">
                            <option selected value="<c:out value="${sala.cnpj}" />"><c:out value="${sala.nome}"/> - <c:out value="${sala.cnpj}"/></option> 
                        </c:when>
                        <c:otherwise>
                            <option value="<c:out value="${sala.cnpj}" />"><c:out value="${sala.nome}"/> - <c:out value="${sala.cnpj}"/></option> 
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
        </div>
        <div class="ui negative message hidden">
            <p><fmt:message key="allform.error"/></p>
        </div>
        <input class="ui positive button" type="submit"/>
    </form>
</div>
<script>
    $(document).ready(function () {
       form = $('.ui.form');
       id_promocao = $('#id_promocao');
       nome_peca = $('#nome_peca');
       preco = $('#preco');
       datetime = $('#datetime');
       endereco_url = $('#endereco_url');
       cnpj_teatro = $('#cnpj_teatro');
       action = <c:if test="${teatro == null}">'cadastro'</c:if><c:if test="${teatro != null}">'edicao'</c:if>;
       form.form({
          fields: {
              nome_peca: {
                  identifier: 'nome_peca',
                  rules: [
                      {
                          type: 'empty',
                          prompt: '<fmt:message key="allform.required"/>'
                      }
                  ]
              },
              preco: {
                  identifier: 'preco',
                  rules: [
                        {
                            type: 'empty',
                            prompt: '<fmt:message key="allform.required"/>'
                        }
                  ]
              },
              datetime: {
                  identifier: 'datetime',
                  rules: [
                        {
                            type: 'empty',
                            prompt: '<fmt:message key="allform.required"/>'
                        }
                  ]
              },
              endereco_url: {
                  identifier: 'endereco_url',
                  rules: [
                        {
                            type: 'empty',
                            prompt: '<fmt:message key="allform.required"/>'
                        }
                  ]
              },
              cnpj_teatro: {
                  identifier: 'cnpj_teatro',
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
       }).on('submit', function (e) {
            e.preventDefault();
            if (!form.form('is valid')) return;
            form.addClass('loading');
            $.post(action, {
                <c:if test="${prom != null}">
                 id_promocao: id_promocao.val(),
                </c:if>
                nome_peca: nome_peca.val(),
                preco: preco.val(),
                datetime: datetime.val(),
                endereco_url: endereco_url.val(),
                cnpj_teatro: cnpj_teatro.val()
            }).done(function () {
                window.location.href = 'gerenciar';
            }).fail(function () {
                form.removeClass('loading');
                $('.ui.message').show();
            });
       });
       
    });
</script>
<jsp:include page="../helpers/footer.jsp"/>
