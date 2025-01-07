package fr.isen.projet.experience_management.interfaces.services;

import java.util.List;
import com.modeliosoft.modelio.javadesigner.annotations.objid;
import fr.isen.projet.experience_management.interfaces.models.FeedbackModel;

@objid ("00a23cf7-5b72-4801-ace9-c434b3aab25c")
public interface FeedbackService {
    @objid ("d68b92a4-b396-46e9-8a87-2ce7503d58e9")
    List<FeedbackModel> getAllFeedback();

    @objid ("0d7f1ab2-0ea5-411f-9bba-5c8dedeadae5")
    FeedbackModel getFeedbackById(final int id);

    @objid ("6f00387b-ae03-4ce7-b6d9-a0e2cd336754")
    int addFeedback(final FeedbackModel feedback);

    @objid ("3b0c6d19-7766-4d90-b182-beb33b1b66e2")
    boolean removeFeedback(final String feedbackId);

    @objid ("49cf6313-a703-4a48-82da-3c0209564f43")
    FeedbackModel updateFeedback(final FeedbackModel newFeedback);

}
