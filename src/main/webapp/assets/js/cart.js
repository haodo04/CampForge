document.addEventListener("DOMContentLoaded", () => {
    const cartBody = document.getElementById("cart-body");
    const emptyCart = document.getElementById("empty-cart");
    const subtotalValue = document.getElementById("subtotal-value");
    const totalValue = document.getElementById("total-value");

    const miniCart = document.getElementById("mini-cart-items");
    const miniCartTotal = document.getElementById("mini-cart-total");
    const cartCount = document.getElementById("cart-count");

    let cart = JSON.parse(localStorage.getItem("cart")) || [];

    // Hàm format tiền VNĐ
    function formatVND(value) {
        return value.toLocaleString("vi-VN") + "đ";
    }

    // Hàm hiển thị giỏ hàng
    function renderCart() {
        if (cart.length === 0) {
            cartBody.innerHTML = "";
            emptyCart.style.display = "block";
            subtotalValue.textContent = "0đ";
            totalValue.textContent = "0đ";
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
                    <td>${formatVND(product.price)}</td>
                    <td><input type="number" class="qty" data-index="${index}" min="1" value="${product.quantity}"></td>
                    <td>${formatVND(itemTotal)}</td>
                </tr>
            `;
        });

        cartBody.innerHTML = html;
        subtotalValue.textContent = formatVND(subtotal);
        totalValue.textContent = formatVND(subtotal);
    }

    // Mini cart (trong header)
    function renderMiniCart() {
        if (!miniCart || !miniCartTotal) return;

        miniCart.innerHTML = "";
        let total = 0;
        let count = 0;

        cart.forEach((product, index) => {
            const itemTotal = product.price * product.quantity;
            total += itemTotal;
            count += product.quantity;

            miniCart.innerHTML += `
                <div class="mini-cart-item">
                    <img src="${product.image}" alt="${product.name}">
                    <div class="info">
                        <p class="name">${product.name}</p>
                        <p class="color">Color: ${product.color || "Không có"}</p>
                        <p class="price">${formatVND(product.price)} x ${product.quantity}</p>
                    </div>
                    <button class="remove-mini" data-index="${index}">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
            `;
        });

        miniCartTotal.textContent = formatVND(total);
        cartCount.textContent = count;
    }

    // Xóa sản phẩm
    cartBody.addEventListener("click", (e) => {
        if (e.target.closest(".remove-item")) {
            e.preventDefault();
            const index = e.target.closest(".remove-item").dataset.index;
            cart.splice(index, 1);
            localStorage.setItem("cart", JSON.stringify(cart));
            renderCart();
            renderMiniCart();
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
                renderMiniCart();
            }
        }
    });

    // Checkout
    document.getElementById("checkoutBtn").addEventListener("click", () => {
        if (cart.length === 0) {
            alert("Giỏ hàng của bạn đang trống!");
            return;
        }
        window.location.href = "checkout.html";
    });

    // Gọi
    renderCart();
    renderMiniCart();
});
