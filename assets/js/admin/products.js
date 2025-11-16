$(document).ready(function () {
  $("#products").DataTable();
  $("#themes").DataTable();
  $("#sizes").DataTable();
});

function closeModalById(id) {
  const el = document.getElementById(id);
  if (!el) return;

  const BS =
    window.bootstrap && window.bootstrap.Modal ? window.bootstrap.Modal : null;

  try {
    if (BS) {
      const inst = BS.getInstance(el) || new BS(el);
      inst.hide();
    } else {
      el.classList.remove("show");
      el.setAttribute("aria-hidden", "true");
      el.style.display = "none";
      document.body.classList.remove("modal-open");
      document.querySelectorAll(".modal-backdrop").forEach((b) => b.remove());
    }
  } catch (e) {
    // Fallback cứng nếu Bootstrap bên trong lỗi
    el.classList.remove("show");
    el.setAttribute("aria-hidden", "true");
    el.style.display = "none";
    document.body.classList.remove("modal-open");
    document.querySelectorAll(".modal-backdrop").forEach((b) => b.remove());
  }
}

(function () {
  const input = document.getElementById("campingImageInput");
  const preview = document.getElementById("campingImagePreview");
  const modalEl = document.getElementById("addCampingModal");
  let objectUrl;

  if (!input || !preview || !modalEl) return;

  input.addEventListener("change", () => {
    if (objectUrl) {
      URL.revokeObjectURL(objectUrl);
      objectUrl = undefined;
    }
    const file = input.files && input.files[0];
    if (!file) {
      preview.style.display = "none";
      preview.src = "";
      return;
    }
    objectUrl = URL.createObjectURL(file);
    preview.src = objectUrl;
    preview.style.display = "block";
  });

  modalEl.addEventListener("hidden.bs.modal", () => {
    if (objectUrl) {
      URL.revokeObjectURL(objectUrl);
      objectUrl = undefined;
    }
    preview.src = "";
    preview.style.display = "none";
    const form = document.getElementById("addCampingProductForm");
    if (form) form.reset();
  });
})();

(function () {
  const wrap = document.getElementById("sizeVariantRows");
  const addBn = document.getElementById("addSizeVariantBtn");
  if (!wrap || !addBn) return;

  addBn.addEventListener("click", () => {
    const row = document.createElement("div");
    row.className = "row g-2 align-items-end mb-2 size-variant-row";
    row.innerHTML = `
        <div class="col-md-6">
          <label class="form-label">Kích thước</label>
          <select class="form-select form-select-sm" name="size[]">
            <option value="">-- Chọn --</option>
            <option value="S">S</option><option value="M">M</option>
            <option value="L">L</option><option value="XL">XL</option>
          </select>
        </div>
        <div class="col-md-4">
          <label class="form-label">Số lượng</label>
          <input type="number" class="form-control form-control-sm" name="qty[]" min="0" value="0">
        </div>
        <div class="col-md-2 text-end">
          <button type="button" class="btn btn-sm btn-outline-danger remove-variant-row">Xoá</button>
        </div>`;
    wrap.appendChild(row);
  });

  wrap.addEventListener("click", (e) => {
    if (e.target.closest(".remove-variant-row")) {
      const row = e.target.closest(".size-variant-row");
      if (row && wrap.children.length > 1) row.remove();
    }
  });
})();

/* ===== Utils ===== */
function formatVND(n) {
  try {
    return new Intl.NumberFormat("vi-VN").format(Number(n)) + " ₫";
  } catch {
    return n + " ₫";
  }
}
function getNextId() {
  const ids = [
    ...document.querySelectorAll("#products tbody tr td:first-child"),
  ];
  let max = 0;
  ids.forEach((td) => {
    const v = parseInt(String(td.textContent).replace(/\D/g, ""), 10);
    if (!isNaN(v) && v > max) max = v;
  });
  return String(max + 1).padStart(3, "0");
}

/* ===== Submit form thêm sản phẩm + đóng modal an toàn ===== */
(function () {
  const form = document.getElementById("addCampingProductForm");
  if (!form) return;

  form.addEventListener("submit", function (e) {
    e.preventDefault();
    const fd = new FormData(form);

    const title = (fd.get("title") || "").toString().trim();
    const category = (fd.get("category") || "").toString().trim();
    const brand = (fd.get("brand") || "").toString().trim();
    const price = fd.get("price");
    const isActive = !!fd.get("isActive");
    const file = fd.get("image");

    if (!title || !price || !file) {
      alert("Vui lòng nhập Tên sản phẩm, Giá và chọn Ảnh.");
      return;
    }

    const id = getNextId();
    const dateStr = new Date().toISOString().slice(0, 10);
    const imgURL = URL.createObjectURL(file);
    const display = brand ? `${title} — ${brand}` : title;

    const row = [
      id,
      `<img src="${imgURL}" alt="Ảnh sản phẩm" width="60">`,
      display,
      isActive ? "Hoạt động" : "Không hoạt động",
      formatVND(price),
      dateStr,
      `
        <button class="btn btn-info btn-sm" title="Chi tiết (demo tĩnh)">Xem Chi Tiết</button>
        <button class="btn btn-danger btn-sm" title="Xoá (demo tĩnh)">Xóa</button>
      `,
    ];

    const tableEl = $("#products");
    const dt = $.fn.dataTable.isDataTable(tableEl) ? tableEl.DataTable() : null;

    if (dt) {
      dt.row.add(row).draw(false);
    } else {
      const tbody = document.querySelector("#products tbody");
      const tr = document.createElement("tr");
      tr.innerHTML = `
        <td>${row[0]}</td><td>${row[1]}</td><td>${row[2]}</td>
        <td>${row[3]}</td><td>${row[4]}</td><td>${row[5]}</td><td>${row[6]}</td>
      `;
      tbody.prepend(tr);
    }

    closeModalById("addCampingModal");

    form.reset();
    const preview = document.getElementById("campingImagePreview");
    if (preview) {
      preview.src = "";
      preview.style.display = "none";
    }

    if (window.Swal) {
      Swal.fire({
        icon: "success",
        title: "Đã thêm sản phẩm!",
        timer: 1400,
        showConfirmButton: false,
      });
    }
  });
})();
