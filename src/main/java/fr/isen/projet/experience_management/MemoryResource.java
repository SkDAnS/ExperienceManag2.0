package fr.isen.projet.experience_management;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.awt.Desktop;
import java.net.URI;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Path("/memory")
public class MemoryResource {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/projet";
    private static final String DB_USER = "admin";
    private static final String DB_PASSWORD = "1234";

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

    @GET
    @Path("/{idMemory}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getMemoryById(@PathParam("idMemory") String idMemory) throws JsonProcessingException {
        Map<String, Object> memory = new HashMap<>();
        try {
            memory = getMemoryByIdData(idMemory);

            // Vérifier si une image existe avant d'essayer de l'ouvrir
            if (memory.containsKey("image") && memory.get("image") != null) {
                String imageUrls = (String) memory.get("image");
                if (!imageUrls.isEmpty()) {
                    openImagesInBrowser(imageUrls);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(memory);
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response createMemory(Map<String, Object> memoryData) throws JsonProcessingException {
        try {
            String title = (String) memoryData.get("title");
            Integer category = (Integer) memoryData.get("category");
            String description = (String) memoryData.get("description");
            String place = (String) memoryData.get("place");
            String hashtag = (String) memoryData.get("hashtag");
            Integer share = (Integer) memoryData.get("share");
            String tag = (String) memoryData.get("tag");
            String idOrder = (String) memoryData.get("idOrder");
            String idUser = (String) memoryData.get("idUser");
            String image = (String) memoryData.get("image");

            if (title == null || category == null || description == null || place == null || share == null || idUser == null) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity("{\"message\":\"Missing required fields!\"}")
                        .build();
            }

            String idMemory = java.util.UUID.randomUUID().toString();
            String publicationDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "INSERT INTO MemoryModel (idMemory, title, publicationDate, category, description, place, hashtag, share, tag, idOrder, idUser, image) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setString(1, idMemory);
                    preparedStatement.setString(2, title);
                    preparedStatement.setString(3, publicationDate);
                    preparedStatement.setInt(4, category);
                    preparedStatement.setString(5, description);
                    preparedStatement.setString(6, place);
                    preparedStatement.setString(7, hashtag);
                    preparedStatement.setInt(8, share);
                    preparedStatement.setString(9, tag);
                    preparedStatement.setString(10, idOrder);
                    preparedStatement.setString(11, idUser);
                    preparedStatement.setString(12, image);

                    int rowsAffected = preparedStatement.executeUpdate();
                    if (rowsAffected > 0) {
                        return Response.status(Response.Status.CREATED)
                                .entity("{\"message\":\"Memory created successfully!\",\"idMemory\":\"" + idMemory + "\"}")
                                .build();
                    } else {
                        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                                .entity("{\"message\":\"Error creating memory!\"}")
                                .build();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"message\":\"Error processing request!\"}")
                    .build();
        }
    }

    @PUT
    @Path("/{idMemory}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateMemory(@PathParam("idMemory") String idMemory, Map<String, Object> memoryData) throws JsonProcessingException {
        try {
            String title = (String) memoryData.get("title");
            String publicationDate = (String) memoryData.get("publicationDate");
            Integer category = (Integer) memoryData.get("category");
            String description = (String) memoryData.get("description");
            String place = (String) memoryData.get("place");
            String hashtag = (String) memoryData.get("hashtag");
            Integer share = (Integer) memoryData.get("share");
            String tag = (String) memoryData.get("tag");
            String idOrder = (String) memoryData.get("idOrder");
            String idUser = (String) memoryData.get("idUser");
            String image = (String) memoryData.get("image");

            if (title == null || category == null || description == null || place == null || share == null || idUser == null) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity("{\"message\":\"Missing required fields!\"}")
                        .build();
            }

            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "UPDATE MemoryModel SET title = ?, publicationDate = ?, category = ?, description = ?, place = ?, hashtag = ?, "
                        + "share = ?, tag = ?, idOrder = ?, idUser = ?, image = ? WHERE idMemory = ?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setString(1, title);
                    preparedStatement.setString(2, publicationDate);
                    preparedStatement.setInt(3, category);
                    preparedStatement.setString(4, description);
                    preparedStatement.setString(5, place);
                    preparedStatement.setString(6, hashtag);
                    preparedStatement.setInt(7, share);
                    preparedStatement.setString(8, tag);
                    preparedStatement.setString(9, idOrder);
                    preparedStatement.setString(10, idUser);
                    preparedStatement.setString(11, image);
                    preparedStatement.setString(12, idMemory);

                    int rowsAffected = preparedStatement.executeUpdate();
                    if (rowsAffected > 0) {
                        return Response.status(Response.Status.OK)
                                .entity("{\"message\":\"Memory updated successfully!\"}")
                                .build();
                    } else {
                        return Response.status(Response.Status.NOT_FOUND)
                                .entity("{\"message\":\"Memory not found!\"}")
                                .build();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"message\":\"Error processing request!\"}")
                    .build();
        }
    }

    @DELETE
    @Path("/{idMemory}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteMemory(@PathParam("idMemory") String idMemory) {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "DELETE FROM MemoryModel WHERE idMemory = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, idMemory);

                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    return Response.status(Response.Status.OK)
                            .entity("{\"message\":\"Memory deleted successfully!\"}")
                            .build();
                } else {
                    return Response.status(Response.Status.NOT_FOUND)
                            .entity("{\"message\":\"Memory not found!\"}")
                            .build();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"message\":\"Error processing request!\"}")
                    .build();
        }
    }

    private List<Map<String, Object>> getMemoryData() throws Exception {
        List<Map<String, Object>> memoryList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
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
                    memory.put("publicationDate", memoryResult.getString("publicationDate"));
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

    private Map<String, Object> getMemoryByIdData(String idMemory) throws Exception {
        Map<String, Object> memory = new HashMap<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT mm.idMemory, mm.title, mm.publicationDate, mm.views, mm.image, mm.description, mm.place, mm.hashtag, mm.tag, mm.share, " +
                    "mm.idOrder, mm.idUser, mm.category, mm.bDelete, mc.name AS categoryName, s.name AS shareType " +
                    "FROM MemoryModel mm " +
                    "JOIN MEMORYCATEGORY mc ON mm.category = mc.id " +
                    "JOIN SHARE s ON mm.share = s.id " +
                    "WHERE mm.idMemory = ?";
            try (PreparedStatement memoryStatement = connection.prepareStatement(sql)) {
                memoryStatement.setString(1, idMemory);
                try (ResultSet memoryResult = memoryStatement.executeQuery()) {
                    if (memoryResult.next()) {
                        memory.put("idMemory", memoryResult.getString("idMemory"));
                        memory.put("title", memoryResult.getString("title"));
                        memory.put("publicationDate", memoryResult.getString("publicationDate"));
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
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de la connexion ou de l'exécution de la requête : " + e.getMessage());
            throw e;
        }

        return memory;
    }

    // Méthode pour ouvrir plusieurs liens dans un navigateur
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


