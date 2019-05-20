/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.dsw.controller;

import br.ufscar.dc.dsw.dao.DAOTokenLogin;
import br.ufscar.dc.dsw.dao.DAOUsuario;
import br.ufscar.dc.dsw.model.Papel;
import br.ufscar.dc.dsw.model.TokenLogin;
import br.ufscar.dc.dsw.model.Usuario;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author igor
 */
@WebServlet(urlPatterns = "/auth/")
public class AuthController extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {
        //response.setContentType("application/json");
        String username = request.getParameter("username");
        String senha = request.getParameter("password");
        DAOUsuario daoUser = new DAOUsuario();
        Usuario user = null;
        String json;
        try {
            user = daoUser.get(username);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(AuthController.class.getName()).log(Level.SEVERE, null, ex);
        }
        if ( user == null ) {
            response.setStatus(422);
            json = "{\"error\": \"username or password incorrect\"}";
            System.out.println(json);
            return;
        }
        if ( !user.getSenha().equals(senha) ) {
            response.setStatus(422);
            json = "{\"error\": \"username or password incorrect\"}";
            System.out.println(json);
            return;
        }
        TokenLogin token = new TokenLogin(user.getEmail()); 
        DAOTokenLogin daoToken = new DAOTokenLogin();
        try {
            daoToken.insert(token);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(AuthController.class.getName()).log(Level.SEVERE, null, ex);
            response.setStatus(500);
            json = "{\"error\": \"an error occurred\"}";
            System.out.println(json);
            return;
        }
        Cookie loginToken = new Cookie("token", token.getToken());
        loginToken.setPath("/");
        loginToken.setMaxAge(86400);
        response.setStatus(200);
        response.addCookie(loginToken);
        json = "{\"success\": \"success\"}";
        System.out.println(json);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie cookie = new Cookie("token","0");
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
//        Cookie cookies[] = request.getCookies();
//        for (Cookie cookie : cookies) {
//            if (cookie.getName().equalsIgnoreCase("token")) {
//                cookie.setMaxAge(0);
//                cookie.setValue("0");
//                response.addCookie(cookie);
//            }
//        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/templates_auth/logout.jsp");
        dispatcher.forward(request, response);
    }
    
    public static boolean hasRole(HttpServletRequest request, String role) throws NoSuchAlgorithmException {
        Usuario user = AuthController.getUser(request);
        if ( user == null ) {
            return false;
        }
        List<Papel> papeis = user.getPapeis();
        for (Papel a : papeis) {
            if (a.getNome().equalsIgnoreCase(role))
                return true;
        }
        return false;
    }
    
    public static Usuario getUser(HttpServletRequest request) throws NoSuchAlgorithmException {
        DAOTokenLogin daoToken = new DAOTokenLogin();
        Cookie[] cookies =  request.getCookies();
        int i = 0;
        while (i < cookies.length - 1 && !cookies[i].getName().equalsIgnoreCase("token")) i++;
        if ( !cookies[i].getName().equalsIgnoreCase("token") ) {
            return null;
        }
        TokenLogin token = daoToken.getToken(cookies[i].getValue());
        if ( token == null ) {
            return null;
        }
        Usuario user = token.getUsuario();
        return user;
    }
    
    public static boolean canAccess(HttpServletRequest request, HttpServletResponse response, String role) throws NoSuchAlgorithmException, IOException {
        if ( !AuthController.hasRole(request, role) ) {
            response.sendRedirect("/projeto1_dsw/403.jsp");
            return false;
        }
        return true;
    }
}
