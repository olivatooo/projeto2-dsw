<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="br.ufscar.dc.dsw.i18n.text" />
<c:set var="laguage" value="${pageContext.response.locale}"/>
<fmt:setLocale value="${language}"/>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta charset="UTF-8"/>
        <title><fmt:message key="title.${ param.title }"/></title>
        <link rel="icon" href="/projeto1_dsw/ricardo.ico" type="favicon.ico"/>
        <link rel="stylesheet" type="text/css" href="/projeto1_dsw/semantic/semantic.css">
        <link rel="stylesheet" type="text/css" href="/projeto1_dsw/custom-css/style.css">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js"
                integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
                crossorigin="anonymous"></script>
        <script src="/projeto1_dsw/semantic/semantic.js"></script>
        <script src="http://semantic-ui.com/javascript/library/tablesort.js"></script>
    </head>
    <body>
        <div style="min-height: 100vh">