package model;

import java.io.Serializable;
import java.math.BigDecimal;

public class OrderItemBean implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idDettaglio;
    private int idOrdine;
    private Integer idProdotto;
    private Integer idConcerto;
    private Integer quantitaProdotto;
    private Integer quantitaBiglietti;
    private BigDecimal prezzoTotale;
    private String itemType;
    private String itemName;
    private BigDecimal unitPrice;
    private BigDecimal iva;

    public int getIdDettaglio() { return idDettaglio; }
    public void setIdDettaglio(int idDettaglio) { this.idDettaglio = idDettaglio; }

    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }

    public Integer getIdProdotto() { return idProdotto; }
    public void setIdProdotto(Integer idProdotto) { this.idProdotto = idProdotto; }

    public Integer getIdConcerto() { return idConcerto; }
    public void setIdConcerto(Integer idConcerto) { this.idConcerto = idConcerto; }

    public Integer getQuantitaProdotto() { return quantitaProdotto; }
    public void setQuantitaProdotto(Integer quantitaProdotto) { this.quantitaProdotto = quantitaProdotto; }

    public Integer getQuantitaBiglietti() { return quantitaBiglietti; }
    public void setQuantitaBiglietti(Integer quantitaBiglietti) { this.quantitaBiglietti = quantitaBiglietti; }

    public BigDecimal getPrezzoTotale() { return prezzoTotale; }
    public void setPrezzoTotale(BigDecimal prezzoTotale) { this.prezzoTotale = prezzoTotale; }

    public String getItemType() { return itemType; }
    public void setItemType(String itemType) { this.itemType = itemType; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }

    public BigDecimal getIva() { return iva; }
    public void setIva(BigDecimal iva) { this.iva = iva; }
}
