<%--
  Created by IntelliJ IDEA.
  User: suiij
  Date: 5/1/2026
  Time: 8:38 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %>
<section class="content-card">
    <h2 class="page-title">Add Donation</h2>
    <p>Tell us what you would like to donate and where it can be picked up.</p>

    <form action="<%= contextPath %>/donations" method="post" class="form-grid">
        <label class="label" for="foodName">Food Name</label>
        <input class="input-field" type="text" id="foodName" name="foodName" required>

        <label class="label" for="quantity">Quantity</label>
        <input class="input-field" type="number" id="quantity" name="quantity" required>

        <label class="label" for="expiryDate">Expiry Date</label>
        <input class="input-field" type="date" id="expiryDate" name="expiryDate">

        <label class="label" for="location">Location</label>
        <input class="input-field" type="text" id="location" name="location" required>

        <button class="primary-button" type="submit">Add Donation</button>
    </form>
</section>
<%@ include file="../includes/footer.jsp" %>
