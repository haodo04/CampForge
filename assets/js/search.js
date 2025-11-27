document.addEventListener("DOMContentLoaded", function () {

    // =======================
    // 1. LẤY PHẦN TÌM KIẾM TRONG HEADER
    // =======================
    const searchBtn = document.getElementById("searchBtn");
    const searchInput = document.getElementById("searchInput");

    function doSearch() {
        let keyword = searchInput.value.trim();
        if (keyword.length === 0) return;

        // Chuyển sang trang category với query param
        window.location.href = "category.html?search=" + encodeURIComponent(keyword);
    }

    if (searchBtn) searchBtn.addEventListener("click", doSearch);
    if (searchInput) {
        searchInput.addEventListener("keydown", function (e) {
            if (e.key === "Enter") {
                e.preventDefault();
                doSearch();
            }
        });
    }

    // =======================
    // 2. LẤY TỪ KHÓA TỪ URL
    // =======================
    const params = new URLSearchParams(window.location.search);
    const keyword = params.get("search")?.trim().toLowerCase() || "";

    // =======================
    // 3. LẤY TẤT CẢ SẢN PHẨM
    // =======================
    const products = document.querySelectorAll(".pro");

    function filterProducts() {
        if (!keyword || products.length === 0) return;

        let anyMatch = false;

        products.forEach(product => {
            const nameEl = product.querySelector("h5");
            const brandEl = product.querySelector("span");

            const name = nameEl ? nameEl.textContent.toLowerCase() : "";
            const brand = brandEl ? brandEl.textContent.toLowerCase() : "";

            const isMatch = name.includes(keyword) || brand.includes(keyword);

            product.style.display = isMatch ? "block" : "none";

            if (isMatch) anyMatch = true;
        });

        // Hiển thị thông báo nếu không có sản phẩm nào khớp
        const noResultEl = document.getElementById("noResult");
        if (noResultEl) {
            noResultEl.style.display = anyMatch ? "none" : "block";
        }
    }

    // =======================
    // 4. CHẠY LỌC SẢN PHẨM
    // =======================
    if (products.length > 0) filterProducts();

    // Prefill ô search input nếu đang có keyword
    if (keyword && searchInput) searchInput.value = keyword;

});
