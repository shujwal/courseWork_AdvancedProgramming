<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.advancedprogramming.foodsharehub.user.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.advancedprogramming.foodsharehub.donation.model.Donation" %>
<%@ page import="com.advancedprogramming.foodsharehub.user.model.dao.UserDao" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Donation> list = (List<Donation>) request.getAttribute("list");
    if (list == null) {
        list = new java.util.ArrayList<>();
    }
    UserDao userDao = new UserDao();
    List<User> volunteers = userDao.getAllVolunteers();
%>
<%@ include file="../includes/header.jsp" %>
<style>
    .content-card {
        max-width: 1180px;
        margin: 40px auto;
        padding: 38px 42px 44px;
        background: #fff;
        border-radius: 18px;
        box-shadow: 0 14px 36px rgba(20, 18, 45, 0.08);
        border: 1px solid rgba(0, 0, 0, 0.05);
    }

    .page-head {
        text-align: center;
        margin-bottom: 28px;
    }

    .page-title {
        font-size: 2.4rem;
        color: #18323a;
        margin-bottom: 10px;
        font-weight: 700;
    }

    .page-head p {
        color: #6b7280;
        font-size: 1.05rem;
        max-width: 720px;
        margin: 0 auto;
    }

    .page-divider {
        width: 64px;
        height: 4px;
        background: #1a4d5c;
        border-radius: 999px;
        margin: 14px auto 0;
    }

    .table-wrapper {
        margin-top: 18px;
        overflow-x: auto;
        border-radius: 14px;
        border: 1px solid #e7eef0;
        box-shadow: 0 10px 24px rgba(20, 18, 45, 0.05);
    }

    .table-list {
        width: 100%;
        border-collapse: collapse;
        background: #fff;
        font-size: 0.95rem;
    }

    .table-list th {
        background: #1a4d5c;
        color: #fff;
        padding: 1rem 1rem;
        text-align: left;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.4px;
        white-space: nowrap;
    }

    .table-list td {
        padding: 1rem;
        border-bottom: 1px solid #e9eff1;
        color: #38474f;
        vertical-align: top;
    }

    .table-list tr:nth-child(even) td {
        background: #fbfcfd;
    }

    .table-list tr:hover td {
        background: #eef5f6;
    }

    .table-list a {
        color: #1a4d5c;
        text-decoration: none;
        font-weight: 600;
    }

    .table-list a:hover {
        text-decoration: underline;
    }

    .assign-form {
        display: inline-flex;
        gap: 8px;
        align-items: center;
        flex-wrap: wrap;
    }

    .assign-form select {
        min-width: 160px;
        padding: 0.55rem 0.7rem;
        border: 1px solid #cfd8dc;
        border-radius: 8px;
        background: #fff;
        color: #24343b;
    }

    .assign-form .button {
        padding: 0.55rem 0.9rem;
        font-size: 0.92rem;
        background: #1a4d5c;
        color: #fff;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .assign-form .button:hover {
        transform: translateY(-1px);
        box-shadow: 0 8px 16px rgba(26, 77, 92, 0.18);
    }

    .empty-state {
        text-align: center;
        padding: 38px 16px;
        color: #6b7280;
    }

    .empty-state strong {
        display: block;
        margin-bottom: 6px;
        color: #18323a;
        font-size: 1.1rem;
    }

    @media (max-width: 768px) {
        .content-card {
            margin: 22px 14px;
            padding: 24px 18px 28px;
        }

        .page-title {
            font-size: 1.8rem;
        }

        .page-head p {
            font-size: 0.98rem;
        }

        .table-list th,
        .table-list td {
            padding: 0.85rem 0.8rem;
        }
    }
</style>
<section class="content-card">
    <div class="page-head">
        <h2 class="page-title">All Donations</h2>
        <p>All donations are visible here. Assign volunteers to donations and manage records.</p>
        <div class="page-divider"></div>
    </div>

    <div class="table-wrapper">
        <table class="table-list">
            <tr>
                <th>ID</th>
                <th>Food</th>
                <th>Qty</th>
                <th>Location</th>
                <th>Status</th>
                <th>Donor ID</th>
                <th>Volunteer</th>
                <th>Actions</th>
            </tr>
            <% if (list.isEmpty()) { %>
            <tr>
                <td colspan="8">
                    <div class="empty-state">
                        <strong>No donations found.</strong>
                        <div>When donations are added, they will appear here.</div>
                    </div>
                </td>
            </tr>
            <% } else {
                for (Donation d : list) {
            %>
            <tr>
                <td><%= d.getId() %></td>
                <td><%= d.getFoodName() %></td>
                <td><%= d.getQuantity() %></td>
                <td><%= d.getLocation() %></td>
                <td><%= d.getStatus() != null ? d.getStatus() : "Pending" %></td>
                <td><%= d.getDonorId() %></td>
                <td><%= d.getVolunteerId() > 0 ? d.getVolunteerId() : "None" %></td>
                <td>
                    <% if ("Available".equalsIgnoreCase(d.getStatus()) || d.getStatus() == null || d.getStatus().isEmpty()) { %>
                    <form action="<%= contextPath %>/donations" method="get" class="assign-form">
                        <input type="hidden" name="action" value="assign">
                        <input type="hidden" name="id" value="<%= d.getId() %>">
                        <select name="volunteerName" required>
                            <option value="">-- Select Volunteer --</option>
                            <% for (User vol : volunteers) { %>
                            <option value="<%= vol.getFullName() %>"><%= vol.getFullName() %></option>
                            <% } %>
                        </select>
                        <button class="button" type="submit">Assign</button>
                    </form>
                    <% } %>
                    <a href="<%= contextPath %>/donations?action=delete&id=<%= d.getId() %>">Delete</a>
                </td>
            </tr>
            <%   }
            } %>
        </table>
    </div>
</section>
<%@ include file="../includes/footer.jsp" %>
