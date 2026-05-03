<%--
  Created by IntelliJ IDEA.
  User: suiij
  Date: 5/1/2026
  Time: 8:38 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>
<section class="content-card">
    <h2 class="page-title">Donor Dashboard</h2>
    <p>Welcome, ${user.fullName}! Use the links below to add donations or review your contributions.</p>
    <div class="action-grid">
        <a class="button" href="<%= contextPath %>/pages/add-donation.jsp">Add Donation</a>
        <a class="button" href="<%= contextPath %>/donations">View My Donations</a>
        <a class="button" href="<%= contextPath %>/logout">Logout</a>
    </div>
</section>
<%@ include file="../includes/footer.jsp" %>
