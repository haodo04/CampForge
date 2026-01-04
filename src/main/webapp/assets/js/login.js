const form = document.getElementById('form');
const username = document.getElementById('username'); // Đã đổi từ email -> username
const password = document.getElementById('password');
const submit = document.getElementById('submit');

function togglePw() {
    const is = password.type === 'password';
    password.type = is ? 'text' : 'password';
    // Dùng textContent để thay đổi nhãn nút
    document.querySelector('.toggle').textContent = is ? 'Ẩn' : 'Hiện';
}

form.addEventListener('submit', (e) => {
    e.preventDefault();
    let ok = true;

    // 1. Kiểm tra Username (không để trống và ít nhất 3 ký tự)
    if (!username.value || username.value.trim().length < 3) {
        ok = false;
    }

    // 2. Kiểm tra Password (ít nhất 6 ký tự)
    if (!password.value || password.value.length < 6) {
        ok = false;
    }

    if (ok) {
        submit.disabled = true;
        submit.textContent = 'Đăng nhập…';

        // Giả lập gửi dữ liệu lên server
        setTimeout(() => {
            submit.disabled = false;
            submit.textContent = 'Đăng nhập';
            alert('Đăng nhập thành công! (demo)');
        }, 900);
    } else {
        alert('Vui lòng kiểm tra lại Tên đăng nhập (min 3 ký tự) và Mật khẩu (min 6 ký tự).');
    }
});