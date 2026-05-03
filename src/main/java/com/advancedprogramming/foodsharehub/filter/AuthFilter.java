package com.advancedprogramming.foodsharehub.filter;


import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization required
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("user") != null;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        boolean isAuthPage = uri.contains("login") || uri.contains("register");
        boolean isPublicResource = uri.contains("styles.css") || uri.contains("favicon.ico");
        boolean isIndexPage = uri.equals(contextPath + "/") || uri.endsWith("index.jsp");

        if (loggedIn && isAuthPage) {
            resp.sendRedirect(contextPath + "/");
            return;
        }

        if (loggedIn || isAuthPage || isPublicResource || isIndexPage) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(contextPath + "/login");
        }
    }

    @Override
    public void destroy() {
        // No cleanup required
    }
}