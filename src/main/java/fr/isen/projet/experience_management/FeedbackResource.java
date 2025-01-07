package fr.isen.projet.experience_management;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Path("/feedback")
public class FeedbackResource {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/projet"; // URL de la base
    private static final String DB_USER = "admin"; // Nom d'utilisateur
    private static final String DB_PASSWORD = "1234"; // Mot de passe

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getFeedback() throws JsonProcessingException {
        List<Map<String, Object>> feedbackList = new ArrayList<>();
        try {
            feedbackList = getFeedbackData();
        } catch (Exception e) {
            e.printStackTrace();
        }

        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(feedbackList);
    }

    private List<Map<String, Object>> getFeedbackData() throws Exception {
        List<Map<String, Object>> feedbackList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Requête SQL pour récupérer tous les retours utilisateurs
            String sql = "SELECT fm.idFeedback, fm.title, fm.dateCreated, fm.review, fm.image, fm.views, fm.dateUpdated, fm.idUser, fm.idOrder, fc.name AS category " +
                    "FROM FeedbackModel fm " +
                    "JOIN FEEDBACKCATEGORY fc ON fm.category = fc.id";
            try (Statement feedbackStatement = connection.createStatement();
                 ResultSet feedbackResult = feedbackStatement.executeQuery(sql)) {

                while (feedbackResult.next()) {
                    Map<String, Object> feedback = new HashMap<>();
                    feedback.put("idFeedback", feedbackResult.getString("idFeedback"));
                    feedback.put("title", feedbackResult.getString("title"));
                    feedback.put("dateCreated", feedbackResult.getDate("dateCreated"));
                    feedback.put("review", feedbackResult.getString("review"));
                    feedback.put("image", feedbackResult.getString("image"));
                    feedback.put("views", feedbackResult.getInt("views"));
                    feedback.put("dateUpdated", feedbackResult.getDate("dateUpdated"));
                    feedback.put("idUser", feedbackResult.getString("idUser"));
                    feedback.put("idOrder", feedbackResult.getString("idOrder"));
                    feedback.put("category", feedbackResult.getString("category"));
                    feedbackList.add(feedback);
                }
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de la connexion ou de l'exécution de la requête : " + e.getMessage());
            throw e;
        }

        return feedbackList;
    }
}
