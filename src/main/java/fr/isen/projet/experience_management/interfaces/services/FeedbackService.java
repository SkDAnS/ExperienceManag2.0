package fr.isen.projet.experience_management.interfaces.services;

import java.util.List;
import fr.isen.projet.experience_management.interfaces.models.FeedbackModel;

public interface FeedbackService {
    List<FeedbackModel> getAllFeedback();

    FeedbackModel getFeedbackById(final String id);

    String addFeedback(final FeedbackModel feedback);

    boolean removeFeedback(final String feedbackId);

    FeedbackModel updateFeedback(final FeedbackModel newFeedback);

}
