package fr.isen.projet.experience_management.interfaces.models;

import java.util.Date;
import com.modeliosoft.modelio.javadesigner.annotations.mdl;
import com.modeliosoft.modelio.javadesigner.annotations.objid;
import fr.isen.projet.experience_management.interfaces.models.enums.MEMORYCATEGORY;
import fr.isen.projet.experience_management.interfaces.models.enums.SHARE;

@objid ("d7e1f9bd-1d51-47b6-97ab-3a7e98945ecd")
public class MemoryModel {
    @mdl.prop
    @objid ("72c5292a-d5f0-4ee0-9313-5034070a95c6")
    private int idMemory;

    @objid ("6f777f6d-d21d-45d8-85a7-49a363551e61")
    public String title;

    @objid ("2ed3463d-daa9-4eb0-9f0c-c4e2870e45b6")
    public Date publicationDate;

    @objid ("72f449c7-5143-4638-8b4c-2a55157c445e")
    public MEMORYCATEGORY category;

    @objid ("3c6f68e9-8bd7-4200-9f49-24172fec991b")
    public int views;

    @objid ("7d2ee375-9ef5-47ba-ac50-20117db729f7")
    public String image;

    @objid ("850c8300-ff4a-41ff-af77-92dbf1cdfec3")
    public String description;

    @objid ("6899c242-1775-48c0-8810-9792256f6e08")
    public String place;

    @objid ("8111c03d-549c-43a6-892f-fcf3241f3733")
    public String hashtag;

    @objid ("a00ee99c-3077-4e61-a8ca-d203ddb0c7df")
    public SHARE share;

    @objid ("f78355b6-d721-4c33-b910-b50e85498b63")
    public String tag;

    @mdl.prop
    @objid ("06feade9-be04-4d6d-8315-9c30d7753600")
    private int idOrder;

    @mdl.prop
    @objid ("6905a2af-d2dd-4d6d-9a7f-8e9a52acea48")
    private int idUser;

    @objid ("4dedfb37-8ddd-462a-b630-535b5171c301")
    public boolean bDelete;

}
