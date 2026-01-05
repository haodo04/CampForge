const proDetails = document.getElementById("prodetails");
const ctx = proDetails?.dataset?.ctx || "";

function resolveUrl(path) {
    if (!path) return null;
    if (/^https?:\/\//i.test(path)) return path;
    if (ctx && path.startsWith(ctx)) return path;
    if (path.startsWith("/")) return ctx ? (ctx + path) : path;
    return ctx ? (ctx + "/" + path) : path;
}

const mainImg = document.getElementById("MainImg");
const thumbs = Array.from(document.querySelectorAll("#thumbList .small-img"));
const btnPrev = document.querySelector(".sp-prev");
const btnNext = document.querySelector(".sp-next");

const baseThumbUrls = thumbs
    .map(t => t.getAttribute("src"))
    .filter(Boolean)
    .map(resolveUrl)
    .filter(Boolean);

let slideUrls = [];
let current = 0;

function buildSlideUrls(mainSrc) {
    const resolvedMain = resolveUrl(mainSrc) || mainSrc;
    slideUrls = [resolvedMain, ...baseThumbUrls];
}

function render(idx) {
    if (!mainImg || slideUrls.length === 0) return;

    current = (idx + slideUrls.length) % slideUrls.length;
    mainImg.src = slideUrls[current];

    thumbs.forEach(t => t.classList.remove("active"));
    if (current > 0) thumbs[current - 1].classList.add("active");
}

function setMainImageAndResetSlider(newMainSrc) {
    if (!mainImg) return;
    const resolved = resolveUrl(newMainSrc) || newMainSrc;
    buildSlideUrls(resolved);
    render(0);
}

if (mainImg) {
    buildSlideUrls(mainImg.getAttribute("src"));
    render(0);
}

thumbs.forEach((t, i) => t.addEventListener("click", () => render(i + 1)));
if (btnPrev) btnPrev.addEventListener("click", () => render(current - 1));
if (btnNext) btnNext.addEventListener("click", () => render(current + 1));

mainImg?.addEventListener("click", () => {
    if (slideUrls.length > 1) render(current + 1);
});

const qtyInput = document.getElementById("qtyInput");
const qtyMinus = document.getElementById("qtyMinus");
const qtyPlus = document.getElementById("qtyPlus");

function clampQty() {
    if (!qtyInput) return;

    let val = parseInt(qtyInput.value, 10);
    if (Number.isNaN(val) || val < 1) val = 1;

    const stock = parseInt(document.getElementById("pdStock")?.innerText || "0", 10);
    if (!Number.isNaN(stock) && stock > 0) val = Math.min(val, stock);

    qtyInput.value = String(val);
    if (qtyMinus) qtyMinus.disabled = val <= 1;
}

if (qtyInput) {
    qtyInput.addEventListener("input", () => {
        qtyInput.value = qtyInput.value.replace(/[^\d]/g, "");
    });
    qtyInput.addEventListener("blur", clampQty);
}

if (qtyMinus) {
    qtyMinus.addEventListener("click", () => {
        const cur = parseInt(qtyInput?.value || "1", 10) || 1;
        qtyInput.value = String(Math.max(1, cur - 1));
        clampQty();
    });
}

if (qtyPlus) {
    qtyPlus.addEventListener("click", () => {
        const cur = parseInt(qtyInput?.value || "1", 10) || 1;
        qtyInput.value = String(cur + 1);
        clampQty();
    });
}

clampQty();

const variantEl = document.getElementById("variantData");
const variants = variantEl ? JSON.parse(variantEl.textContent || "[]") : [];

const colorChips = Array.from(document.querySelectorAll("#colorChips .chip"));
const sizeChips = Array.from(document.querySelectorAll("#sizeChips .chip"));

const pdPrice = document.getElementById("pdPrice");
const pdStock = document.getElementById("pdStock");
const btnAdd = document.getElementById("btnAddToCart");


let selected = { color: null, size: null };

function formatVnd(n) {
    try {
        return new Intl.NumberFormat("vi-VN").format(Number(n || 0)) + " đ";
    } catch {
        return (n || 0) + " đ";
    }
}

function setActiveChip(chips, value) {
    chips.forEach(c => c.classList.toggle("is-active", c.dataset.value === value));
}

function findVariant(color, size) {
    return (
        variants.find(v => {
            const okColor = color == null || v.color === color;
            const okSize = size == null || v.size === size;
            return okColor && okSize;
        }) || null
    );
}

function availableValues(attr, partial) {
    const s = new Set();
    for (const v of variants) {
        if (partial.color && v.color !== partial.color) continue;
        if (partial.size && v.size !== partial.size) continue;
        if (v[attr] != null && v[attr] !== "") s.add(v[attr]);
    }
    return s;
}

function syncDisableStates() {
    if (sizeChips.length > 0) {
        const allowSizes = selected.color ? availableValues("size", { color: selected.color }) : null;
        sizeChips.forEach(ch => {
            const ok = allowSizes ? allowSizes.has(ch.dataset.value) : true;
            ch.disabled = !ok;
            ch.classList.toggle("is-disabled", !ok);
        });
    }

    if (colorChips.length > 0) {
        const allowColors = selected.size ? availableValues("color", { size: selected.size }) : null;
        colorChips.forEach(ch => {
            const ok = allowColors ? allowColors.has(ch.dataset.value) : true;
            ch.disabled = !ok;
            ch.classList.toggle("is-disabled", !ok);
        });
    }
}

function applyVariantUI(v) {
    if (!v) {
        if (btnAdd) btnAdd.disabled = true;
        return;
    }

    if (pdPrice) pdPrice.innerText = formatVnd(v.finalPrice);
    if (pdStock) pdStock.innerText = String(v.stock ?? 0);

    if (btnAdd) {
        btnAdd.dataset.variantId = String(v.id);
        btnAdd.dataset.price = String(v.finalPrice);

        const inStock = Number(v.stock || 0) > 0;
        btnAdd.disabled = !inStock;
    }

    if (v.image) setMainImageAndResetSlider(v.image);

    if (qtyInput) qtyInput.value = "1";

    clampQty();
}


function syncAll() {
    setActiveChip(colorChips, selected.color);
    setActiveChip(sizeChips, selected.size);

    syncDisableStates();

    const v = findVariant(selected.color, selected.size);
    applyVariantUI(v);
}

colorChips.forEach(ch =>
    ch.addEventListener("click", () => {
        if (ch.disabled) return;

        selected.color = ch.dataset.value;

        if (sizeChips.length > 0) {
            const allowSizes = availableValues("size", { color: selected.color });
            if (selected.size && !allowSizes.has(selected.size)) selected.size = null;
        }

        syncAll();
    })
);

sizeChips.forEach(ch =>
    ch.addEventListener("click", () => {
        if (ch.disabled) return;

        selected.size = ch.dataset.value;

        if (colorChips.length > 0) {
            const allowColors = availableValues("color", { size: selected.size });
            if (selected.color && !allowColors.has(selected.color)) selected.color = null;
        }

        syncAll();
    })
);

(function initFromSelectedVariantId() {
    const selectedId = btnAdd?.dataset?.variantId;
    const v = selectedId ? variants.find(x => String(x.id) === String(selectedId)) : null;

    if (v) {
        selected.color = v.color || null;
        selected.size = v.size || null;
    } else if (variants.length > 0) {
        selected.color = variants[0].color || null;
        selected.size = variants[0].size || null;
    }

    syncAll();
})();

// add to cart
async function addToCartAjax(variantId, qty) {
    const url = `${ctx}/cart?action=addAjax&variantId=${encodeURIComponent(variantId)}&qty=${encodeURIComponent(qty)}`;

    const res = await fetch(url, {
        method: "GET",
        headers: { "Accept": "application/json" }
    });

    if (!res.ok) throw new Error("HTTP " + res.status);

    const data = await res.json();
    if (!data || !data.ok) {
        throw new Error(data?.message || "Không thể thêm vào giỏ hàng");
    }
    return data;
}

function setMiniCartBadge(n) {
    const badgeEl = document.getElementById("miniCartQty");
    if (!badgeEl) return;

    const num = Number(n) || 0;
    if (num > 0) {
        badgeEl.textContent = num;
        badgeEl.style.display = "inline-flex";
    } else {
        badgeEl.textContent = "";
        badgeEl.style.display = "none";
    }
}

if (btnAdd) {
    btnAdd.addEventListener("click", async (e) => {
        e.preventDefault();

        const variantId = btnAdd.dataset.variantId;
        const qty = parseInt(qtyInput?.value || "1", 10) || 1;

        if (!variantId) {
            alert("Vui lòng chọn phân loại (màu/size) trước khi thêm.");
            return;
        }

        try {
            const data = await addToCartAjax(variantId, qty);

            if (typeof window.refreshMiniCartDropdown === "function") {
                window.refreshMiniCartDropdown();
            }

            if (qtyInput) qtyInput.value = "1";
        } catch (err) {
            console.error(err);
            alert(err.message || "Có lỗi khi thêm vào giỏ");
        }
    });
}

document.addEventListener("click", async (e) => {
    const btn = e.target.closest(".js-add-to-cart");
    if (!btn) return;

    e.preventDefault();
    e.stopPropagation();

    const variantId = btn.dataset.variantId;
    if (!variantId) return;

    try {
        const url = `${window.contextPath}/cart?action=addAjax&variantId=${encodeURIComponent(variantId)}&qty=1`;
        const res = await fetch(url, { headers: { "Accept": "application/json" } });
        const data = await res.json();
        if (!res.ok || !data?.ok) throw new Error(data?.message || "Không thêm vào giỏ được");

        if (typeof window.refreshMiniCartDropdown === "function") window.refreshMiniCartDropdown();
    } catch (err) {
        console.error(err);
        alert(err.message || "Có lỗi khi thêm vào giỏ");
    }
});


