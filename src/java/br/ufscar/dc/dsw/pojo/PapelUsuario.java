/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.dsw.pojo;

/**
 *
 * @author igor
 */
public class PapelUsuario {
    private int id;
    private String usuario;
    private int papel;
    
    public PapelUsuario(String usuario, int papel) {
        this.papel = papel;
        this.usuario = usuario;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public void setPapel(int papel) {
        this.papel = papel;
    }

    public int getId() {
        return id;
    }

    public String getUsuario() {
        return usuario;
    }

    public int getPapel() {
        return papel;
    }
}
