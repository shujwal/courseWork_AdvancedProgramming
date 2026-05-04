<%--
  Created by IntelliJ IDEA.
  User: suiij
  Date: 5/1/2026
  Time: 10:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    /* Ensure html/body have no default gaps that break full-bleed elements */
    html, body {
        margin: 0;
        padding: 0;
        width: 100%;
    }

    .site-footer {
        width: 100%;
        margin: 3rem 0 0 0;
        padding: 0;
    }

    .footer-panel {
        /* full-bleed background that spans the viewport width */
        width: 100vw;
        position: relative;
        left: 50%;
        transform: translateX(-50%);
        background: linear-gradient(135deg, #eef6f0 0%, #e5f1e7 100%);
        color: #4a6b57;
        border-top: 1px solid #d4e8da;
        border-radius: 0;
        padding: 2.25rem 0;
        box-shadow: 0 -4px 18px rgba(47, 95, 64, 0.08);
        margin: 0;
        box-sizing: border-box;
        overflow: hidden;
    }

    /* make inner content fluid but padded; remove max-width restriction so footer content can use full width if needed */
    .footer-content {
        width: 100%;
        padding: 0 24px;
        margin: 0 auto;
        box-sizing: border-box;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 24px;
        align-items: start;
    }

    /* footer-grid kept for semantic grouping; layout handled by .footer-content */
    .footer-grid { display: contents; }

    .footer-brand h3,
    .footer-links h4,
    .footer-contact h4 {
        margin: 0 0 0.85rem;
        color: #3a5f48;
    }

    .footer-brand p,
    .footer-links a,
    .footer-contact p,
    .footer-copy {
        color: #5a7d68;
        font-size: 0.95rem;
        line-height: 1.6;
        text-decoration: none;
    }

    .footer-links {
        display: flex;
        flex-direction: column;
        gap: 0.55rem;
    }

    .footer-links a:hover {
        color: #3a5f48;
        text-decoration: underline;
    }

    .footer-social {
        display: flex;
        gap: 0.75rem;
        margin-top: 1rem;
    }

    .social-dot {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: rgba(255, 255, 255, 0.65);
        color: #3a5f48;
        font-size: 0.8rem;
        font-weight: 700;
        text-decoration: none;
    }

    .social-dot:hover {
        background: rgba(255, 255, 255, 0.9);
    }

    .footer-bottom {
        margin-top: 1.5rem;
        padding-top: 1rem;
        border-top: 1px solid rgba(69, 111, 82, 0.18);
        text-align: center;
    }

    .footer-copy {
        margin: 0;
    }

    @media (max-width: 900px) {
        .footer-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<footer class="site-footer">
    <div class="footer-panel">
        <div class="footer-content">
        <div class="footer-grid">
            <div class="footer-brand">
                <h3>FoodShare Hub</h3>
                <p>
                    A community platform that connects donors, volunteers, and people in need through simple and safe food sharing.
                </p>
                <div class="footer-social">
                    <a href="#" class="social-dot" aria-label="Instagram">IG</a>
                    <a href="#" class="social-dot" aria-label="Facebook">FB</a>
                    <a href="#" class="social-dot" aria-label="X">X</a>
                    <a href="#" class="social-dot" aria-label="YouTube">YT</a>
                </div>
            </div>

            <div class="footer-links">
                <h4>Quick Links</h4>
                <a href="<%= contextPath %>/">Home</a>
                <a href="<%= contextPath %>/register">Register</a>
                <a href="<%= contextPath %>/login">Login</a>
                <a href="<%= contextPath %>/dashboard">Dashboard</a>
            </div>

            <div class="footer-contact">
                <h4>Contact</h4>
                <p>123 Green Street</p>
                <p>community@foodsharehub.com</p>
                <p>(555) 555-5555</p>
            </div>
        </div>

        <div class="footer-bottom">
            <p class="footer-copy">FoodShare Hub © 2026 | Connect donors, volunteers & communities.</p>
        </div>
        </div>
    </div>
</footer>
</main>
</body>
</html>
