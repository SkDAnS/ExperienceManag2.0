package fr.isen.projet.experience_management.interfaces.services;

import java.util.List;
import fr.isen.projet.experience_management.interfaces.models.MemoryModel;

public interface MemoryService {
    MemoryModel updateMemory(final MemoryModel newMemory);

    List<MemoryModel> getAllMemory();

    MemoryModel addMemory(final MemoryModel memory);

    boolean removeMemory(final String memoryId);

    MemoryModel getMemoryById(final String id);

}
