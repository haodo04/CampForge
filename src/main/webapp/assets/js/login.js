const form = document.getElementById('form');
const username = document.getElementById('username');
const password = document.getElementById('password');
const submitBtn = document.getElementById('submit');

function togglePw() {
    const is = password.type === 'password';
    password.type = is ? 'text' : 'password';
    document.querySelector('.toggle').textContent = is ? 'Ẩn' : 'Hiện';
}

form.addEventListener('submit', (e) => {
    let ok = true;

    // 1. Validate đơn giản trước khi gửi lên Server
    if (username.value.trim().length < 3) {
        alert("Tên đăng nhập phải có ít nhất 3 ký tự");
        ok = false;
    } else if (password.value.length < 6) {
        alert("Mật khẩu phải có ít nhất 6 ký tự");
        ok = false;
    }

    if (!ok) {
        // Nếu có lỗi thì chặn lại không cho gửi tới Servlet
        e.preventDefault();
    } else {
        // Nếu OK, tắt nút để tránh bấm nhiều lần và để form tự gửi (không preventDefault)
        submitBtn.disabled = true;
        submitBtn.textContent = 'Đang đăng nhập...';
    }
});