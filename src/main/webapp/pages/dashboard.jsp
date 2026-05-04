<%--
  Created by IntelliJ IDEA.
  User: suiij
  Date: 5/1/2026
  Time: 8:38 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donor Dashboard - FoodShareHub</title>
    <style>
        :root{--accent:#1a4d5c;--muted:#666;--bg:#fbfcfd}
        *{box-sizing:border-box}
        html,body{margin:0;padding:0;background:var(--bg);font-family:Segoe UI,Arial,sans-serif}
        main{padding:28px 20px}
        .container{max-width:1200px;margin:0 auto}

        /* Hero / Banner */
        .hero{
            background:linear-gradient(90deg, rgba(26,77,92,0.95), rgba(15,58,71,0.95));
            color:#fff;border-radius:12px;padding:28px;display:flex;gap:24px;align-items:center;margin-bottom:36px;overflow:hidden
        }
        .hero .hero-copy{flex:1}
        .hero h2{font-size:1.8rem;margin-bottom:8px}
        .hero p{color:rgba(255,255,255,0.95);line-height:1.5}
        .hero .hero-actions{display:flex;gap:12px}
        .btn{background:var(--accent);color:#fff;padding:10px 18px;border-radius:8px;text-decoration:none;font-weight:600}
        .btn.secondary{background:#fff;color:var(--accent);border:1px solid rgba(0,0,0,0.06)}

        /* Start Overview cards */
        .overview{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:18px;margin-bottom:40px}
        .overview .card{background:#fff;border-radius:10px;padding:18px;text-align:center;box-shadow:0 6px 16px rgba(0,0,0,0.06)}
        .overview .card h3{font-size:1.6rem;color:var(--accent);margin-bottom:8px}
        .overview .card p{color:var(--muted);font-size:0.95rem}

        /* How it works */
        .how{margin-bottom:40px}
        .how-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:18px}
        .how-step{background:#fff;padding:18px;border-radius:10px;text-align:center;box-shadow:0 6px 16px rgba(0,0,0,0.06)}
        .how-step .num{width:44px;height:44px;border-radius:6px;background:var(--accent);color:#fff;display:inline-flex;align-items:center;justify-content:center;margin-bottom:12px}

        /* Recent donations table */
        .recent{margin-bottom:32px}
        table{width:100%;border-collapse:collapse;background:#fff;border-radius:8px;overflow:hidden;box-shadow:0 6px 18px rgba(0,0,0,0.06)}
        thead{background:#f3f6f6}
        th,td{padding:12px 14px;text-align:left;border-bottom:1px solid #eef2f2}
        tr:last-child td{border-bottom:none}

        .view-all{display:flex;justify-content:center;margin-top:18px}

        @media(max-width:600px){.hero{flex-direction:column;align-items:flex-start}.hero h2{font-size:1.3rem}}
    </style>
</head>
<body>
    <%@ include file="../includes/header.jsp" %>

    <main>
        <div class="container">
            <section class="hero">
                <div class="hero-copy">
                    <h2>Every donation counts. Start giving now.</h2>
                    <p>Share surplus food with local communities — it’s safe, simple and makes a big difference. Create a donation listing in a few easy steps and reach people who need it.</p>
                </div>
                <div class="hero-actions">
                    <a class="btn" href="<%= contextPath %>/pages/add-donation.jsp">Donate Food</a>
                    <a class="btn secondary" href="<%= contextPath %>/donations">Browse Donations</a>
                </div>
            </section>

            <h2 style="text-align:center;margin-bottom:18px">Start Overview</h2>
            <div class="overview">
                <div class="card"><h3>260</h3><p>Donations posted this month</p></div>
                <div class="card"><h3>68</h3><p>Active requests fulfilled</p></div>
                <div class="card"><h3>12,000</h3><p>Meals shared to date</p></div>
            </div>

            <h2 style="text-align:center;margin-bottom:18px">How it works</h2>
            <div class="how">
                <div class="how-grid">
                    <div class="how-step"><div class="num">1</div><h4>Post a donation</h4><p>Tell us what you're donating and where it's available.</p></div>
                    <div class="how-step"><div class="num">2</div><h4>Coordinate pickup</h4><p>Volunteer or recipient arranges safe pickup or drop-off.</p></div>
                    <div class="how-step"><div class="num">3</div><h4>Complete delivery</h4><p>Donation is received and shared with the community.</p></div>
                </div>
            </div>

            <h2 style="text-align:center;margin-bottom:12px">Recent Donations</h2>
            <section class="recent">
                <table>
                    <thead>
                        <tr><th>Food Item</th><th>Qty</th><th>Location</th><th>Status</th><th>Action</th></tr>
                    </thead>
                    <tbody>
                        <tr><td>Fresh Bread</td><td>20 loaves</td><td>Community Center</td><td>Available</td><td><a href="#">View</a></td></tr>
                        <tr><td>Vegetable Box</td><td>15 boxes</td><td>Market St.</td><td>Pending</td><td><a href="#">View</a></td></tr>
                    </tbody>
                </table>
                <div class="view-all"><a class="btn" href="<%= contextPath %>/donations">View All Donations</a></div>
            </section>
        </div>
    </main>

    <%@ include file="../includes/footer.jsp" %>
</body>
</html>
