<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.advancedprogramming.foodsharehub.user.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - FoodShareHub</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 280px;
            background: linear-gradient(135deg, #1a4d5c 0%, #0f3a47 100%);
            color: #ffffff;
            padding: 20px 0;
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            overflow-y: auto;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.15);
        }

        .sidebar-logo {
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 30px;
        }

        .sidebar-logo h3 {
            font-size: 1.3rem;
            letter-spacing: 1px;
        }

        .sidebar-section {
            padding: 0 15px;
            margin-bottom: 30px;
        }

        .sidebar-section-title {
            font-size: 0.75rem;
            color: rgba(255, 255, 255, 0.6);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 12px;
            padding-left: 10px;
        }

        .sidebar-menu {
            list-style: none;
        }

        .sidebar-menu li {
            margin-bottom: 8px;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .sidebar-menu a:hover {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            padding-left: 20px;
        }

        .sidebar-menu a.active {
            background: #00bcd4;
            color: #ffffff;
        }

        .main-content {
            margin-left: 280px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .top-header {
            background: #ffffff;
            border-bottom: 1px solid #e0e0e0;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .header-brand {
            font-size: 1.5rem;
            font-weight: 600;
            color: #1a4d5c;
        }

        .header-user {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #1a4d5c;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        .content-wrapper {
            padding: 30px;
            flex: 1;
        }

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-size: 2rem;
            color: #1a4d5c;
            margin-bottom: 5px;
        }

        .page-header p {
            color: #666;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
        }

        .stat-info h3 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .stat-info p {
            font-size: 1rem;
            color: #666;
        }

        .action-area {
        .card-red { background: linear-gradient(135deg, #f44336, #d32f2f); }
        .card-orange { background: linear-gradient(135deg, #ff9800, #f57c00); }
        .card-blue { background: linear-gradient(135deg, #2196f3, #1976d2); }

        .action-area {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .action-area h2 {
            color: #1a4d5c;
            margin-bottom: 20px;
            font-size: 1.5rem;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 15px;
        }

        .action-btn {
            background: #1a4d5c;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .action-btn:hover {
            background: #0f3a47;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(26, 77, 92, 0.3);
        }

        .action-btn.secondary {
            background: #e0e0e0;
            color: #333;
        }

        .action-btn.secondary:hover {
            background: #d0d0d0;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 250px;
            }

            .main-content {
                margin-left: 250px;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .page-header h1 {
                font-size: 1.5rem;
            }

            .top-header {
                padding: 12px 20px;
            }

            .content-wrapper {
                padding: 20px;
            }
        }

        @media (max-width: 600px) {
            .sidebar {
                width: 100%;
                position: relative;
                height: auto;
            }

            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <aside class="sidebar">
            <div class="sidebar-logo">
                <h3> FoodShare Hub</h3>
            </div>

            <div class="sidebar-section">
                <h4 class="sidebar-section-title">General</h4>
                <ul class="sidebar-menu">
                    <li><a href="<%= contextPath %>/admin-dashboard" class="active"> Dashboard</a></li>
                    <li><a href="#">👤 Profile</a></li>
                </ul>
            </div>

            <div class="sidebar-section">
                <h4 class="sidebar-section-title">Management</h4>
                <ul class="sidebar-menu">
                    <li><a href="<%= contextPath %>/donations"> Manage Donations</a></li>
                    <li><a href="#"> Manage Users</a></li>
                    <li><a href="#"> Verify Donations</a></li>
                </ul>
            </div>

            <div class="sidebar-section">
                <h4 class="sidebar-section-title">Other</h4>
                <ul class="sidebar-menu">
                    <li><a href="<%= contextPath %>/logout"> Logout</a></li>
                </ul>
            </div>
        </aside>

        <main class="main-content">
            <header class="top-header">
                <div class="header-brand">Admin Dashboard</div>
                <div class="header-user">
                    <span>Welcome, <%= user != null ? user.getFullName() : "Admin" %></span>
                    <div class="user-avatar"><%= user != null && !user.getFullName().isEmpty() ? user.getFullName().charAt(0) : "A" %></div>
                </div>
            </header>

            <div class="content-wrapper">
                <div class="page-header">
                    <h1>Control Panel</h1>
                    <p>Overview and manage your FoodShareHub platform</p>
                </div>

                <div class="dashboard-grid">
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>12</h3>
                            <p>Total Users</p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>28</h3>
                            <p>Active Donations</p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>15</h3>
                            <p>Pending Review</p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>8</h3>
                            <p>Completed Donations</p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>5</h3>
                            <p>Active Volunteers</p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>3</h3>
                            <p>Reported Issues</p>
                        </div>
                    </div>
                </div>

                <div class="action-area">
                    <h2>Quick Actions</h2>
                    <div class="action-buttons">
                        <a href="<%= contextPath %>/donations" class="action-btn">Manage Donations</a>
                        <a href="#" class="action-btn">View Users</a>
                        <a href="#" class="action-btn">Reports</a>
                        <a href="<%= contextPath %>/logout" class="action-btn secondary">Logout</a>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
