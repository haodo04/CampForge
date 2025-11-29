
// Toggle show/hide password
function togglePw(id, btnEl) {
  const input = document.getElementById(id);
  if (!input) return;

  const isPassword = input.type === "password";
  input.type = isPassword ? "text" : "password";

  if (btnEl) btnEl.textContent = isPassword ? "Hide" : "Show";
}

// Query elements
const form        = document.getElementById('registerForm');
const email       = document.getElementById('regEmail');
const password    = document.getElementById('regPassword');
const confirmPw   = document.getElementById('confirm');
const agree       = document.getElementById('agree');
const createBtn   = document.getElementById('createBtn');

// Error message blocks
const emailErr = document.getElementById('emailErr');
const pwErr    = document.getElementById('pwErr');
const cfErr    = document.getElementById('cfErr');
const meter    = document.getElementById('meter');

// Password strength meter
function strength(pw) {
  let s = 0;
  if (pw.length >= 6) s++;
  if (/[A-Z]/.test(pw)) s++;
  if (/[0-9]/.test(pw)) s++;
  if (/[^A-Za-z0-9]/.test(pw)) s++;
  return s; // 0..4
}

password.addEventListener('input', () => {
  const s = strength(password.value);
  const w = [0, 25, 50, 75, 100][s];
  meter.style.width = w + '%';
  meter.style.background = s <= 1 ? '#ef4444' : (s === 2 ? '#f59e0b' : '#10b981');
});

// Submit validation
form.addEventListener('submit', (e) => {
  e.preventDefault();

  // Reset errors
  emailErr.classList.remove('show');
  pwErr.classList.remove('show');
  cfErr.classList.remove('show');

  let ok = true;

  // validate email
  if (!email.value || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
    emailErr.classList.add('show');
    ok = false;
  }

  // validate password
  const validPw =
    password.value.length >= 6 &&
    /[A-Za-z]/.test(password.value) &&
    /[0-9]/.test(password.value);

  if (!validPw) {
    pwErr.classList.add('show');
    ok = false;
  }

  // confirm password
  if (password.value !== confirmPw.value) {
    cfErr.classList.add('show');
    ok = false;
  }

  // terms
  if (!agree.checked) {
    alert("Vui lòng đồng ý với Điều khoản & Chính sách bảo mật.");
    ok = false;
  }

  // final
  if (ok) {
    createBtn.disabled = true;
    createBtn.textContent = "Creating…";

    setTimeout(() => {
      createBtn.disabled = false;
      createBtn.textContent = "Create account";
      alert("Account created! (demo)");
      // window.location.href = "./login.html";
    }, 900);
  }
});
