document.addEventListener("DOMContentLoaded", () => {
    const cartBody = document.getElementById("cart-body");
    const emptyCart = document.getElementById("empty-cart");
    const subtotalValue = document.getElementById("subtotal-value");
    const totalValue = document.getElementById("total-value");

    let cart = JSON.parse(localStorage.getItem("cart")) || [];

    // Hàm hiển thị giỏ hàng
    function renderCart() {
        if (cart.length === 0) {
            cartBody.innerHTML = "";
            emptyCart.style.display = "block";
            subtotalValue.textContent = "$0";
            totalValue.textContent = "$0";
            return;
        }

        emptyCart.style.display = "none";
        let html = "";
        let subtotal = 0;

        cart.forEach((product, index) => {
            const itemTotal = product.price * product.quantity;
            subtotal += itemTotal;

            html += `
                <tr>
                    <td><a href="#" class="remove-item" data-index="${index}">
                        <i class="fa-solid fa-xmark"></i></a></td>
                    <td><img src="${product.image}" alt="${product.name}" width="60"></td>
                    <td>${product.name}</td>
                    <td>$${product.price.toFixed(2)}</td>
                    <td><input type="number" class="qty" data-index="${index}" min="1" value="${product.quantity}"></td>
                    <td>$${itemTotal.toFixed(2)}</td>
                </tr>
            `;
        });

        cartBody.innerHTML = html;
        subtotalValue.textContent = `$${subtotal.toFixed(2)}`;
        totalValue.textContent = `$${subtotal.toFixed(2)}`;
    }

    // Xóa sản phẩm
    cartBody.addEventListener("click", (e) => {
        if (e.target.closest(".remove-item")) {
            e.preventDefault();
            const index = e.target.closest(".remove-item").dataset.index;
            cart.splice(index, 1);
            localStorage.setItem("cart", JSON.stringify(cart));
            renderCart();
        }
    });

    // Cập nhật số lượng
    cartBody.addEventListener("change", (e) => {
        if (e.target.classList.contains("qty")) {
            const index = e.target.dataset.index;
            const newQty = parseInt(e.target.value);
            if (newQty > 0) {
                cart[index].quantity = newQty;
                localStorage.setItem("cart", JSON.stringify(cart));
                renderCart();
            }
        }
    });

    // Nút checkout
    document.getElementById("checkoutBtn").addEventListener("click", () => {
        if (cart.length === 0) {
            alert("Giỏ hàng của bạn đang trống!");
            return;
        }
        alert("Chuyển sang trang checkout...");
        window.location.href = "checkout.html";
    });

    // Gọi hiển thị
    renderCart();
});
