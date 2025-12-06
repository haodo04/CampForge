$(document).ready(function () {
  $("#currentOrders").DataTable();
  $("#orderHistory").DataTable();
  $("#orderD").DataTable();
});

function closeModalById(id) {
  const el = document.getElementById(id);
  if (!el) return;
  const BS = window.bootstrap?.Modal || null;
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
  } catch {
    el.classList.remove("show");
    el.setAttribute("aria-hidden", "true");
    el.style.display = "none";
    document.body.classList.remove("modal-open");
    document.querySelectorAll(".modal-backdrop").forEach((b) => b.remove());
  }
}
function showModalById(id) {
  const el = document.getElementById(id);
  if (!el) return;
  if (window.bootstrap?.Modal) {
    window.bootstrap.Modal.getOrCreateInstance(el).show();
  } else {
    el.style.display = "block";
    el.classList.add("show");
    document.body.classList.add("modal-open");
    const back = document.createElement("div");
    back.className = "modal-backdrop fade show";
    document.body.appendChild(back);
  }
}

function getRowDataGeneric(tableId, tr) {
  const $table = $(`#${tableId}`);
  const dt = $.fn.dataTable.isDataTable($table) ? $table.DataTable() : null;
  return dt
    ? dt.row(tr).data()
    : Array.from(tr.querySelectorAll("td")).map((td) => td.innerHTML.trim());
}

document.addEventListener("click", function (e) {
  const btn = e.target.closest(".view-order");
  if (!btn) return;

  const tr = btn.closest("tr");
  const tableEl = tr.closest("table");
  const tableId = tableEl?.id || "";
  const data = getRowDataGeneric(tableId, tr);
  if (!data) return;

  let id,
    total,
    orderDate,
    shipDate = "--",
    payStatus,
    payMethod,
    shipStatus = "--";

  if (tableId === "currentOrders") {
    id = data[0];
    total = data[1];
    orderDate = data[2];
    payStatus = data[3];
    payMethod = data[4];
    shipStatus = data[5];
  } else if (tableId === "orderHistory") {
    id = data[0];
    total = data[1];
    orderDate = data[2];
    shipDate = data[3];
    payStatus = data[4];
    payMethod = data[5];
    shipStatus = data[6];
  } else if (tableId === "orderD") {
    id = data[0];
    total = data[1];
    orderDate = data[2];
    payStatus = data[3];
    payMethod = data[4];
  }

  document.getElementById("v_id").textContent = id || "--";
  document.getElementById("v_total").textContent = total || "--";
  document.getElementById("v_orderDate").textContent = orderDate || "--";
  document.getElementById("v_shipDate").textContent = shipDate || "--";
  document.getElementById("v_payStatus").textContent = payStatus || "--";
  document.getElementById("v_payMethod").textContent = payMethod || "--";
  document.getElementById("v_shipStatus").textContent = shipStatus || "--";

  showModalById("viewOrderModal");
});

(function () {
  const dtCurrent = $("#currentOrders").DataTable();
  const dtHistory = $("#orderHistory").DataTable();
  const dtDeleted = $("#orderD").DataTable();

  let pending = { tableId: null, rowNode: null, id: "", total: "" };

  document.addEventListener("click", function (e) {
    const btn = e.target.closest(".delete-order");
    if (!btn) return;

    const tr = btn.closest("tr");
    const tableId = tr.closest("table")?.id || "";
    const data = getRowDataGeneric(tableId, tr);
    if (!data) return;

    const id = data[0];
    const total = data[1];

    pending = { tableId, rowNode: tr, id, total };
    document.getElementById("d_id").textContent = id;
    document.getElementById("d_total").textContent = total;
    showModalById("deleteOrderModal");
  });

  document
    .getElementById("confirmDeleteOrderBtn")
    .addEventListener("click", function () {
      const { tableId, rowNode, id } = pending;
      if (!rowNode || !tableId) return;

      const data = getRowDataGeneric(tableId, rowNode);
      let newRow;

      if (tableId === "currentOrders") {
        newRow = [
          data[0],
          data[1],
          data[2],
          data[3],
          data[4],
          `
          <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
          <button class="btn btn-primary btn-sm restore-order">Khôi phục</button>
        `,
        ];
        dtCurrent.row(rowNode).remove().draw(false);
      } else if (tableId === "orderHistory") {
        newRow = [
          data[0],
          data[1],
          data[2],
          data[4],
          data[5],
          `
          <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
          <button class="btn btn-primary btn-sm restore-order">Khôi phục</button>
        `,
        ];
        dtHistory.row(rowNode).remove().draw(false);
      } else {
        return;
      }

      dtDeleted.row.add(newRow).draw(false);
      closeModalById("deleteOrderModal");

      if (window.Swal) {
        Swal.fire({
          icon: "success",
          title: `Đã xóa đơn #${id}`,
          timer: 1400,
          showConfirmButton: false,
        });
      }
      pending = { tableId: null, rowNode: null, id: "", total: "" };
    });
})();

(function () {
  const dtCurrent = $("#currentOrders").DataTable();
  const dtDeleted = $("#orderD").DataTable();
  let pending = { rowNode: null, id: "" };

  document.addEventListener("click", function (e) {
    const btn = e.target.closest(".restore-order");
    if (!btn) return;

    const tr = btn.closest("tr");
    const data = getRowDataGeneric("orderD", tr);
    if (!data) return;

    const id = data[0];
    pending = { rowNode: tr, id };
    document.getElementById("r_id").textContent = id;
    showModalById("restoreOrderModal");
  });

  document
    .getElementById("confirmRestoreOrderBtn")
    .addEventListener("click", function () {
      const { rowNode, id } = pending;
      if (!rowNode) return;

      const data = getRowDataGeneric("orderD", rowNode);
      const restoredRow = [
        data[0],
        data[1],
        data[2],
        data[3],
        data[4],
        "Chờ giao",
        `
        <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
        <button class="btn btn-danger btn-sm delete-order">Xóa</button>
      `,
      ];

      dtDeleted.row(rowNode).remove().draw(false);
      dtCurrent.row.add(restoredRow).draw(false);

      closeModalById("restoreOrderModal");
      if (window.Swal) {
        Swal.fire({
          icon: "success",
          title: `Đã khôi phục đơn #${id}`,
          timer: 1400,
          showConfirmButton: false,
        });
      }
      pending = { rowNode: null, id: "" };
    });
})();
