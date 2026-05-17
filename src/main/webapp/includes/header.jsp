<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.advancedprogramming.foodsharehub.user.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    String basePath = request.getContextPath();
    String contextPath = basePath;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodShare Hub</title>
    <style>
/* FoodShare Hub - Modern UI Styles */

/* Reset and Base Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: #333;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

/* Header Styles */
.site-header {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
    position: sticky;
    top: 0;
    z-index: 1000;
}

.header-inner {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 0;
}

.brand {
    font-size: 1.8rem;
    font-weight: bold;
    color: #667eea;
    text-decoration: none;
    transition: color 0.3s ease;
}

.brand:hover {
    color: #764ba2;
}

.nav-links {
    display: flex;
    gap: 1.5rem;
    align-items: center;
}

.nav-links a {
    color: #555;
    text-decoration: none;
    font-weight: 500;
    padding: 0.5rem 1rem;
    border-radius: 25px;
    transition: all 0.3s ease;
}

.nav-links a:hover {
    background: #667eea;
    color: white;
    transform: translateY(-2px);
}

/* Main Content */
main {
    padding: 2rem 0;
    min-height: calc(100vh - 200px);
}

/* Content Cards */
.content-card, .auth-card {
    background: white;
    border-radius: 15px;
    padding: 2.5rem;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    margin-bottom: 2rem;
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.page-title {
    color: #333;
    font-size: 2.2rem;
    margin-bottom: 0.5rem;
    font-weight: 700;
    text-align: center;
}

.content-card p, .auth-card p {
    color: #666;
    font-size: 1.1rem;
    margin-bottom: 2rem;
    text-align: center;
}

/* Form Styles */
.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1.5rem;
    max-width: 600px;
    margin: 0 auto;
}

.label {
    display: block;
    margin-bottom: 0.5rem;
    font-weight: 600;
    color: #555;
    font-size: 0.95rem;
}

.input-field {
    width: 100%;
    padding: 0.8rem 1rem;
    border: 2px solid #e1e5e9;
    border-radius: 8px;
    font-size: 1rem;
    transition: all 0.3s ease;
    background: #f8f9fa;
}

.input-field:focus {
    outline: none;
    border-color: #667eea;
    background: white;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.primary-button {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border: none;
    padding: 0.9rem 2rem;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    grid-column: 1 / -1;
    margin-top: 1rem;
}

.primary-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
}

.primary-button:active {
    transform: translateY(0);
}

.select-field {
    width: 100%;
    padding: 0.8rem 1rem;
    border: 2px solid #e1e5e9;
    border-radius: 8px;
    font-size: 1rem;
    background: #f8f9fa;
    transition: all 0.3s ease;
    cursor: pointer;
}

.select-field:focus {
    outline: none;
    border-color: #667eea;
    background: white;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

/* Alert Styles */
.alert {
    background: #fee;
    color: #c33;
    padding: 1rem;
    border-radius: 8px;
    margin-bottom: 1.5rem;
    border-left: 4px solid #c33;
    font-weight: 500;
}

/* Footer Styles */
.site-footer {
    background: rgba(240, 248, 242, 0.96);
    backdrop-filter: blur(10px);
    margin-top: 3rem;
    padding: 2rem 0;
    border-top: 1px solid rgba(94, 143, 105, 0.22);
}

.footer-inner {
    text-align: center;
    color: #3f5f48;
    font-size: 0.9rem;
}

.footer-inner .footer-copy {
    color: #3f5f48;
}

/* Responsive Design */
@media (max-width: 768px) {
    .header-inner {
        flex-direction: column;
        gap: 1rem;
    }

    .nav-links {
        flex-wrap: wrap;
        justify-content: center;
    }

    .form-grid {
        grid-template-columns: 1fr;
        gap: 1rem;
    }

    .content-card, .auth-card {
        padding: 1.5rem;
        margin: 1rem;
    }

    .page-title {
        font-size: 1.8rem;
    }
}

/* Animations */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.content-card, .auth-card {
    animation: fadeIn 0.6s ease-out;
}

/* Action Grid and Buttons */
.action-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
    margin-top: 2rem;
}

.button {
    display: inline-block;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    text-decoration: none;
    padding: 0.8rem 1.5rem;
    border-radius: 8px;
    font-weight: 600;
    text-align: center;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
}

.button:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
}

.button:active {
    transform: translateY(0);
}

/* Table Styles */
.table-wrapper {
    margin-top: 2rem;
    overflow-x: auto;
    border-radius: 8px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.table-list {
    width: 100%;
    border-collapse: collapse;
    background: white;
    font-size: 0.9rem;
}

.table-list th {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 1rem;
    text-align: left;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.table-list td {
    padding: 1rem;
    border-bottom: 1px solid #e1e5e9;
}

.table-list tr:nth-child(even) {
    background: #f8f9fa;
}

.table-list tr:hover {
    background: #e3f2fd;
    transition: background 0.2s ease;
}

.table-list a {
    color: #667eea;
    text-decoration: none;
    font-weight: 500;
    padding: 0.3rem 0.6rem;
    border-radius: 4px;
    transition: all 0.2s ease;
}

.table-list a:hover {
    background: #667eea;
    color: white;
}
    </style>
</head>
<body>
<header class="site-header">
    <div class="container header-inner">
        <a class="brand" href="<%= basePath %>/">FoodShare Hub</a>
        <nav class="nav-links">
            <a href="<%= basePath %>/">Home</a>
            <a href="<%= basePath %>/donations">Donations</a>
            <% if (currentUser == null) { %>
            <a href="<%= basePath %>/register">Register</a>
            <a href="<%= basePath %>/login">Login</a>
            <% } else { %>
            <% if ("admin".equals(currentUser.getRole())) { %>
            <a href="<%= basePath %>/admin-dashboard">Admin</a>
            <% } else if ("volunteer".equals(currentUser.getRole())) { %>
            <a href="<%= basePath %>/volunteer-dashboard">Volunteer</a>
            <% } else { %>
            <a href="<%= basePath %>/dashboard">Dashboard</a>
            <% } %>
            <a href="<%= basePath %>/logout">Logout</a>
            <% } %>
        </nav>
    </div>
</header>
<main class="container"/>
