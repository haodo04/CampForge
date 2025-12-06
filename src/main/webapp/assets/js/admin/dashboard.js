$(document).ready(function () {
  // Khởi tạo DataTables
  $("#reorderTable").DataTable();
  $("#slowSellingTable").DataTable();

  const revenueByArtistData = {
    labels: ["Lều cắm trại", "Túi ngủ mùa đông", "Đèn pin dã ngoại"],
    datasets: [
      {
        label: "Doanh thu (triệu VNĐ)",
        data: [200, 320, 180],
        backgroundColor: "#007bff",
        borderColor: "#0056b3",
        borderWidth: 1,
      },
    ],
  };

  const orderStatusData = {
    labels: ["Chờ xử lý", "Đang giao", "Hoàn thành"],
    datasets: [
      {
        data: [40, 25, 85],
        backgroundColor: ["#ffc107", "#17a2b8", "#28a745"],
      },
    ],
  };

  const ratingData = {
    labels: ["5 sao", "4 sao", "3 sao"],
    datasets: [
      {
        label: "Số lượt đánh giá",
        data: [120, 70, 20],
        backgroundColor: ["#007bff", "#28a745", "#ffc107"],
        borderColor: "#0056b3",
        borderWidth: 1,
      },
    ],
  };

  const bestSaleData = {
    labels: ["Lều 2 người", "Túi ngủ mùa đông", "Bộ nồi cắm trại"],
    datasets: [
      {
        label: "Số lượng bán ra",
        data: [150, 110, 95],
        backgroundColor: ["#007bff", "#28a745", "#ffc107"],
        borderColor: "#0056b3",
        borderWidth: 1,
      },
    ],
  };

  function initCharts() {
    // Doanh thu theo sản phẩm cắm trại
    new Chart(
      document.getElementById("revenueByArtistChart").getContext("2d"),
      {
        type: "bar",
        data: revenueByArtistData,
        options: {
          responsive: true,
          plugins: {
            legend: { display: true },
          },
          scales: {
            x: {
              title: { display: true, text: "Sản phẩm cắm trại" },
            },
            y: {
              title: { display: true, text: "Doanh thu (triệu VNĐ)" },
            },
          },
        },
      }
    );

    // Trạng thái đơn hàng
    new Chart(document.getElementById("orderStatusChart").getContext("2d"), {
      type: "doughnut",
      data: orderStatusData,
      options: {
        responsive: true,
        plugins: {
          legend: { position: "bottom" },
        },
      },
    });

    // Thống kê đánh giá
    new Chart(document.getElementById("ratingChart").getContext("2d"), {
      type: "line",
      data: ratingData,
      options: {
        responsive: true,
        plugins: {
          legend: { display: true },
        },
        scales: {
          x: {
            title: { display: true, text: "Mức đánh giá (sao)" },
          },
          y: {
            title: { display: true, text: "Số lượt đánh giá" },
          },
        },
      },
    });

    // Sản phẩm cắm trại bán chạy
    new Chart(document.getElementById("bestSaleChart").getContext("2d"), {
      type: "bar",
      data: bestSaleData,
      options: {
        responsive: true,
        plugins: {
          legend: { display: true },
        },
        scales: {
          x: {
            title: { display: true, text: "Sản phẩm cắm trại" },
          },
          y: {
            title: { display: true, text: "Số lượng bán ra" },
          },
        },
      },
    });
  }

  initCharts();
});
