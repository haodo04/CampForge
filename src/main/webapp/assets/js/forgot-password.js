const forgotForm = document.getElementById('forgotForm');
const forgotEmail = document.getElementById('forgotEmail');
const forgotSubmit = document.getElementById('forgotSubmit');

if (forgotForm) {
  forgotForm.addEventListener('submit', (e) => {
    // Chặn load trang để kiểm tra email trước
    const value = forgotEmail.value.trim();
    const isValidEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);

    if (!value || !isValidEmail) {
      e.preventDefault();
      alert('Vui lòng nhập email hợp lệ.');
      return;
    }

    // Hiển thị trạng thái đang xử lý
    forgotSubmit.disabled = true;
    forgotSubmit.textContent = 'Đang gửi...';

    // LỆNH QUAN TRỌNG: Gửi form thật sự lên Servlet
    // forgotForm.submit();
  });
}