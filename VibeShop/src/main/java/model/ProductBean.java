package model;

import java.io.Serializable;
import java.math.BigDecimal;

public class ProductBean implements Serializable {
    private static final long serialVersionUID = 1L;

    private int idProdotto;
    private boolean active;
    private String nome;
    private Integer idArtista;
    private BigDecimal prezzo;
    private BigDecimal iva;
    private String descrizione;
    private String immagine;

    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public Integer getIdArtista() { return idArtista; }
    public void setIdArtista(Integer idArtista) { this.idArtista = idArtista; }

    public BigDecimal getPrezzo() { return prezzo; }
    public void setPrezzo(BigDecimal prezzo) { this.prezzo = prezzo; }

    public BigDecimal getIva() { return iva; }
    public void setIva(BigDecimal iva) { this.iva = iva; }

    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }

    public String getImmagine() { return immagine; }
    public void setImmagine(String immagine) { this.immagine = immagine; }
}
