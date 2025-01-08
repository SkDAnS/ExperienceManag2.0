package fr.isen.projet.experience_management.interfaces.models;

import java.util.Date;
import fr.isen.projet.experience_management.interfaces.models.enums.FEEDBACKCATEGORY;
import fr.isen.projet.experience_management.interfaces.models.enums.REVIEW;

public class FeedbackModel {
    private String idFeedback;

    public String title;

    public Date dateCreated;

    public REVIEW review;

    public String image;

    public FEEDBACKCATEGORY category;

    public int views;

    public Date dateUpdated;

    private String idUser;

    private String idOrder;

    public boolean bDelete;

}
