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
