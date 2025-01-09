package fr.isen.projet.experience_management;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.awt.Desktop;
import java.net.URI;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Path("/fe/{type}/{id}/memory")
public class MemoryResource {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/projet";
    private static final String DB_USER = "admin";
    private static final String DB_PASSWORD = "1234";

    private boolean isEntityValid(String type, String id) {
        String table;
        String column;

        switch (type.toLowerCase()) {
            case "formation":
                table = "formation";
                column = "formationId";
                break;
            case "apartment":
                table = "apartment";
                column = "id";
                break;
            case "location":
                table = "location";
                column = "locationId";
                break;
            default:
                return false; // Invalid type
        }

        String sql = "SELECT COUNT(*) FROM " + table + " WHERE " + column + " = ?";
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next() && resultSet.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getMemories(@PathParam("type") String type, @PathParam("id") String id) throws JsonProcessingException {
        if (!isEntityValid(type, id)) {
            return Response.status(Response.Status.UNAUTHORIZED)
                    .entity("{\"message\":\"Invalid " + type + " ID!\"}")
                    .build();
        }

        List<Map<String, Object>> memoryList = new ArrayList<>();
        try {
            memoryList = getAllMemories();
        } catch (Exception e) {
            e.printStackTrace();
        }

        ObjectMapper objectMapper = new ObjectMapper();
        return Response.ok(objectMapper.writeValueAsString(memoryList)).build();
    }

    @GET
    @Path("/{idMemory}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getMemoryById(@PathParam("type") String type, @PathParam("id") String id, @PathParam("idMemory") String idMemory) throws JsonProcessingException {
        if (!isEntityValid(type, id)) {
            return Response.status(Response.Status.UNAUTHORIZED)
                    .entity("{\"message\":\"Invalid " + type + " ID!\"}")
                    .build();
        }

        Map<String, Object> memory = new HashMap<>();
        try {
            incrementViews(idMemory);
            memory = getMemoryByIdData(idMemory);

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
        return Response.ok(objectMapper.writeValueAsString(memory)).build();
    }

    private void incrementViews(String idMemory) throws Exception {
        String sql = "UPDATE MemoryModel SET views = views + 1 WHERE idMemory = ?";
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, idMemory);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response createMemory(@PathParam("type") String type, @PathParam("id") String id, Map<String, Object> memoryData) throws JsonProcessingException {
        // Validate the entity type
        if (!isEntityValid(type, id)) {
            return Response.status(Response.Status.UNAUTHORIZED)
                    .entity("{\"message\":\"Invalid " + type + " ID!\"}")
                    .build();
        }

        try {
            // Extract data from JSON
            String title = (String) memoryData.get("title");
            Integer category = memoryData.containsKey("category") ? (Integer) memoryData.get("category") : null;
            String description = (String) memoryData.get("description");
            String place = (String) memoryData.get("place");
            String hashtag = (String) memoryData.get("hashtag");
            Integer share = memoryData.containsKey("share") ? (Integer) memoryData.get("share") : null;
            String tag = (String) memoryData.get("tag");
            String idOrder = (String) memoryData.get("idOrder");
            String idUser = (String) memoryData.get("idUser");
            String image = (String) memoryData.get("image");

            // Validate required fields
            if (title == null || idUser == null || description == null) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity("{\"message\":\"Missing required fields! 'title', 'idUser', and 'description' are mandatory.\"}")
                        .build();
            }

            String idMemory = UUID.randomUUID().toString();
            String publicationDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            // Insert data into the database
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "INSERT INTO memorymodel (idMemory, title, publicationDate, category, views, image, description, place, hashtag, share, tag, idOrder, idUser, bDelete) "
                        + "VALUES (?, ?, ?, ?, 0, ?, ?, ?, ?, ?, ?, ?, ?, FALSE)";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setString(1, idMemory);
                    preparedStatement.setString(2, title);
                    preparedStatement.setString(3, publicationDate);
                    if (category != null) {
                        preparedStatement.setInt(4, category);
                    } else {
                        preparedStatement.setNull(4, Types.INTEGER);
                    }
                    preparedStatement.setString(5, image);
                    preparedStatement.setString(6, description);
                    preparedStatement.setString(7, place);
                    preparedStatement.setString(8, hashtag);
                    if (share != null) {
                        preparedStatement.setInt(9, share);
                    } else {
                        preparedStatement.setNull(9, Types.INTEGER);
                    }
                    preparedStatement.setString(10, tag);
                    preparedStatement.setString(11, idOrder);
                    preparedStatement.setString(12, idUser);

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
        } catch (SQLException e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"message\":\"Database error: " + e.getMessage() + "\"}")
                    .build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"message\":\"Error processing request: " + e.getMessage() + "\"}")
                    .build();
        }
    }








    @PUT
    @Path("/{idMemory}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateMemory(@PathParam("type") String type, @PathParam("id") String id, @PathParam("idMemory") String idMemory, Map<String, Object> memoryData) throws JsonProcessingException {
        // Validate the entity type
        if (!isEntityValid(type, id)) {
            return Response.status(Response.Status.UNAUTHORIZED)
                    .entity("{\"message\":\"Invalid " + type + " ID!\"}")
                    .build();
        }

        try {
            // Extract data from JSON
            String title = (String) memoryData.get("title");
            Integer category = memoryData.containsKey("category") ? (Integer) memoryData.get("category") : null;
            String description = (String) memoryData.get("description");
            String place = (String) memoryData.get("place");
            String hashtag = (String) memoryData.get("hashtag");
            Integer share = memoryData.containsKey("share") ? (Integer) memoryData.get("share") : null;
            String tag = (String) memoryData.get("tag");
            String idOrder = (String) memoryData.get("idOrder");
            String idUser = (String) memoryData.get("idUser");
            String image = (String) memoryData.get("image");

            // Validate required fields
            if (title == null || idUser == null || description == null) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity("{\"message\":\"Missing required fields! 'title', 'idUser', and 'description' are mandatory.\"}")
                        .build();
            }

            // Update data in the database
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "UPDATE memorymodel SET title = ?, category = ?, description = ?, place = ?, hashtag = ?, share = ?, tag = ?, idOrder = ?, idUser = ?, image = ? WHERE idMemory = ? AND bDelete = FALSE";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setString(1, title);
                    if (category != null) {
                        preparedStatement.setInt(2, category);
                    } else {
                        preparedStatement.setNull(2, Types.INTEGER);
                    }
                    preparedStatement.setString(3, description);
                    preparedStatement.setString(4, place);
                    preparedStatement.setString(5, hashtag);
                    if (share != null) {
                        preparedStatement.setInt(6, share);
                    } else {
                        preparedStatement.setNull(6, Types.INTEGER);
                    }
                    preparedStatement.setString(7, tag);
                    preparedStatement.setString(8, idOrder);
                    preparedStatement.setString(9, idUser);
                    preparedStatement.setString(10, image);
                    preparedStatement.setString(11, idMemory);

                    int rowsAffected = preparedStatement.executeUpdate();
                    if (rowsAffected > 0) {
                        return Response.status(Response.Status.OK)
                                .entity("{\"message\":\"Memory updated successfully!\"}")
                                .build();
                    } else {
                        return Response.status(Response.Status.NOT_FOUND)
                                .entity("{\"message\":\"Memory not found or already deleted!\"}")
                                .build();
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"message\":\"Database error: " + e.getMessage() + "\"}")
                    .build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"message\":\"Error processing request: " + e.getMessage() + "\"}")
                    .build();
        }
    }








    @DELETE
    @Path("/{idMemory}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteMemory(@PathParam("type") String type, @PathParam("id") String id, @PathParam("idMemory") String idMemory) {
        // Validate the entity type
        if (!isEntityValid(type, id)) {
            return Response.status(Response.Status.UNAUTHORIZED)
                    .entity("{\"message\":\"Invalid " + type + " ID!\"}")
                    .build();
        }

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Soft delete the memory by setting bDelete to TRUE
            String sql = "UPDATE memorymodel SET bDelete = TRUE WHERE idMemory = ? AND bDelete = FALSE";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, idMemory);

                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    return Response.status(Response.Status.OK)
                            .entity("{\"message\":\"Memory deleted successfully!\"}")
                            .build();
                } else {
                    return Response.status(Response.Status.NOT_FOUND)
                            .entity("{\"message\":\"Memory not found or already deleted!\"}")
                            .build();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"message\":\"Database error: " + e.getMessage() + "\"}")
                    .build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("{\"message\":\"Error processing request: " + e.getMessage() + "\"}")
                    .build();
        }
    }


    private List<Map<String, Object>> getAllMemories() throws Exception {
        List<Map<String, Object>> memoryList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT mm.idMemory, mm.title, mm.publicationDate, mm.views, mm.image, mm.description, mm.place, mm.hashtag, mm.tag, mm.share, " +
                    "mm.idOrder, mm.idUser, mm.category, mc.name AS categoryName, s.name AS shareType " +
                    "FROM MemoryModel mm " +
                    "JOIN MEMORYCATEGORY mc ON mm.category = mc.id " +
                    "JOIN SHARE s ON mm.share = s.id";
            try (PreparedStatement memoryStatement = connection.prepareStatement(sql);
                 ResultSet memoryResult = memoryStatement.executeQuery()) {

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
                    memoryList.add(memory);
                }
            }
        } catch (Exception e) {
            System.err.println("Error retrieving memories: " + e.getMessage());
            throw e;
        }

        return memoryList;
    }

    private Map<String, Object> getMemoryByIdData(String idMemory) throws Exception {
        Map<String, Object> memory = new HashMap<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT mm.idMemory, mm.title, mm.publicationDate, mm.views, mm.image, mm.description, mm.place, mm.hashtag, mm.tag, mm.share, " +
                    "mm.idOrder, mm.idUser, mm.category, mc.name AS categoryName, s.name AS shareType " +
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
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Error retrieving memory by ID: " + e.getMessage());
            throw e;
        }

        return memory;
    }

    private void openImagesInBrowser(String imageUrls) {
        try {
            if (Desktop.isDesktopSupported()) {
                Desktop desktop = Desktop.getDesktop();
                String[] urls = imageUrls.split("<separationlienimage>");
                for (String url : urls) {
                    if (!url.isEmpty()) {
                        desktop.browse(new URI(url));
                        System.out.println("Image opened in browser: " + url);
                    }
                }
            } else {
                System.out.println("Desktop is not supported on this machine.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}




