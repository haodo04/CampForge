const form = document.getElementById('form');
    const email = document.getElementById('email');
    const password = document.getElementById('password');
    const submit = document.getElementById('submit');

    function togglePw(){
      const is = password.type === 'password';
      password.type = is ? 'text' : 'password';
      document.querySelector('.toggle').textContent = is ? 'Ẩn' : 'Hiện';
    }

    form.addEventListener('submit', (e) => {
      e.preventDefault();
      let ok = true;
      if(!email.value || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) ok = false;
      if(!password.value || password.value.length < 6) ok = false;

      if(ok){
        submit.disabled = true; submit.textContent = 'Signing in…';
        setTimeout(()=>{ submit.disabled = false; submit.textContent = 'Sign in'; alert('Logged in! (demo)'); }, 900);
      } else {
        alert('Please check your email and password.');
      }
    });