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
public class Papel implements Comparable<Papel> {
    private int id;
    private String nome;

    public Papel(String nome) {
        this.nome = nome;
    }

    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    @Override
    public int compareTo(Papel o) {
        return this.getNome().compareToIgnoreCase(o.getNome());
    }
}
