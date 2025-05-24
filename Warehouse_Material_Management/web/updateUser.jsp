<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Cập nhật người dùng</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/createUser.css" />
</head>
<body>
<div class="form-container">
    <h2 class="form-title">Cập nhật người dùng</h2>

    <form action="<%=request.getContextPath()%>/UserUpdateServlet" method="post">
        <input type="hidden" name="userId" value="" />

        <label for="userName">Tên đăng nhập</label>
        <input type="text" id="userName" name="userName" required />

        <label for="fullName">Họ và tên</label>
        <input type="text" id="fullName" name="fullName" required />

        <label for="email">Email</label>
        <input type="email" id="email" name="email" required />

        <label for="password">Mật khẩu</label>
        <input type="password" id="password" name="password" placeholder="Nhập mật khẩu mới hoặc để trống" />

        <label for="phone">Số điện thoại</label>
        <input type="tel" id="phone" name="phone" />

        <label for="roleId">Vai trò</label>
        <select id="roleId" name="roleId" required>
            <option value="" disabled selected>Chọn vai trò</option>
            <option value="1">Nhân viên kho</option>
            <option value="2">Giám Đốc công ty</option>
            <option value="3">Nhân viên công ty</option>
        </select>

        <label for="status">Trạng thái</label>
        <select id="status" name="status">
            <option value="active" selected>Active</option>
            <option value="inactive">Inactive</option>
        </select>

        <label for="priority">Mức ưu tiên</label>
        <input type="number" id="priority" name="priority" min="0" value="0" />

        <button type="submit">Cập nhật người dùng</button>
    </form>
</div>
</body>
</html>
