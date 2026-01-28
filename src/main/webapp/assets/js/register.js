document.addEventListener("DOMContentLoaded", function() {
  // 1. Lấy đúng ID từ file JSP của bạn
  const form = document.getElementById('registerForm');
  const email = document.getElementById('regEmail');
  const password = document.getElementById('regPassword');
  const confirm = document.getElementById('confirm');
  const submitBtn = document.getElementById('createBtn');

  if (form) {
    form.addEventListener('submit', function(e) {
      e.preventDefault();

      let ok = true;

      // Kiểm tra email
      if (!email.value || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
        alert("Email không hợp lệ!");
        ok = false;
      }

      // Kiểm tra mật khẩu (độ dài >= 6)
      if (ok && password.value.length < 6) {
        alert("Mật khẩu phải có ít nhất 6 ký tự!");
        ok = false;
      }

      // Kiểm tra khớp mật khẩu
      if (ok && password.value !== confirm.value) {
        alert("Mật khẩu xác nhận không khớp!");
        ok = false;
      }

      // 2. Nếu mọi thứ OK -> Gửi dữ liệu thật về Servlet
      if (ok) {
        submitBtn.disabled = true;
        submitBtn.textContent = "Đang tạo...";

        // Lệnh này sẽ kích hoạt doPost trong RegisterServlet
        form.submit();
      }
    });
  }
});

// Hàm toggle mật khẩu phải để ngoài để gọi được từ onclick trong JSP
function togglePw(id, btnEl) {
  const input = document.getElementById(id);
  if (input) {
    const isPw = input.type === "password";
    input.type = isPw ? "text" : "password";
    btnEl.textContent = isPw ? "ẩn" : "hiện";
  }
}