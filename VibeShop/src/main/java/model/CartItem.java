package model;

import java.io.Serializable;
import java.math.BigDecimal;

public class CartItem implements Serializable {
    private static final long serialVersionUID = 1L;

    public static final String TYPE_PRODUCT = "PRODOTTO";
    public static final String TYPE_CONCERT = "CONCERTO";

    private String itemType;
    private Integer idProdotto;
    private Integer idConcerto;
    private String itemName;
    private String description;
    private BigDecimal unitPrice;
    private BigDecimal iva;
    private int quantity;

    public CartItem() {
    }

    public CartItem(String itemType, Integer idProdotto, Integer idConcerto,
                    String itemName, String description,
                    BigDecimal unitPrice, BigDecimal iva, int quantity) {
        this.itemType = itemType;
        this.idProdotto = idProdotto;
        this.idConcerto = idConcerto;
        this.itemName = itemName;
        this.description = description;
        this.unitPrice = unitPrice;
        this.iva = iva;
        setQuantity(quantity);
    }

    public String getCartKey() {
        if (TYPE_PRODUCT.equals(itemType) && idProdotto != null) {
            return TYPE_PRODUCT + "-" + idProdotto;
        }

        if (TYPE_CONCERT.equals(itemType) && idConcerto != null) {
            return TYPE_CONCERT + "-" + idConcerto;
        }

        return itemType + "-" + itemName;
    }

    public BigDecimal getSubtotal() {
        if (unitPrice == null) {
            return BigDecimal.ZERO;
        }

        return unitPrice.multiply(BigDecimal.valueOf(quantity));
    }

    public void increaseQuantity(int amount) {
        if (amount > 0) {
            this.quantity += amount;
        }
    }

    public void decreaseQuantity(int amount) {
        if (amount > 0) {
            this.quantity -= amount;
            if (this.quantity < 1) {
                this.quantity = 1;
            }
        }
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public Integer getIdProdotto() {
        return idProdotto;
    }

    public void setIdProdotto(Integer idProdotto) {
        this.idProdotto = idProdotto;
    }

    public Integer getIdConcerto() {
        return idConcerto;
    }

    public void setIdConcerto(Integer idConcerto) {
        this.idConcerto = idConcerto;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getIva() {
        return iva;
    }

    public void setIva(BigDecimal iva) {
        this.iva = iva;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = Math.max(quantity, 1);
    }
}
