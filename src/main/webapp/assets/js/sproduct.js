const mainImg = document.getElementById("MainImg");
const thumbs = Array.from(document.querySelectorAll("#thumbList .small-img"));
const btnPrev = document.querySelector(".sp-prev");
const btnNext = document.querySelector(".sp-next");

const mainSrc = mainImg.getAttribute("src");
const slideUrls = [mainSrc, ...thumbs.map(t => t.getAttribute("src"))];

let current = 0;

function render(idx) {
    current = (idx + slideUrls.length) % slideUrls.length;
    mainImg.src = slideUrls[current];

    thumbs.forEach(t => t.classList.remove("active"));
    if (current > 0) thumbs[current - 1].classList.add("active");
}

thumbs.forEach((t, i) => t.addEventListener("click", () => render(i + 1)));

if (btnPrev) btnPrev.addEventListener("click", () => render(current - 1));
if (btnNext) btnNext.addEventListener("click", () => render(current + 1));

mainImg.addEventListener("click", () => {
    if (slideUrls.length > 1) render(current + 1);
});

render(0);


// ===== Variant Picker (Shopee-like) =====
const variantEl = document.getElementById("variantData");
const variants = variantEl ? JSON.parse(variantEl.textContent || "[]") : [];

const colorChips = Array.from(document.querySelectorAll('#colorChips .chip'));
const sizeChips = Array.from(document.querySelectorAll('#sizeChips .chip'));

const pickedColor = document.getElementById("pickedColor");

const pdPrice = document.getElementById("pdPrice");
const pdStock = document.getElementById("pdStock");

const btnAdd = document.getElementById("btnAddToCart");

let selected = { color: null, size: null };

function formatVnd(n) {
    try { return new Intl.NumberFormat("vi-VN").format(Number(n || 0)) + " đ"; }
    catch { return (n || 0) + " đ"; }
}

function setActiveChip(chips, value) {
    chips.forEach(c => c.classList.toggle("is-active", c.dataset.value === value));
}

function findVariant(color, size) {
    return variants.find(v => v.color === color && v.size === size) || null;
}

function availableValues(attr, partial) {
    // partial: {color?, size?} -> trả về set các value hợp lệ cho attr còn lại
    const s = new Set();
    for (const v of variants) {
        if (partial.color && v.color !== partial.color) continue;
        if (partial.size && v.size !== partial.size) continue;
        s.add(v[attr]);
    }
    return s;
}

function syncDisableStates() {
    // disable size theo color đã chọn
    const allowSizes = selected.color ? availableValues("size", { color: selected.color }) : null;
    sizeChips.forEach(ch => {
        const ok = allowSizes ? allowSizes.has(ch.dataset.value) : true;
        ch.disabled = !ok;
        ch.classList.toggle("is-disabled", !ok);
    });

    // disable color theo size đã chọn
    const allowColors = selected.size ? availableValues("color", { size: selected.size }) : null;
    colorChips.forEach(ch => {
        const ok = allowColors ? allowColors.has(ch.dataset.value) : true;
        ch.disabled = !ok;
        ch.classList.toggle("is-disabled", !ok);
    });
}

function applyVariantUI(v) {
    if (!v) {
        // chưa đủ combo
        btnAdd && (btnAdd.disabled = true);
        return;
    }

    // update price + stock
    if (pdPrice) pdPrice.innerText = formatVnd(v.finalPrice);
    if (pdStock) pdStock.innerText = String(v.stock ?? 0);

    // update add-to-cart variant id & enable/disable by stock
    if (btnAdd) {
        btnAdd.dataset.variantId = String(v.id);
        btnAdd.dataset.price = String(v.finalPrice);

        const inStock = Number(v.stock || 0) > 0;
        btnAdd.disabled = !inStock;
    }
}

function syncAll() {
    pickedColor && (pickedColor.innerText = selected.color);

    setActiveChip(colorChips, selected.color);
    setActiveChip(sizeChips, selected.size);

    syncDisableStates();

    const v = (selected.color && selected.size) ? findVariant(selected.color, selected.size) : null;
    applyVariantUI(v);
}

// click handlers
colorChips.forEach(ch => ch.addEventListener("click", () => {
    selected.color = ch.dataset.value;

    // nếu size hiện tại không hợp lệ với color mới -> reset size
    const allowSizes = availableValues("size", { color: selected.color });
    if (selected.size && !allowSizes.has(selected.size)) selected.size = null;

    syncAll();
}));

sizeChips.forEach(ch => ch.addEventListener("click", () => {
    selected.size = ch.dataset.value;

    // nếu color hiện tại không hợp lệ với size mới -> reset color
    const allowColors = availableValues("color", { size: selected.size });
    if (selected.color && !allowColors.has(selected.color)) selected.color = null;

    syncAll();
}));

// init state từ server-selectedVariant (nếu có data-variant-id)
(function initFromSelectedVariantId() {
    const selectedId = btnAdd?.dataset?.variantId;
    if (!selectedId) { syncAll(); return; }
    const v = variants.find(x => String(x.id) === String(selectedId));
    if (v) {
        selected.color = v.color || null;
        selected.size = v.size || null;
    }
    syncAll();
})();


// ===== Quantity control =====
const qtyInput = document.getElementById("qtyInput");
const qtyMinus = document.getElementById("qtyMinus");
const qtyPlus = document.getElementById("qtyPlus");

function clampQty() {
    let val = parseInt(qtyInput.value, 10);
    if (Number.isNaN(val) || val < 1) val = 1;

    // nếu muốn chặn theo tồn kho đang hiển thị:
    const stock = parseInt(document.getElementById("pdStock")?.innerText || "0", 10);
    if (!Number.isNaN(stock) && stock > 0) val = Math.min(val, stock);

    qtyInput.value = String(val);
    if (qtyMinus) qtyMinus.disabled = val <= 1;
}

if (qtyInput) {
    qtyInput.addEventListener("input", () => {
        // chỉ cho số
        qtyInput.value = qtyInput.value.replace(/[^\d]/g, "");
    });
    qtyInput.addEventListener("blur", clampQty);
}
if (qtyMinus) qtyMinus.addEventListener("click", () => {
    qtyInput.value = String(Math.max(1, (parseInt(qtyInput.value, 10) || 1) - 1));
    clampQty();
});
if (qtyPlus) qtyPlus.addEventListener("click", () => {
    qtyInput.value = String((parseInt(qtyInput.value, 10) || 1) + 1);
    clampQty();
});

clampQty();



