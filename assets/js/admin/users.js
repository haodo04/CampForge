$(document).ready(function () {
  $("#users").DataTable({
    dom: '<"d-flex justify-content-between align-items-center"lfB>rtip',
    buttons: [
      { extend: "copy", title: "Danh sách người dùng" },
      { extend: "csv", title: "Danh sách người dùng" },
      { extend: "excel", title: "Danh sách người dùng" },
      { extend: "pdf", title: "Danh sách người dùng" },
      { extend: "print", title: "Danh sách người dùng" },
    ],
  });
});
