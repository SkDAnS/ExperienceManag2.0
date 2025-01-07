package fr.isen.projet.experience_management.interfaces.models;

import java.util.Date;
import fr.isen.projet.experience_management.interfaces.models.enums.FEEDBACKCATEGORY;
import fr.isen.projet.experience_management.interfaces.models.enums.REVIEW;

//begin of modifiable zone(Javadoc).......C/f8f1ef0b-10b8-4975-a8b0-c76beba603ea

//end of modifiable zone(Javadoc).........E/f8f1ef0b-10b8-4975-a8b0-c76beba603ea
public class FeedbackModel {
//begin of modifiable zone(Javadoc).......C/1d4aba97-a328-4873-8d23-8c283eb66ee5

//end of modifiable zone(Javadoc).........E/1d4aba97-a328-4873-8d23-8c283eb66ee5
    private int idFeedback;

//begin of modifiable zone(Javadoc).......C/10ab28bf-2ce9-425f-88fe-1bd409b39c75

//end of modifiable zone(Javadoc).........E/10ab28bf-2ce9-425f-88fe-1bd409b39c75
    public String title;

//begin of modifiable zone(Javadoc).......C/d979580d-fd68-4c75-90ca-9ce61a8dab21

//end of modifiable zone(Javadoc).........E/d979580d-fd68-4c75-90ca-9ce61a8dab21
    public Date creationDate;

//begin of modifiable zone(Javadoc).......C/22f82b11-e1a1-417c-9f2e-d4dc66904b63

//end of modifiable zone(Javadoc).........E/22f82b11-e1a1-417c-9f2e-d4dc66904b63
    public REVIEW review;

//begin of modifiable zone(Javadoc).......C/2c8545e6-2ce5-4244-ac5e-20429ff20082

//end of modifiable zone(Javadoc).........E/2c8545e6-2ce5-4244-ac5e-20429ff20082
    public String image;

//begin of modifiable zone(Javadoc).......C/59ee0512-fa99-41c2-93f4-f568d7adebbc

//end of modifiable zone(Javadoc).........E/59ee0512-fa99-41c2-93f4-f568d7adebbc
    public FEEDBACKCATEGORY category;

//begin of modifiable zone(Javadoc).......C/598020a5-9219-4b77-b070-40090d772c97

//end of modifiable zone(Javadoc).........E/598020a5-9219-4b77-b070-40090d772c97
    public int views;

//begin of modifiable zone(Javadoc).......C/bf42f0dc-cb9d-40c2-b80e-d870f48b6a73

//end of modifiable zone(Javadoc).........E/bf42f0dc-cb9d-40c2-b80e-d870f48b6a73
    public Date updateDate;

//begin of modifiable zone(Javadoc).......C/d4a90ed6-79f4-43b2-a6c3-b409479650fa

//end of modifiable zone(Javadoc).........E/d4a90ed6-79f4-43b2-a6c3-b409479650fa
    private int idUser;

//begin of modifiable zone(Javadoc).......C/28a9d2d8-e593-4b4e-9cb7-582f71df3620

//end of modifiable zone(Javadoc).........E/28a9d2d8-e593-4b4e-9cb7-582f71df3620
    private int idOrder;

//begin of modifiable zone(Javadoc).......C/31101eaf-2413-4cac-bb0c-d9c0fbb2fa83

//end of modifiable zone(Javadoc).........E/31101eaf-2413-4cac-bb0c-d9c0fbb2fa83
    public boolean bDelete;

}
