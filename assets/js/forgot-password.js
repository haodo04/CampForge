const forgotForm = document.getElementById('forgotForm');
const forgotEmail = document.getElementById('forgotEmail');
const forgotSubmit = document.getElementById('forgotSubmit');

forgotForm.addEventListener('submit', (e) => {
  e.preventDefault();

  const value = forgotEmail.value.trim();
  const isValidEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);

  if (!value || !isValidEmail) {
    alert('Vui lòng nhập email hợp lệ.');
    return;
  }

  // Giả lập gửi mail
  forgotSubmit.disabled = true;
  forgotSubmit.textContent = 'Đang gửi…';

  setTimeout(() => {
    forgotSubmit.disabled = false;
    forgotSubmit.textContent = 'Gửi liên kết đặt lại';
    alert('Đã gửi liên kết đặt lại mật khẩu (demo). Vui lòng kiểm tra email!');
  }, 1000);
});
