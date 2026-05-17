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

    .register-shell {
        display: flex;
        min-height: calc(100vh - 140px);
        margin: 20px 0;
        overflow: hidden;
        border-radius: 16px;
        background: #fff;
    }

    .register-hero,
    .register-form-side {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 32px;
    }

    .register-hero {
        background-image: url('https://i.pinimg.com/1200x/8b/6a/ab/8b6aab748b3a430020688dcc12fcad58.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        position: relative;
        color: #fff;
    }

    .register-hero::before {
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

    .register-form-card {
        width: 100%;
        max-width: 430px;
        border-radius: 16px;
        padding: 28px;
        background: #fff;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
    }

    .register-form-card .page-title { margin: 0; }

    .register-subtext {
        margin: 8px 0 20px;
        color: #666;
    }

    .register-form-grid {
        display: grid;
        gap: 12px;
    }

    .register-form-grid .label {
        font-weight: 600;
        color: #333;
    }

    .register-form-grid .input-field,
    .register-form-grid .select-field {
        width: 100%;
        padding: 12px 14px;
        border: 1px solid #ccc;
        border-radius: 8px;
        outline: none;
        background: #fff;
    }

    .register-form-grid .input-field:focus,
    .register-form-grid .select-field:focus {
        border-color: #6c63ff;
    }

    .register-form-grid .primary-button {
        margin-top: 8px;
        padding: 12px 14px;
        border: none;
        border-radius: 8px;
        background: #6c63ff;
        color: #fff;
        font-weight: 600;
        cursor: pointer;
    }

    .register-form-grid .primary-button:hover {
        background: #5a52e0;
    }

    @media (max-width: 980px) {
        .register-shell {
            flex-direction: column;
        }

        .register-hero,
        .register-form-side {
            padding: 20px;
        }

        .hero-content {
            text-align: center;
        }
    }
</style>

<section class="register-shell">
    <div class="register-hero">
        <div class="hero-content">
            <h2>FoodShareHub</h2>
            <p>Create a donor or volunteer account to start sharing food and supporting your community.</p>
        </div>
    </div>

    <div class="register-form-side">
        <div class="register-form-card">
            <h2 class="page-title">Register</h2>
            <p class="register-subtext">Join the platform in a few simple steps.</p>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="alert"><%= error %></div>
            <% } %>

            <form action="<%= contextPath %>/register" method="post" class="register-form-grid">
                <label class="label" for="name">Name</label>
                <input class="input-field" type="text" id="name" name="name" required>

                <label class="label" for="email">Email</label>
                <input class="input-field" type="email" id="email" name="email" required>

                <label class="label" for="password">Password</label>
                <input class="input-field" type="password" id="password" name="password" required>

                <label class="label" for="accountType">Account type</label>
                <select class="select-field" id="accountType" name="accountType">
                    <option value="donor">Donor</option>
                    <option value="volunteer">Volunteer</option>
                </select>

                <button class="primary-button" type="submit">Register</button>
            </form>
        </div>
    </div>
</section>
<%--<%@ include file="../includes/footer.jsp" %>--%>
