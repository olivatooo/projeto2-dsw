/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.dsw.pojo;

import br.ufscar.dc.dsw.dao.DAOUsuario;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Date;

/**
 *
 * @author igor
 */
public class TokenLogin {
    private int id;
    private String token;
    private String usuario;
    private Date data_login;
    
    public TokenLogin(String token, String usuario, Date data_login) {
        this.token = token;
        this.usuario = usuario;
        this.data_login = data_login;
    }
    
    public TokenLogin(String token, String usuario) {
        this.token = token;
        this.usuario = usuario;
        this.data_login = new Date();
    }
    
    public TokenLogin(String usuario) {
        SecureRandom random = new SecureRandom();
        byte bytes[] = new byte[256];
        random.nextBytes(bytes);
        this.token =  bytes.toString();
        this.usuario = usuario;
        this.data_login = new Date();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Usuario getUsuario() throws NoSuchAlgorithmException {
        DAOUsuario user = new DAOUsuario();
        return user.get(this.usuario);
    }

    public Date getData_login() {
        return data_login;
    }

    public void setData_login(Date data_login) {
        this.data_login = data_login;
    }
    
}
