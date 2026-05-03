<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>
<section class="content-card">
    <h2 class="page-title">Admin Dashboard</h2>
    <p>Welcome, Admin! Review and manage donation records from one place.</p>
    <div class="action-grid">
        <a class="button" href="<%= contextPath %>/donations">Manage Donations</a>
        <a class="button" href="<%= contextPath %>/logout">Logout</a>
    </div>
</section>
<%@ include file="../includes/footer.jsp" %>