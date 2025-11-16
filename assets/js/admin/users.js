$(document).ready(function () {
  $("#users").DataTable();
  $("#roles").DataTable();
  $("#deletedUsers").DataTable();
});

function showModalById(id) {
  const el = document.getElementById(id);
  if (!el) return;
  window.bootstrap?.Modal.getOrCreateInstance(el).show();
}
function closeModalById(id) {
  const el = document.getElementById(id);
  if (!el) return;
  const BS = window.bootstrap?.Modal;
  if (BS) (BS.getInstance(el) || new BS(el)).hide();
}
function getRowTds(tr) {
  return Array.from(tr.querySelectorAll("td")).map((td) => td.innerText.trim());
}

document.addEventListener("click", function (e) {
  const btn = e.target.closest(".view-user");
  if (!btn) return;

  const tr = btn.closest("tr");
  const tds = getRowTds(tr);
  document.getElementById("editUserId").value = tds[0] || "";
  document.getElementById("changUsername").value = tds[1] || "";
  document.getElementById("changeName").value = tds[2] || "";
  document.getElementById("changeEmail").value = tds[3] || "";
  document.getElementById("changePhone").value = tds[4] || "";
  document.getElementById("status").value = tds[5] || "Hoạt động";
  showModalById("viewEditUserModal");
});

document
  .getElementById("userDetailForm")
  .addEventListener("submit", function (e) {
    e.preventDefault();
    closeModalById("viewEditUserModal");
  });

(function () {
  const dtUsers = $("#users").DataTable();
  const dtDeleted = $("#deletedUsers").DataTable();

  let pendingId = null;
  let pendingRow = null;

  document.addEventListener("click", function (e) {
    const btn = e.target.closest(".delete-user");
    if (!btn) return;

    pendingRow = btn.closest("tr");
    const tds = getRowTds(pendingRow);
    pendingId = tds[0];

    document.getElementById("userIdToDelete").value = pendingId;
    showModalById("deleteUsersModal");
  });

  document
    .querySelector("#deleteUsersModal form")
    .addEventListener("submit", function (e) {
      e.preventDefault();
      if (!pendingRow) return;

      const tds = getRowTds(pendingRow);
      const newRow = [
        tds[0],
        tds[1],
        tds[2],
        tds[3],
        tds[4],
        "Đã xóa",
        tds[6], // role
        `<button class="btn btn-success btn-sm restore-user-btn" data-user-id="${tds[0]}">
         <i class="fas fa-undo"></i> Khôi phục
       </button>`,
      ];

      dtUsers.row(pendingRow).remove().draw(false);
      dtDeleted.row.add(newRow).draw(false);

      closeModalById("deleteUsersModal");
      pendingId = null;
      pendingRow = null;
    });
})();

(function () {
  const dtUsers = $("#users").DataTable();
  const dtDeleted = $("#deletedUsers").DataTable();

  document.addEventListener("click", function (e) {
    const btn = e.target.closest(".restore-user-btn");
    if (!btn) return;

    const tr = btn.closest("tr");
    const tds = getRowTds(tr);

    const newRow = [
      tds[0],
      tds[1],
      tds[2],
      tds[3],
      tds[4],
      "Hoạt động",
      tds[6],
      `
      <button class="btn btn-info btn-sm view-user" data-user-id="${tds[0]}" data-bs-toggle="modal" data-bs-target="#viewEditUserModal">
        <i class="fas fa-eye"></i>
      </button>
      <button class="btn btn-danger btn-sm delete-user" data-user-id="${tds[0]}" data-bs-toggle="modal" data-bs-target="#deleteUsersModal">
        <i class="fas fa-trash-alt"></i>
      </button>
      <button class="btn btn-warning btn-sm change-password-btn" data-user-id="${tds[0]}" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
        <i class="fas fa-key"></i>
      </button>
      `,
    ];

    dtDeleted.row(tr).remove().draw(false);
    dtUsers.row.add(newRow).draw(false);
  });
})();

document.addEventListener("click", function (e) {
  const btn = e.target.closest(".change-password-btn");
  if (!btn) return;
  const userId = btn.getAttribute("data-user-id");
  document.getElementById("changePwUserId").value = userId || "";
  showModalById("changePasswordModal");
});

document
  .getElementById("changePasswordForm")
  .addEventListener("submit", function (e) {
    e.preventDefault();
    const pw = document.getElementById("newPassword").value.trim();
    const repw = document.getElementById("rePassword").value.trim();
    if (pw.length < 6) {
      alert("Mật khẩu tối thiểu 6 ký tự.");
      return;
    }
    if (pw !== repw) {
      alert("Mật khẩu nhập lại không khớp.");
      return;
    }
    closeModalById("changePasswordModal");
  });

(function () {
  const dtUsers = $("#users").DataTable();

  document
    .getElementById("addUserForm")
    .addEventListener("submit", function (e) {
      e.preventDefault();
      const fd = new FormData(this);
      const username = fd.get("username");
      const fullName = fd.get("fullName");
      const email = fd.get("email");
      const phone = fd.get("phone") || "";
      const role = fd.get("role") || "User";
      const isActive = fd.get("isActive") !== null;

      const ids = $("#users tbody tr td:first-child")
        .toArray()
        .map((td) => parseInt(td.innerText, 10))
        .filter((n) => !isNaN(n));
      const nextId = String(Math.max(0, ...ids) + 1).padStart(3, "0");

      const newRow = [
        nextId,
        username,
        fullName,
        email,
        phone,
        isActive ? "Hoạt động" : "Chưa kích hoạt",
        role,
        `
      <button class="btn btn-info btn-sm view-user" data-user-id="${nextId}" data-bs-toggle="modal" data-bs-target="#viewEditUserModal">
        <i class="fas fa-eye"></i>
      </button>
      <button class="btn btn-danger btn-sm delete-user" data-user-id="${nextId}" data-bs-toggle="modal" data-bs-target="#deleteUsersModal">
        <i class="fas fa-trash-alt"></i>
      </button>
      <button class="btn btn-warning btn-sm change-password-btn" data-user-id="${nextId}" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
        <i class="fas fa-key"></i>
      </button>
      `,
      ];
      dtUsers.row.add(newRow).draw(false);

      this.reset();
      closeModalById("addUserModal");
    });
})();
