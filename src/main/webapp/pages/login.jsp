<%--
  Created by IntelliJ IDEA.
  User: suiij
  Date: 5/1/2026
  Time: 8:38 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>
<style>
    body {
        background: #f5f5f5 !important;
    }

    .login-shell {
        display: flex;
        min-height: calc(100vh - 140px);
        margin: 20px 0;
        overflow: hidden;
        border-radius: 16px;
        background: #fff;
    }

    .login-hero,
    .login-form-side {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 32px;
    }

    .login-hero {
        background-image: url('https://i.pinimg.com/1200x/8b/6a/ab/8b6aab748b3a430020688dcc12fcad58.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        position: relative;
        color: #fff;
    }

    .login-hero::before {
        content: '';
        position: absolute;
        inset: 0;
        background: rgba(0, 0, 0, 0.25);
        pointer-events: none;
    }

    .hero-content {
        max-width: 420px;
        position: relative;
        z-index: 1;
        text-align: center;
    }

    .hero-content h2 {
        margin: 16px 0 8px;
        font-size: 2rem;
        color: #fff;
    }

    .hero-content p {
        margin: 0;
        line-height: 1.6;
        color: #f7f7f7;
    }

    .login-form-card {
        width: 100%;
        max-width: 430px;
        border-radius: 16px;
        padding: 28px;
        background: #fff;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
    }

    .login-form-card .page-title { margin: 0; }

    .login-subtext {
        margin: 8px 0 20px;
        color: #666;
    }

    .login-form-grid {
        display: grid;
        gap: 12px;
    }

    .login-form-grid .label {
        font-weight: 600;
        color: #333;
    }

    .login-form-grid .input-field {
        width: 100%;
        padding: 12px 14px;
        border: 1px solid #ccc;
        border-radius: 8px;
        outline: none;
        background: #fff;
    }

    .login-form-grid .input-field:focus {
        border-color: #6c63ff;
    }

    .login-form-grid .primary-button {
        margin-top: 8px;
        padding: 12px 14px;
        border: none;
        border-radius: 8px;
        background: #6c63ff;
        color: #fff;
        font-weight: 600;
        cursor: pointer;
    }

    .login-form-grid .primary-button:hover {
        background: #5a52e0;
    }

    .login-form-card .alert {
        margin-bottom: 0.9rem;
        border-radius: 10px;
        padding: 0.75rem 0.85rem;
        background: #fff1f3;
        border: 1px solid #ffc8d2;
        color: #9e1f36;
    }

    .login-links {
        margin-top: 12px;
        text-align: center;
        font-size: 0.9rem;
    }

    .login-links a {
        color: #6c63ff;
        text-decoration: none;
    }

    .login-links a:hover {
        text-decoration: underline;
    }

    @media (max-width: 980px) {
        .login-shell {
            flex-direction: column;
        }

        .login-hero,
        .login-form-side {
            padding: 20px;
        }

        .hero-content {
            text-align: center;
        }
    }
</style>

<section class="login-shell">
    <div class="login-hero">
        <div class="hero-content">
            <h2>FoodShareHub</h2>
            <p></p>
        </div>
    </div>

    <div class="login-form-side">
        <div class="login-form-card">
            <h2 class="page-title">Login</h2>
            <p class="login-subtext">Access your account in seconds.</p>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="alert"><%= error %></div>
            <% } %>

            <form action="<%= contextPath %>/login" method="post" class="login-form-grid">
                <label class="label" for="email">Email</label>
                <input class="input-field" type="email" id="email" name="email" required>

                <label class="label" for="password">Password</label>
                <input class="input-field" type="password" id="password" name="password" required>

                <button class="primary-button" type="submit">Login</button>
            </form>

            <div class="login-links">
                <p>Don't have an account? <a href="<%= contextPath %>/register">Sign up</a></p>
                <p><a href="#">Forgot password?</a></p>
            </div>
        </div>
    </div>
</section>
<%--<%@ include file="../includes/footer.jsp" %>--%>
