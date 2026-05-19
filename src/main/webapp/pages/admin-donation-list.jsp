<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>
<style>
    .landing-shell {
        max-width: 1200px;
        margin: 36px auto 0;
        padding: 0 20px;
    }

    .hero-panel,
    .section-card,
    .cta-panel {
        background: #fff;
        border-radius: 18px;
        box-shadow: 0 12px 34px rgba(20, 18, 45, 0.08);
        border: 1px solid rgba(0, 0, 0, 0.05);
    }

    .hero-panel {
        display: grid;
        grid-template-columns: 1.3fr 0.9fr;
        gap: 28px;
        padding: 42px;
        align-items: center;
    }

    .eyebrow {
        display: inline-block;
        padding: 0.4rem 0.8rem;
        border-radius: 999px;
        background: #eaf4ef;
        color: #1a4d5c;
        font-weight: 700;
        font-size: 0.85rem;
        margin-bottom: 18px;
    }

    .hero-panel h1 {
        font-size: clamp(2.2rem, 4vw, 3.4rem);
        line-height: 1.1;
        color: #18323a;
        margin-bottom: 16px;
    }

    .hero-panel p {
        color: #5f6f77;
        font-size: 1.05rem;
        line-height: 1.8;
        max-width: 620px;
    }

    .hero-actions {
        display: flex;
        flex-wrap: wrap;
        gap: 12px;
        margin-top: 24px;
    }

    .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 0.9rem 1.3rem;
        border-radius: 10px;
        text-decoration: none;
        font-weight: 700;
        border: 1px solid transparent;
        transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
    }

    .btn.primary {
        background: #1a4d5c;
        color: #fff;
        box-shadow: 0 10px 20px rgba(26, 77, 92, 0.18);
    }

    .btn.secondary {
        background: #fff;
        color: #1a4d5c;
        border-color: #c9dde2;
    }

    .btn:hover {
        transform: translateY(-2px);
    }

    .hero-visual {
        padding: 28px;
        background: linear-gradient(180deg, #f7fafb 0%, #edf4f5 100%);
        border-radius: 16px;
        border: 1px solid #e5edf0;
        min-height: 260px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        gap: 16px;
    }

    .hero-visual .metric {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #fff;
        border-radius: 12px;
        padding: 14px 16px;
        box-shadow: 0 8px 18px rgba(20, 18, 45, 0.05);
    }

    .metric strong { color: #18323a; font-size: 1.1rem; }
    .metric span { color: #6b7280; }

    .section-title {
        text-align: center;
        margin: 48px 0 18px;
        color: #18323a;
        font-size: 1.9rem;
    }

    .section-card {
        padding: 28px;
    }

    .features-grid,
    .steps-grid,
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 18px;
    }

    .feature,
    .step,
    .stat {
        background: #f8fbfc;
        border: 1px solid #e6eff1;
        border-radius: 14px;
        padding: 22px;
        min-height: 170px;
    }

    .feature h3,
    .step h3,
    .stat h3 {
        color: #18323a;
        margin-bottom: 10px;
        font-size: 1.15rem;
    }

    .feature p,
    .step p,
    .stat p {
        color: #66757d;
        line-height: 1.7;
    }

    .stat strong {
        display: block;
        font-size: 2rem;
        color: #1a4d5c;
        margin-bottom: 6px;
    }

    .cta-panel {
        margin: 48px 0 0;
        padding: 30px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        background: linear-gradient(135deg, #f8fbfc 0%, #eef5f6 100%);
    }

    .cta-panel h2 {
        color: #18323a;
        margin-bottom: 8px;
    }

    .cta-panel p { color: #60727a; }

    @media (max-width: 900px) {
        .hero-panel,
        .features-grid,
        .steps-grid,
        .stats-grid,
        .cta-panel {
            grid-template-columns: 1fr;
        }

        .hero-panel,
        .cta-panel {
            display: flex;
            flex-direction: column;
            align-items: stretch;
        }
    }

    @media (max-width: 600px) {
        .landing-shell { padding: 0 14px; }
        .hero-panel { padding: 24px; }
        .section-card { padding: 22px; }
        .section-title { font-size: 1.5rem; }
    }
</style>

<div class="landing-shell">
    <section class="hero-panel">
        <div>
            <span class="eyebrow">FoodShareHub</span>
            <h1>Every donation counts. Start giving now.</h1>
            <p>
                Connect surplus food with local communities through a simple, safe, and organized platform.
                FoodShareHub helps donors, volunteers, and recipients work together to reduce waste and share more meals.
            </p>

            <div class="hero-actions">
                <a class="btn primary" href="<%= contextPath %>/register">Get Started</a>
                <a class="btn secondary" href="<%= contextPath %>/donations">Browse Donations</a>
            </div>
        </div>

        <div class="hero-visual">
            <div class="metric"><strong>260+</strong><span>donations posted this month</span></div>
            <div class="metric"><strong>12,000</strong><span>meals shared to date</span></div>
            <div class="metric"><strong>68</strong><span>active community requests</span></div>
        </div>
    </section>

    <h2 class="section-title">Start Overview</h2>
    <section class="section-card">
        <div class="stats-grid">
            <div class="stat"><strong>260</strong><p>Donations posted this month</p></div>
            <div class="stat"><strong>68</strong><p>Active requests fulfilled</p></div>
            <div class="stat"><strong>12,000</strong><p>Meals shared to date</p></div>
        </div>
    </section>

    <h2 class="section-title">How it works</h2>
    <section class="section-card">
        <div class="steps-grid">
            <div class="step"><h3>1. Post a donation</h3><p>Add your food details, quantity, and pickup location in a few simple steps.</p></div>
            <div class="step"><h3>2. Match with volunteers</h3><p>Volunteers or recipients can coordinate safe pickup and delivery details.</p></div>
            <div class="step"><h3>3. Share with the community</h3><p>Your donation reaches people who need it while helping reduce food waste.</p></div>
        </div>
    </section>

    <h2 class="section-title">Why FoodShareHub</h2>
    <section class="section-card">
        <div class="features-grid">
            <div class="feature"><h3>Easy to use</h3><p>A clean and simple workflow helps donors list and manage food quickly.</p></div>
            <div class="feature"><h3>Community first</h3><p>Designed to support local volunteers, families, and organizations in one place.</p></div>
            <div class="feature"><h3>Safe sharing</h3><p>Structured donation details make coordination easier and more reliable.</p></div>
        </div>
    </section>

    <section class="cta-panel">
        <div>
            <h2>Ready to make a difference?</h2>
            <p>Join FoodShareHub today and start sharing food with your community.</p>
        </div>
        <div class="hero-actions" style="margin-top:0;">
            <% if (currentUser == null) { %>
            <a class="btn primary" href="<%= contextPath %>/register">Create Account</a>
            <a class="btn secondary" href="<%= contextPath %>/login">Login</a>
            <% } else { %>
            <a class="btn primary" href="<%= contextPath %>/dashboard">Go to Dashboard</a>
            <a class="btn secondary" href="<%= contextPath %>/donations">View Donations</a>
            <% } %>
        </div>
    </section>
</div>

<%@ include file="../includes/footer.jsp" %>
