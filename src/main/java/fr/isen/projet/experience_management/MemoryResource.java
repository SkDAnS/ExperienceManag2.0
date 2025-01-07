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

@Path("/memory")
public class MemoryResource {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/projet"; // URL de la base
    private static final String DB_USER = "admin"; // Nom d'utilisateur
    private static final String DB_PASSWORD = "1234"; // Mot de passe

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getMemory() throws JsonProcessingException {
        List<Map<String, Object>> memoryList = new ArrayList<>();
        try {
            memoryList = getMemoryData();
        } catch (Exception e) {
            e.printStackTrace();
        }

        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(memoryList);
    }

    private List<Map<String, Object>> getMemoryData() throws Exception {
        List<Map<String, Object>> memoryList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Requête SQL pour récupérer toutes les mémoires
            String sql = "SELECT mm.idMemory, mm.title, mm.publicationDate, mm.views, mm.image, mm.description, mm.place, mm.hashtag, mm.tag, mm.share, " +
                    "mm.idOrder, mm.idUser, mm.category, mm.bDelete, mc.name AS categoryName, s.name AS shareType " +
                    "FROM MemoryModel mm " +
                    "JOIN MEMORYCATEGORY mc ON mm.category = mc.id " +
                    "JOIN SHARE s ON mm.share = s.id";
            try (Statement memoryStatement = connection.createStatement();
                 ResultSet memoryResult = memoryStatement.executeQuery(sql)) {

                while (memoryResult.next()) {
                    Map<String, Object> memory = new HashMap<>();
                    memory.put("idMemory", memoryResult.getString("idMemory"));
                    memory.put("title", memoryResult.getString("title"));
                    memory.put("publicationDate", memoryResult.getDate("publicationDate"));
                    memory.put("views", memoryResult.getInt("views"));
                    memory.put("image", memoryResult.getString("image"));
                    memory.put("description", memoryResult.getString("description"));
                    memory.put("place", memoryResult.getString("place"));
                    memory.put("hashtag", memoryResult.getString("hashtag"));
                    memory.put("tag", memoryResult.getString("tag"));
                    memory.put("share", memoryResult.getString("shareType"));
                    memory.put("idOrder", memoryResult.getString("idOrder"));
                    memory.put("idUser", memoryResult.getString("idUser"));
                    memory.put("category", memoryResult.getString("categoryName"));
                    memory.put("bDelete", memoryResult.getBoolean("bDelete"));
                    memoryList.add(memory);
                }
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de la connexion ou de l'exécution de la requête : " + e.getMessage());
            throw e;
        }

        return memoryList;
    }
}
