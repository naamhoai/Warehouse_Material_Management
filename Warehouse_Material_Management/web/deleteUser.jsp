<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Danh sách người dùng</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/deleteUser.css" />
    <script>
        function toggleButton(btn) {
            btn.classList.toggle('active');
            // TODO: bạn có thể thêm gọi Ajax hoặc submit form để cập nhật trạng thái server
        }

        function confirmMove(event, btn) {
            if (!confirm('Bạn có chắc chắn muốn dịch chuyển tài khoản này?')) {
                event.preventDefault();
                return false;
            }
            toggleButton(btn);
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Danh sách người dùng</h2>

    <table border="1" cellpadding="8" cellspacing="0">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên đăng nhập</th>
            <th>Họ và tên</th>
            <th>Email</th>
            <th>Vai trò</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>1</td>
            <td>kimoa123</td>
            <td>Nguyễn Văn A</td>
            <td>a@example.com</td>
            <td>Nhân viên kho</td>
            <td>active</td>
            <td>
                <form action="<%=request.getContextPath()%>/UserMoveServlet" method="post" style="display:inline;">
                    <input type="hidden" name="userId" value="1" />
                    <button type="submit" class="btn-move active"
                        onclick="confirmMove(event, this)">
                        <span class="dot"></span>
                    </button>
                </form>
            </td>
        </tr>
        <tr>
            <td>2</td>
            <td>admin</td>
            <td>Nguyễn Văn B</td>
            <td>admin@example.com</td>
            <td>Giám Đốc công ty</td>
            <td>inactive</td>
            <td>
                <button class="btn-move" disabled>
                    <span class="dot"></span>
                </button>
            </td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>
