package br.ufscar.dc.dsw.controller;

import br.ufscar.dc.dsw.dao.DAOPapel;
import br.ufscar.dc.dsw.dao.DAOPapelUsuario;
import br.ufscar.dc.dsw.model.SiteDeVenda;
import br.ufscar.dc.dsw.dao.DAOSiteDeVenda;
import br.ufscar.dc.dsw.dao.DAOUsuario;
import br.ufscar.dc.dsw.model.Papel;
import br.ufscar.dc.dsw.model.PapelUsuario;
import br.ufscar.dc.dsw.model.Promocao;
import br.ufscar.dc.dsw.model.Usuario;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/site-de-venda/*")
public class SiteDeVendaController extends HttpServlet {

    private DAOSiteDeVenda dao;

    @Override
    public void init() {
        dao = new DAOSiteDeVenda();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {
        String action = request.getRequestURI();
        action = action.split("/")[action.split("/").length - 1];
        try {
            switch (action) {
                case "cadastro":
                    insere(request, response);
                    break;
                case "edicao":
                    atualize(request, response);
                    break;
                default:
                    apresentaFormCadastro(request, response);
                    break;
            }
        } catch (RuntimeException | IOException | ServletException e) {
            throw new ServletException(e);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(SiteDeVendaController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {
        String action = request.getRequestURI();
        action = action.split("/")[action.split("/").length - 1];
        try {
            switch (action) {
                case "cadastro":
                    apresentaFormCadastro(request, response);
                    break;
                case "gerenciar":
                    listaGerenciar(request, response);
                    break;
                case "edicao_form":
                    apresentaFormEdicao(request, response);
                    break;
                case "remocao":
                    remove(request, response);
                    break;
                case "lista":
                    lista(request, response);
                    break;
                default:
                    lista(request, response);
                    break;
            }
        } catch (RuntimeException | IOException | ServletException e) {
            throw new ServletException(e);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(SiteDeVendaController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void listaGerenciar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NoSuchAlgorithmException {
        if (new AuthController().hasRole(request, "admin")) {
            if (request.getParameter("busca") != null) {
                List<SiteDeVenda> lista = dao.getByName(String.valueOf(request.getParameter("busca")));
                request.setAttribute("listaSite", lista);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/templates_site_de_venda/gerenciar.jsp");
                dispatcher.forward(request, response);
            } else {
                List<SiteDeVenda> lista = dao.getAll();
                request.setAttribute("listaSite", lista);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/templates_site_de_venda/gerenciar.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            response.sendRedirect("/projeto1_dsw/403.jsp");
        }
    }

    private void lista(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NoSuchAlgorithmException {
        List<SiteDeVenda> lista = dao.getAll();
        request.setAttribute("listaSite", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/templates_site_de_venda/lista.jsp");
        dispatcher.forward(request, response);
    }

    private void apresentaFormCadastro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NoSuchAlgorithmException {
        // TODO: Criar templates para SiteDeVenda
        if (new AuthController().hasRole(request, "admin")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/templates_site_de_venda/cadastro.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("/projeto1_dsw/403.jsp");

        }
    }

    private void insere(HttpServletRequest request, HttpServletResponse response) throws IOException, NoSuchAlgorithmException, ServletException {
        SiteDeVenda site = null;
        try {
            request.setCharacterEncoding("UTF-8");
            String email = request.getParameter("email");
            String url = request.getParameter("url");
            String telefone = request.getParameter("telefone");
            String senha = request.getParameter("password");
            String nome = request.getParameter("nome");
            site = new SiteDeVenda(email, senha, url, nome, telefone);
            Usuario user = new Usuario(email, nome, senha, new Date(System.currentTimeMillis()));
            new DAOUsuario().insert(user);
            Papel p = new Papel("listar_promocao");
            List<Papel> lista = new DAOPapel().getAll();
            if (!lista.contains(p)) {
                new DAOPapel().insert(p);
            }
            for (Papel x : new DAOPapel().getAll()) {
                if (x.getNome().equals("listar_promocao")) {
                    new DAOPapelUsuario().insert(new PapelUsuario(email, x.getId()));
                    break;
                }
            }
            dao.insert(site);
            response.sendRedirect("lista");
        } catch (Exception e) {
            request.setAttribute("site", site);
            request.setAttribute("listaSites", new DAOSiteDeVenda().getAll());
            request.setAttribute("erro", "Erro ao salvar os dados!");

            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/templates_site_de_venda/cadastro.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void apresentaFormEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SiteDeVenda site = null;
        try {
            String email = request.getParameter("id");
            site = dao.get(email);
            request.setAttribute("site", site);
            request.setAttribute("listaSites", new DAOSiteDeVenda().getAll());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/templates_site_de_venda/cadastro.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            request.setAttribute("site", site);
            request.setAttribute("erro", "Erro ao salvar os dados!");
            request.setAttribute("listaSites", new DAOSiteDeVenda().getAll());
            request.setAttribute("editando", true);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/templates_site_de_venda/cadastro.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void atualize(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String url = request.getParameter("url");
        String telefone = request.getParameter("telefone");
        String senha = request.getParameter("password");
        String nome = request.getParameter("nome");

        SiteDeVenda site = new SiteDeVenda(
                email,
                senha,
                url,
                nome,
                telefone);
        
        dao.update(site);
        response.sendRedirect("listaGerenciar");
    }

    private void remove(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String email = request.getParameter("id");
        SiteDeVenda site = dao.get(email);
        dao.delete(site);
        response.sendRedirect("gerenciar");
    }

}
