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

@Path("/fe")
public class FeedbackResourcev2 {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/projet"; // URL de la base
    private static final String DB_USER = "admin"; // Nom d'utilisateur
    private static final String DB_PASSWORD = "1234"; // Mot de passe

    // Méthode pour valider si idVentes existe dans la table donnée
    private boolean isValidIdForType(String type, String idVentes) throws Exception {
        String sql = "";
        switch (type) {
            case "formation":
                sql = "SELECT 1 FROM formation WHERE formationid = ?";
                break;
            case "apartment":
                sql = "SELECT 1 FROM apartment WHERE id = ?";
                break;
            case "location":
                sql = "SELECT 1 FROM location WHERE locationId = ?";
                break;
            default:
                return false; // Type non valide
        }

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, idVentes);
                try (ResultSet resultSet = statement.executeQuery()) {
                    return resultSet.next(); // Retourne vrai si une ligne est trouvée
                }
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de la validation de l'ID : " + e.getMessage());
            throw e;
        }
    }

    @GET
    @Path("/feedback/")
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
                    "FROM feedbackmodel fm " +
                    "JOIN feedbackcategory fc ON fm.category = fc.id";
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
    @Path("/fid/{type:formation|apartment|location}/{idVentes}/feedback/{idFeedback}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getFeedbackById(
            @PathParam("type") String type,
            @PathParam("idVentes") String idVentes,
            @PathParam("idFeedback") String idFeedback) throws JsonProcessingException {
        Map<String, Object> response = new HashMap<>();
        Map<String, Object> feedback = null;

        try {
            // Valider l'existence de l'idVentes
            if (!isValidIdForType(type, idVentes)) {
                response.put("status", "error");
                response.put("message", "ID non valide pour le type spécifié.");
                return new ObjectMapper().writeValueAsString(response);
            }
            incrementViews(idFeedback); // Incrémenter les vues avant de récupérer les données
            feedback = getFeedbackDataById(idFeedback);
            // Vérifier si une image existe avant d'essayer de l'ouvrir
            if (feedback.containsKey("image") && feedback.get("image") != null) {
                String imageUrls = (String) feedback.get("image");
                if (!imageUrls.isEmpty()) {
                    openImagesInBrowser(imageUrls);
                }
            }

            // Récupérer le feedback associé
            feedback = getFeedbackDataById(idFeedback);

            if (feedback != null) {
                response.put("status", "success");
                response.put("data", feedback);
            } else {
                response.put("status", "error");
                response.put("message", "Aucun feedback trouvé pour cet ID.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Erreur lors de la récupération du feedback : " + e.getMessage());
            e.printStackTrace();
        }

        return new ObjectMapper().writeValueAsString(response);
    }

    private Map<String, Object> getFeedbackDataById(String idFeedback) throws Exception {
        Map<String, Object> feedback = new HashMap<>();
        String sql = "SELECT fm.idFeedback, fm.title, fm.dateCreated, fm.review, fm.image, fm.views, fm.dateUpdated, fm.idUser, fm.idOrder, fc.name AS category " +
                "FROM feedbackfodel fm " +
                "JOIN feedbackcategory fc ON fm.category = fc.id " +
                "WHERE fm.idFeedback = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, idFeedback);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        feedback.put("idFeedback", resultSet.getString("idFeedback"));
                        feedback.put("title", resultSet.getString("title"));
                        feedback.put("dateCreated", formatTimestamp(resultSet.getTimestamp("dateCreated")));
                        feedback.put("review", resultSet.getString("review"));
                        feedback.put("image", resultSet.getString("image"));
                        feedback.put("views", resultSet.getInt("views"));
                        feedback.put("dateUpdated", formatTimestamp(resultSet.getTimestamp("dateUpdated")));
                        feedback.put("idUser", resultSet.getString("idUser"));
                        feedback.put("idOrder", resultSet.getString("idOrder"));
                        feedback.put("category", resultSet.getString("category"));
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur SQL : " + e.getMessage());
            throw e;
        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des données : " + e.getMessage());
            throw e;
        }

        return feedback;
    }


    @POST
    @Path("/{type:formation|apartment|location}/{idVentes}/feedback/")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public String addFeedback(@PathParam("type") String type, @PathParam("idVentes") String idVentes, Map<String, Object> feedbackData) {
        Map<String, Object> response = new HashMap<>();

        try {
            // Valider l'existence de l'idVentes
            if (!isValidIdForType(type, idVentes)) {
                response.put("status", "error");
                response.put("message", "ID non valide pour le type spécifié.");
                return new ObjectMapper().writeValueAsString(response);
            }

            // Générer un UUID pour le feedback
            String idFeedback = UUID.randomUUID().toString();

            // Insérer le feedback
            boolean success = insertFeedbackData(idFeedback, feedbackData);

            if (success) {
                response.put("status", "success");
                response.put("message", "Feedback ajouté avec succès.");
                response.put("idFeedback", idFeedback);
            } else {
                response.put("status", "error");
                response.put("message", "Échec de l'ajout du feedback.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Erreur lors de l'ajout du feedback : " + e.getMessage());
            e.printStackTrace();
        }

        try {
            return new ObjectMapper().writeValueAsString(response);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return "{\"status\":\"error\", \"message\":\"Erreur lors de la conversion de la réponse en JSON.\"}";
        }
    }

    private boolean insertFeedbackData(String idFeedback, Map<String, Object> feedbackData) throws Exception {
        String sql = "INSERT INTO feedbackmodel (idFeedback, title, dateCreated, review, image, category, views, dateUpdated, idUser, idOrder, bDelete) " +
                "VALUES (?, ?, ?, ?, ?, ?, 0, ?, ?, ?, false)";

        // Obtenir la date actuelle
        String publicationDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                // Remplir les paramètres de la requête
                statement.setString(1, idFeedback);
                statement.setString(2, (String) feedbackData.get("title"));
                statement.setDate(3, Date.valueOf(publicationDate)); // dateCreated
                statement.setString(4, (String) feedbackData.get("review"));
                statement.setString(5, (String) feedbackData.get("image"));
                statement.setInt(6, (Integer) feedbackData.get("category")); // ID de la catégorie
                statement.setDate(7, Date.valueOf(publicationDate)); // dateUpdated
                statement.setString(8, (String) feedbackData.get("idUser"));
                statement.setString(9, (String) feedbackData.get("idOrder"));

                int rowsInserted = statement.executeUpdate();
                return rowsInserted > 0; // Retourne vrai si l'insertion a réussi
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de l'insertion des données : " + e.getMessage());
            throw e;
        }
    }



    @PUT
    @Path("/fid/{type:formation|apartment|location}/{idVentes}/feedback/{idFeedback}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public String updateFeedback(
            @PathParam("type") String type,
            @PathParam("idVentes") String idVentes,
            @PathParam("idFeedback") String idFeedback,
            Map<String, Object> feedbackData) throws JsonProcessingException {
        Map<String, Object> response = new HashMap<>();

        try {
            // Valider l'existence de l'idVentes
            if (!isValidIdForType(type, idVentes)) {
                response.put("status", "error");
                response.put("message", "ID non valide pour le type spécifié.");
                return new ObjectMapper().writeValueAsString(response);
            }

            // Mettre à jour le feedback
            boolean success = updateFeedbackData(idFeedback, feedbackData);

            if (success) {
                response.put("status", "success");
                response.put("message", "Feedback mis à jour avec succès.");
            } else {
                response.put("status", "error");
                response.put("message", "Aucun feedback trouvé pour cet ID ou échec de la mise à jour.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Erreur lors de la mise à jour du feedback : " + e.getMessage());
            e.printStackTrace();
        }

        return new ObjectMapper().writeValueAsString(response);
    }

    private boolean updateFeedbackData(String idFeedback, Map<String, Object> feedbackData) throws Exception {
        String sql = "UPDATE feedbackmodel SET title = ?, review = ?, image = ?, category = ?, dateUpdated = ? WHERE idFeedback = ?";
        String publicationDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, (String) feedbackData.get("title")); // Met à jour le titre
                statement.setString(2, (String) feedbackData.get("review")); // Met à jour la review
                statement.setString(3, (String) feedbackData.get("image")); // Met à jour l'image
                statement.setInt(4, (Integer) feedbackData.get("category")); // Met à jour la catégorie
                statement.setString(5, publicationDate); // Met à jour la date actuelle
                statement.setString(6, idFeedback); // L'identifiant du feedback à mettre à jour

                int rowsUpdated = statement.executeUpdate();
                return rowsUpdated > 0; // Retourne vrai si une mise à jour a été effectuée
            }
        } catch (SQLException e) {
            System.err.println("Erreur SQL : " + e.getMessage());
            throw e;
        }
    }

    @DELETE
    @Path("/fid/{type:formation|apartment|location}/{idVentes}/feedback/{idFeedback}")
    @Produces(MediaType.APPLICATION_JSON)
    public String deleteFeedback(
            @PathParam("type") String type,
            @PathParam("idVentes") String idVentes,
            @PathParam("idFeedback") String idFeedback) throws JsonProcessingException {
        Map<String, Object> response = new HashMap<>();

        try {
            // Valider l'existence de l'idVentes
            if (!isValidIdForType(type, idVentes)) {
                response.put("status", "error");
                response.put("message", "ID non valide pour le type spécifié.");
                return new ObjectMapper().writeValueAsString(response);
            }

            // Supprimer le feedback
            boolean success = deleteFeedbackData(idFeedback);

            if (success) {
                response.put("status", "success");
                response.put("message", "Feedback supprimé avec succès.");
            } else {
                response.put("status", "error");
                response.put("message", "Aucun feedback trouvé pour cet ID ou échec de la suppression.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Erreur lors de la suppression du feedback : " + e.getMessage());
            e.printStackTrace();
        }

        return new ObjectMapper().writeValueAsString(response);
    }

    private boolean deleteFeedbackData(String idFeedback) throws Exception {
        String sql = "DELETE FROM feedbackmodel WHERE idFeedback = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, idFeedback);

                int rowsDeleted = statement.executeUpdate();
                return rowsDeleted > 0; // Retourne vrai si une suppression a été effectuée
            }
        } catch (SQLException e) {
            System.err.println("Erreur SQL : " + e.getMessage());
            throw e;
        }
    }

    private void incrementViews(String idFeedback) throws Exception {
        String sql = "UPDATE feedbackmodel SET views = views + 1 WHERE idFeedback = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, idFeedback);
                statement.executeUpdate();
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de l'incrémentation des vues : " + e.getMessage());
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
    private String formatTimestamp(Timestamp timestamp) {
        if (timestamp == null) {
            return null;
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return timestamp.toLocalDateTime().format(formatter);
    }
}
