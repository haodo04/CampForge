document.addEventListener("DOMContentLoaded", function () {

    const searchBtn = document.getElementById("searchBtn");
    const searchInput = document.getElementById("searchInput");

    function doSearch() {
        const keyword = searchInput.value.trim();
        if (!keyword) return;
        window.location.href = "category.html?search=" + encodeURIComponent(keyword);
    }

    if (searchBtn) searchBtn.addEventListener("click", doSearch);

    if (searchInput) {
        searchInput.addEventListener("keydown", function (e) {
            if (e.key === "Enter") doSearch();
        });
    }

    // Filter sản phẩm chỉ trong category.html
    if (window.location.pathname.includes("category.html")) {

        const keywordUrl = new URLSearchParams(window.location.search).get("search")?.toLowerCase() || "";
        const productCols = document.querySelectorAll("#product-grid > .col-12"); // Lấy trực tiếp các col

        if (keywordUrl && productCols.length > 0) {
            productCols.forEach(col => {
                const p = col.querySelector(".pro");
                const name = p.querySelector("h5")?.textContent.toLowerCase() || "";
                const brand = p.querySelector("span")?.textContent.toLowerCase() || "";

                if (name.includes(keywordUrl) || brand.includes(keywordUrl)) {
                    col.style.display = "block";  // hiện cả cột
                } else {
                    col.style.display = "none";   // ẩn cả cột
                }
            });
        }
    }
});
