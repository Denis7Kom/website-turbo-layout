package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart implements Serializable {
    private static final long serialVersionUID = 1L;

    private final List<CartItem> items = new ArrayList<CartItem>();

    public void addItem(CartItem newItem) {
        if (newItem == null || newItem.getQuantity() <= 0) {
            return;
        }

        for (CartItem item : items) {
            if (item.getCartKey().equals(newItem.getCartKey())) {
                item.increaseQuantity(newItem.getQuantity());
                return;
            }
        }

        items.add(newItem);
    }

    public void addProduct(ProductBean product, int quantity) {
        if (product == null) {
            return;
        }

        CartItem item = new CartItem();
        item.setItemType(CartItem.TYPE_PRODUCT);
        item.setIdProdotto(product.getIdProdotto());
        item.setItemName(product.getNome());
        item.setDescription(product.getDescrizione());
        item.setUnitPrice(product.getPrezzo());
        item.setIva(product.getIva());
        item.setQuantity(quantity);

        addItem(item);
    }

    public int getQuantity(String cartKey) {
        if (cartKey == null) {
            return 0;
        }

        for (CartItem item : items) {
            if (cartKey.equals(item.getCartKey())) {
                return item.getQuantity();
            }
        }

        return 0;
    }

    public void updateQuantity(String cartKey, int quantity) {
        if (cartKey == null) {
            return;
        }

        if (quantity <= 0) {
            removeItem(cartKey);
            return;
        }

        for (CartItem item : items) {
            if (cartKey.equals(item.getCartKey())) {
                item.setQuantity(quantity);
                return;
            }
        }
    }

    public void increaseQuantity(String cartKey) {
        if (cartKey == null) {
            return;
        }

        for (CartItem item : items) {
            if (cartKey.equals(item.getCartKey())) {
                item.increaseQuantity(1);
                return;
            }
        }
    }

    public void decreaseQuantity(String cartKey) {
        if (cartKey == null) {
            return;
        }

        for (CartItem item : items) {
            if (cartKey.equals(item.getCartKey())) {
                item.decreaseQuantity(1);
                return;
            }
        }
    }

    public void removeItem(String cartKey) {
        if (cartKey == null) {
            return;
        }

        Iterator<CartItem> iterator = items.iterator();

        while (iterator.hasNext()) {
            CartItem item = iterator.next();

            if (cartKey.equals(item.getCartKey())) {
                iterator.remove();
                return;
            }
        }
    }

    public void clear() {
        items.clear();
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public int getTotalQuantity() {
        int total = 0;

        for (CartItem item : items) {
            total += item.getQuantity();
        }

        return total;
    }

    public BigDecimal getTotalPrice() {
        BigDecimal total = BigDecimal.ZERO;

        for (CartItem item : items) {
            total = total.add(item.getSubtotal());
        }

        return total;
    }

    public List<CartItem> getItems() {
        return items;
    }
}
