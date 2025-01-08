package fr.isen.projet.experience_management.interfaces.models;

import java.util.Date;
import fr.isen.projet.experience_management.interfaces.models.enums.MEMORYCATEGORY;
import fr.isen.projet.experience_management.interfaces.models.enums.SHARE;

public class MemoryModel {
    private String idMemory;

    public String title;

    public Date publicationDate;

    public MEMORYCATEGORY category;

    public int views;

    public String image;

    public String description;

    public String place;

    public String hashtag;

    public SHARE share;

    public String tag;

    private String idOrder;

    private String idUser;

    public boolean bDelete;

}
