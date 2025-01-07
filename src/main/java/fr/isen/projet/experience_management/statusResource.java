package fr.isen.projet.experience_management;
//Mettez le nom et le chemin de votre dossier
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;

@Path("/status")
public class statusResource {
    @Inject
    DataSource dataSource; // Injection de la DataSource

    @GET
    public String getStatus() throws JsonProcessingException {
        String state = "OK"; // État OK par défaut
        String version = "1.0";
        int count = 0; // Initialisation du compteur des lignes

        // Requête SQL pour compter les lignes dans une table
        String query = "SELECT COUNT(*) AS row_count FROM MemoryCategory"; // Remplace 'utilisateurs' par le nom de ta table

        try (Connection connection = dataSource.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt("row_count"); // Récupération du résultat de la requête
            }

        } catch (Exception e) {
            e.printStackTrace();
            state = "KO"; // Si une erreur se produit, on retourne l'état KO
        }

        Map<String, Object> statusResponse = new HashMap<>();
        statusResponse.put("state", state);
        statusResponse.put("count", count);
        statusResponse.put("version", version);

        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(statusResponse);
    }

}
