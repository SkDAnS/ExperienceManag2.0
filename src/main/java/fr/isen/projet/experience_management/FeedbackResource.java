package fr.isen.projet.experience_management;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;

import java.awt.*;
import java.net.URI;
import java.sql.*;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.List;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.print.DocFlavor;


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
                    feedback.put("dateCreated", feedbackResult.getString("dateCreated"));
                    feedback.put("review", feedbackResult.getString("review"));
                    feedback.put("image", feedbackResult.getString("image"));
                    feedback.put("views", feedbackResult.getInt("views"));
                    feedback.put("dateUpdated", feedbackResult.getString("dateUpdated"));
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


    @GET
    @Path("/{idFeedback}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getFeedbackById(@PathParam("idFeedback") String id) throws JsonProcessingException {
        Map<String, Object> feedback = null;
        try {

            feedback = getFeedbackDataById(id); // Implémentez cette méthode pour récupérer les données par ID
            // Vérifier si une image existe avant d'essayer de l'ouvrir
            if (feedback.containsKey("image") && feedback.get("image") != null) {
                String imageUrls = (String) feedback.get("image");
                if (!imageUrls.isEmpty()) {
                    openImagesInBrowser(imageUrls);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(feedback);
    }

    private Map<String, Object> getFeedbackDataById(String id) throws Exception {
        Map<String, Object> feedback = new HashMap<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Requête SQL pour récupérer un retour utilisateur spécifique par ID
            String sql = "SELECT fm.idFeedback, fm.title, fm.dateCreated, fm.review, fm.image, fm.views, fm.dateUpdated, fm.idUser, fm.idOrder, fc.name AS category " +
                    "FROM FeedbackModel fm " +
                    "JOIN FEEDBACKCATEGORY fc ON fm.category = fc.id " +
                    "WHERE fm.idFeedback = ?";
            try (PreparedStatement feedbackStatement = connection.prepareStatement(sql)) {
                feedbackStatement.setString(1, id);

                try (ResultSet feedbackResult = feedbackStatement.executeQuery()) {
                    if (feedbackResult.next()) {
                        feedback.put("idFeedback", feedbackResult.getString("idFeedback"));
                        feedback.put("title", feedbackResult.getString("title"));
                        feedback.put("dateCreated", feedbackResult.getString("dateCreated"));
                        feedback.put("review", feedbackResult.getString("review"));
                        feedback.put("image", feedbackResult.getString("image"));
                        feedback.put("views", feedbackResult.getInt("views"));
                        feedback.put("dateUpdated", feedbackResult.getString("dateUpdated"));
                        feedback.put("idUser", feedbackResult.getString("idUser"));
                        feedback.put("idOrder", feedbackResult.getString("idOrder"));
                        feedback.put("category", feedbackResult.getString("category"));
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de la connexion ou de l'exécution de la requête : " + e.getMessage());
            throw e;
        }

        return feedback;
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public String addFeedback(Map<String, Object> feedbackData) {
        Map<String, Object> response = new HashMap<>();

        try {
            String idFeedback = UUID.randomUUID().toString(); // Génère un UUID pour idFeedback
            boolean success = insertFeedbackData(feedbackData,idFeedback);


            if (success) {
                response.put("status", "success");
                response.put("message", "Feedback ajouté avec succès.");
                response.put("idFeedback",idFeedback);
            } else {
                response.put("status", "error");
                response.put("message", "Échec de l'ajout du feedback.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Erreur lors de l'ajout du feedback : " + e.getMessage());
            e.printStackTrace();
        }

        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(response);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return "{\"status\":\"error\", \"message\":\"Erreur lors de la conversion de la réponse en JSON.\"}";
        }
    }

    private boolean insertFeedbackData(Map<String, Object> feedbackData,String idFeedback) throws Exception {
        String sql = "INSERT INTO FeedbackModel (idFeedback, title, dateCreated, review, image, views, dateUpdated, idUser, idOrder, category) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String publicationDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")); // Format compatible avec MySQL

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                // Remplissage des valeurs dans la requête SQL
                statement.setString(1, idFeedback);
                statement.setString(2, (String) feedbackData.get("title"));
                statement.setDate(3, Date.valueOf(publicationDate)); // dateCreated
                statement.setString(4, (String) feedbackData.get("review"));
                statement.setString(5, (String) feedbackData.get("image"));
                statement.setInt(6, (Integer) feedbackData.getOrDefault("views", 0)); // Définit 0 par défaut si views n'est pas fourni
                statement.setString(7, publicationDate); // dateUpdated
                statement.setString(8, (String) feedbackData.get("idUser"));
                statement.setString(9, (String) feedbackData.get("idOrder"));
                statement.setInt(10, (Integer) feedbackData.get("category")); // Utilise l'ID de la catégorie

                // Exécution de la requête
                int rowsInserted = statement.executeUpdate();
                return rowsInserted > 0;
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de l'insertion des données : " + e.getMessage());
            throw e;
        }
    }
    @PUT
    @Path("/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public String updateFeedback(@PathParam("id") String idFeedback, Map<String, Object> feedbackData) {
        Map<String, Object> response = new HashMap<>();

        try {
            boolean success = updateFeedbackData(idFeedback, feedbackData);

            if (success) {
                response.put("status", "success");
                response.put("message", "Feedback mis à jour avec succès.");
            } else {
                response.put("status", "error");
                response.put("message", "Échec de la mise à jour du feedback.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Erreur lors de la mise à jour du feedback : " + e.getMessage());
            e.printStackTrace();
        }

        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(response);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return "{\"status\":\"error\", \"message\":\"Erreur lors de la conversion de la réponse en JSON.\"}";
        }
    }
    private boolean updateFeedbackData(String idFeedback, Map<String, Object> feedbackData) throws Exception {
        String sql = "UPDATE FeedbackModel SET title = ?, review = ?, image = ?, views = ?, dateUpdated = ?, idUser = ?, idOrder = ?, category = ? WHERE idFeedback = ?";
        String publicationDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")); // Format compatible avec MySQL

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, (String) feedbackData.get("title"));
                statement.setString(2, (String) feedbackData.get("review"));
                statement.setString(3, (String) feedbackData.get("image"));
                statement.setInt(4, (Integer) feedbackData.getOrDefault("views", 0)); // Définit 0 par défaut si views n'est pas fourni
                statement.setString(5, publicationDate); // Définit la date actuelle
                statement.setString(6, (String) feedbackData.get("idUser"));
                statement.setString(7, (String) feedbackData.get("idOrder"));
                statement.setInt(8, (Integer) feedbackData.get("category")); // Utilise directement un ID pour category
                statement.setString(9, idFeedback); // ID du feedback à mettre à jour

                int rowsUpdated = statement.executeUpdate();
                return rowsUpdated > 0;
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de la mise à jour des données : " + e.getMessage());
            throw e;
        }
    }
    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String deleteFeedback(@PathParam("id") String idFeedback) {
        Map<String, Object> response = new HashMap<>();

        try {
            boolean success = deleteFeedbackData(idFeedback);

            if (success) {
                response.put("status", "success");
                response.put("message", "Feedback supprimé avec succès.");
            } else {
                response.put("status", "error");
                response.put("message", "Échec de la suppression du feedback.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Erreur lors de la suppression du feedback : " + e.getMessage());
            e.printStackTrace();
        }

        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(response);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return "{\"status\":\"error\", \"message\":\"Erreur lors de la conversion de la réponse en JSON.\"}";
        }
    }
    private boolean deleteFeedbackData(String idFeedback) throws Exception {
        String sql = "DELETE FROM FeedbackModel WHERE idFeedback = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, idFeedback);

                int rowsDeleted = statement.executeUpdate();
                return rowsDeleted > 0;
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de la suppression des données : " + e.getMessage());
            throw e;
        }
    }

    private void openImagesInBrowser(String imageUrls) {
        try {
            if (Desktop.isDesktopSupported()) {
                Desktop desktop = Desktop.getDesktop();
                String[] urls = imageUrls.split("<separationlienimage>");
                for (String url : urls) {
                    if (!url.isEmpty()) {
                        desktop.browse(new URI(url));
                        System.out.println("Image ouverte dans le navigateur : " + url);
                    }
                }
            } else {
                System.out.println("Desktop n'est pas supporté sur cette machine.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}