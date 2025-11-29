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
    el.classList.remove("show");
    el.setAttribute("aria-hidden", "true");
    el.style.display = "none";
    document.body.classList.remove("modal-open");
    document.querySelectorAll(".modal-backdrop").forEach((b) => b.remove());
  }
}

(function ensureViewDeleteModals() {
  // View modal
  if (!document.getElementById("viewCampingModal")) {
    const wrap = document.createElement("div");
    wrap.innerHTML = `
      <div class="modal fade" id="viewCampingModal" tabindex="-1" aria-labelledby="viewCampingModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-md">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="viewCampingModalLabel">Chi tiết sản phẩm</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
              <div class="d-flex gap-3">
                <img id="viewImg" src="" alt="Ảnh sản phẩm" style="width:120px;height:120px;object-fit:cover;border:1px solid #eee;border-radius:6px;">
                <div class="flex-grow-1">
                  <p class="mb-1"><strong>Mã SP:</strong> <span id="viewId">--</span></p>
                  <p class="mb-1"><strong>Tên:</strong> <span id="viewName">--</span></p>
                  <p class="mb-1"><strong>Trạng thái:</strong> <span id="viewStatus">--</span></p>
                  <p class="mb-1"><strong>Giá:</strong> <span id="viewPrice">--</span></p>
                  <p class="mb-1"><strong>Ngày tạo:</strong> <span id="viewDate">--</span></p>
                </div>
              </div>
              <hr class="my-3">
              <p class="mb-0 text-muted" style="font-size:0.9rem">(* Demo tĩnh: có thể mở rộng thêm brand, SKU, màu, kích thước…)</p>
            </div>
            <div class="modal-footer">
              <button class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
            </div>
          </div>
        </div>
      </div>`;
    document.body.appendChild(wrap.firstElementChild);
  }

  // Delete modal
  if (!document.getElementById("deleteCampingModal")) {
    const wrap = document.createElement("div");
    wrap.innerHTML = `
      <div class="modal fade" id="deleteCampingModal" tabindex="-1" aria-labelledby="deleteCampingModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 id="deleteCampingModalLabel" class="modal-title">Xác nhận xóa</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
              Bạn chắc chắn muốn xóa sản phẩm <strong id="deleteName">--</strong> (Mã: <strong id="deleteId">--</strong>)?
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Hủy</button>
              <button type="button" class="btn btn-danger btn-sm" id="confirmDeleteCampingBtn">Xóa</button>
            </div>
          </div>
        </div>
      </div>`;
    document.body.appendChild(wrap.firstElementChild);
  }
})();

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

(function () {
  const form = document.getElementById("addCampingProductForm");
  if (!form) return;

  form.addEventListener("submit", function (e) {
    e.preventDefault();
    const fd = new FormData(form);

    const title = (fd.get("title") || "").toString().trim();
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
        <button class="btn btn-info btn-sm view-camping" title="Chi tiết (demo tĩnh)">Xem Chi Tiết</button>
        <button class="btn btn-danger btn-sm delete-camping" title="Xoá (demo tĩnh)">Xóa</button>
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

(function () {
  const tableEl = $("#products");
  const dt = $.fn.dataTable.isDataTable(tableEl) ? tableEl.DataTable() : null;

  document.addEventListener("click", function (e) {
    const btn = e.target.closest(".view-camping");
    if (!btn) return;

    const tr = btn.closest("tr");
    const row = dt ? dt.row(tr) : null;
    const cells = row ? row.data() : null;

    let id, imgHTML, name, status, price, date;
    if (cells) {
      id = cells[0];
      imgHTML = cells[1];
      name = cells[2];
      status = cells[3];
      price = cells[4];
      date = cells[5];
    } else {
      const tds = tr.querySelectorAll("td");
      id = tds[0]?.textContent.trim();
      imgHTML = tds[1]?.innerHTML || "";
      name = tds[2]?.textContent.trim();
      status = tds[3]?.textContent.trim();
      price = tds[4]?.textContent.trim();
      date = tds[5]?.textContent.trim();
    }

    const srcMatch = (imgHTML || "").match(/src="([^"]+)"/i);
    const src = srcMatch ? srcMatch[1] : "";

    document.getElementById("viewId").textContent = id || "--";
    document.getElementById("viewName").textContent = name || "--";
    document.getElementById("viewStatus").textContent = status || "--";
    document.getElementById("viewPrice").textContent = price || "--";
    document.getElementById("viewDate").textContent = date || "--";
    document.getElementById("viewImg").src = src || "";

    const el = document.getElementById("viewCampingModal");
    if (window.bootstrap?.Modal) {
      window.bootstrap.Modal.getOrCreateInstance(el).show();
    } else {
      el.style.display = "block";
      el.classList.add("show");
      document.body.classList.add("modal-open");
      const backdrop = document.createElement("div");
      backdrop.className = "modal-backdrop fade show";
      document.body.appendChild(backdrop);
    }
  });

  let rowNodePendingDelete = null;

  document.addEventListener("click", function (e) {
    const btn = e.target.closest(".delete-camping");
    if (!btn) return;

    const tr = btn.closest("tr");
    rowNodePendingDelete = tr;

    let id, name;
    if (dt) {
      const row = dt.row(tr);
      const data = row.data();
      id = data?.[0] || "--";
      name = data?.[2] || "--";
    } else {
      const tds = tr.querySelectorAll("td");
      id = tds[0]?.textContent.trim() || "--";
      name = tds[2]?.textContent.trim() || "--";
    }

    document.getElementById("deleteId").textContent = id;
    document.getElementById("deleteName").textContent = name;

    const el = document.getElementById("deleteCampingModal");
    if (window.bootstrap?.Modal) {
      window.bootstrap.Modal.getOrCreateInstance(el).show();
    } else {
      el.style.display = "block";
      el.classList.add("show");
      document.body.classList.add("modal-open");
      const backdrop = document.createElement("div");
      backdrop.className = "modal-backdrop fade show";
      document.body.appendChild(backdrop);
    }
  });

  document
    .getElementById("confirmDeleteCampingBtn")
    .addEventListener("click", function () {
      if (!rowNodePendingDelete) return;

      if (dt) {
        dt.row(rowNodePendingDelete).remove().draw(false);
      } else {
        rowNodePendingDelete.remove();
      }

      closeModalById("deleteCampingModal");
      rowNodePendingDelete = null;

      if (window.Swal) {
        Swal.fire({
          icon: "success",
          title: "Đã xóa sản phẩm",
          timer: 1400,
          showConfirmButton: false,
        });
      }
    });
})();
