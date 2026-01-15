<%--
  Created by IntelliJ IDEA.
  User: LAPTOP USA PRO
  Date: 1/15/2026
  Time: 1:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đổi mật khẩu</title>
</head>
<body>
    <form action="reset-password" method="post">
        <input type="hidden" name="token" value="${token}">
        <input type="password" name="password" placeholder="Mật khẩu mới" required>
        <button type="submit">Cập nhật mật khẩu</button>
    </form>
</body>
</html>
