package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ConcertoBean {
    private int idConcerto;
    private Integer idArtista;
    private String nome;
    private String luogo;
    private Timestamp dataEvento;
    private BigDecimal prezzo;
    private String descrizione;
    private String immagine;
    private boolean active = true;

    public int getIdConcerto() { return idConcerto; }
    public void setIdConcerto(int idConcerto) { this.idConcerto = idConcerto; }

    public Integer getIdArtista() { return idArtista; }
    public void setIdArtista(Integer idArtista) { this.idArtista = idArtista; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getLuogo() { return luogo; }
    public void setLuogo(String luogo) { this.luogo = luogo; }

    public Timestamp getDataEvento() { return dataEvento; }
    public void setDataEvento(Timestamp dataEvento) { this.dataEvento = dataEvento; }

    public BigDecimal getPrezzo() { return prezzo; }
    public void setPrezzo(BigDecimal prezzo) { this.prezzo = prezzo; }

    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }

    public String getImmagine() { return immagine; }
    public void setImmagine(String immagine) { this.immagine = immagine; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
