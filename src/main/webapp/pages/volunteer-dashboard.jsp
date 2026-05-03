<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>
<section class="content-card">
    <h2 class="page-title">Volunteer Dashboard</h2>
    <p>Welcome, ${user.fullName}! Find available donations and support your community.</p>
    <div class="action-grid">
        <a class="button" href="<%= contextPath %>/donations">View Available Donations</a>
        <a class="button" href="<%= contextPath %>/logout">Logout</a>
    </div>
</section>
<%@ include file="../includes/footer.jsp" %>