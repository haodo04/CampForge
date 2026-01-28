$(document).ready(function () {
  $("#orders").DataTable();
});

document.addEventListener("click", function (e) {
  const btnEdit = e.target.closest(".btn-open-edit");
  if (btnEdit) {
    const id = btnEdit.dataset.id;
    const paymentStatus = btnEdit.dataset.paymentstatus || "UNPAID";
    const deliveryStatus = btnEdit.dataset.deliverystatus || "PENDING";

    document.getElementById("edit_order_id").value = id;
    document.getElementById("edit_order_id_text").textContent = id;

    const ps = document.getElementById("edit_payment_status");
    const ds = document.getElementById("edit_delivery_status");
    if (ps) ps.value = paymentStatus;
    if (ds) ds.value = deliveryStatus;

    return;
  }

  const btnDel = e.target.closest(".btn-open-delete");
  if (btnDel) {
    const id = btnDel.dataset.id;

    document.getElementById("delete_order_id").value = id;
    document.getElementById("delete_order_id_text").textContent = id;
  }
});
