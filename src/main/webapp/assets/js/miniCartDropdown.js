const ctx = window.contextPath || "";

const wrap = document.getElementById("miniCartWrap");
const body = document.getElementById("mcddBody");
const totalEl = document.getElementById("mcddTotal");
const countEl = document.getElementById("mcddCount");
const badgeEl = document.getElementById("miniCartQty");


const formatVND = (value) => {
    const n = Number(value);
    if (!Number.isFinite(n)) return "0 ₫";
    return new Intl.NumberFormat("vi-VN", { style: "currency", currency: "VND" }).format(n);
};

let loadedOnce = false;
let loading = false;

async function fetchMiniCart() {
    if (loading) return;
    loading = true;
    try {
        const res = await fetch(`${ctx}/cart?action=mini`, { method: "GET" });
        const data = await res.json();
        renderMiniCart(data);
        loadedOnce = true;
    } catch (e) {
        body.innerHTML = `<div class="mcdd-empty">Không tải được giỏ hàng.</div>`;
    } finally {
        loading = false;
    }
}

function renderMiniCart(data) {
    if (!data || !data.ok) {
        body.innerHTML = `<div class="mcdd-empty">Giỏ hàng trống.</div>`;
        totalEl.textContent = "0";
        countEl.textContent = "0 sản phẩm";
        return;
    }

    if (badgeEl && typeof data.cartCount !== "undefined") {
        const n = Number(data.cartCount) || 0;
        if (n > 0) {
            badgeEl.textContent = n;
            badgeEl.style.display = "inline-flex";
        } else {
            badgeEl.textContent = "";
            badgeEl.style.display = "none";
        }
    }


    totalEl.textContent = formatVND(data.totalAmount);
    const distinct = (data.items && data.items.length) ? data.items.length : 0;
    countEl.textContent = `${distinct} sản phẩm`;

    if (!data.items || data.items.length === 0) {
        body.innerHTML = `<div class="mcdd-empty">Giỏ hàng đang trống.</div>`;
        return;
    }

    body.innerHTML = data.items.map(it => `
    <div class="mcdd-item">
      <img src="${ctx}/${it.img}" alt="">
      <div>
        <div class="mcdd-name">${escapeHtml(it.name)}</div>
        <div class="mcdd-meta">
          <span>x${it.qty}</span>
          <strong>${formatVND(it.lineTotal)}</strong>
        </div>
      </div>
    </div>
  `).join("");
}

function escapeHtml(s){
    return (s||"")
        .replaceAll("&","&amp;")
        .replaceAll("<","&lt;")
        .replaceAll(">","&gt;")
        .replaceAll('"',"&quot;")
        .replaceAll("'","&#039;");
}

// Hover lần đầu thì load
if (wrap && body && totalEl && countEl) {
    wrap.addEventListener("mouseenter", () => {
        if (!loadedOnce) {
            body.innerHTML = `<div class="mcdd-empty">Đang tải...</div>`;
            fetchMiniCart();
        }
    });
}


// Expose để gọi sau addAjax
window.refreshMiniCartDropdown = function () {
    loadedOnce = false;
    fetchMiniCart();
};

