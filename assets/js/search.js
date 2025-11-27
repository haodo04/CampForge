document.addEventListener("DOMContentLoaded", function() {
    const searchBtn = document.getElementById("searchBtn");
    const searchInput = document.getElementById("searchInput");

    function doSearch() {
        const keyword = searchInput.value.trim();
        if (!keyword) return;
        window.location.href = "category.html?search=" + encodeURIComponent(keyword);
    }

    if (searchBtn) searchBtn.addEventListener("click", doSearch);
    if (searchInput) {
        searchInput.addEventListener("keydown", function(e) {
            if (e.key === "Enter") doSearch();
        });
    }

    // Filter sản phẩm trên category.html
    const keywordUrl = new URLSearchParams(window.location.search).get("search")?.toLowerCase() || "";
    const products = document.querySelectorAll(".pro");
    if (keywordUrl && products.length > 0) {
        products.forEach(p => {
            const name = p.querySelector("h5")?.textContent.toLowerCase() || "";
            const brand = p.querySelector("span")?.textContent.toLowerCase() || "";
            p.style.display = (name.includes(keywordUrl) || brand.includes(keywordUrl)) ? "block" : "none";
        });
    }

    // Prefill ô search input
    if (searchInput && keywordUrl) searchInput.value = keywordUrl;
});
