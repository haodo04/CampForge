package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.model.Cart;

import jakarta.servlet.http.HttpSession;

public class CartService {

    public static final String SESSION_CART_KEY = "CART";

    public Cart getOrCreate(HttpSession session) {
        Object obj = session.getAttribute(SESSION_CART_KEY);
        if (obj instanceof Cart) {
            return (Cart) obj;
        }

        Cart cart = new Cart();
        session.setAttribute(SESSION_CART_KEY, cart);
        return cart;
    }
}
