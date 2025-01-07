package fr.isen.projet.experience_management.interfaces.services;

import java.util.List;
import fr.isen.projet.experience_management.interfaces.models.MemoryModel;

//begin of modifiable zone(Javadoc).......C/484db2a0-3509-48d5-9ddf-84f8f17a5b91

//end of modifiable zone(Javadoc).........E/484db2a0-3509-48d5-9ddf-84f8f17a5b91
public interface MemoryService {
//begin of modifiable zone(Javadoc).......C/2ccb958a-9b6c-4bd9-b961-383c6cd9eb8b

//end of modifiable zone(Javadoc).........E/2ccb958a-9b6c-4bd9-b961-383c6cd9eb8b
    MemoryModel updateMemory(final MemoryModel newMemory);

//begin of modifiable zone(Javadoc).......C/8dd6a4ca-b1c1-4345-ae29-63976fcc7285

//end of modifiable zone(Javadoc).........E/8dd6a4ca-b1c1-4345-ae29-63976fcc7285
    List<MemoryModel> getAllMemory();

//begin of modifiable zone(Javadoc).......C/86db0378-25b4-4f93-803e-54e92691672c

//end of modifiable zone(Javadoc).........E/86db0378-25b4-4f93-803e-54e92691672c
    MemoryModel addMemory(final MemoryModel memory);

//begin of modifiable zone(Javadoc).......C/885d4349-0098-4b3c-8bc7-ef2a651968a0

//end of modifiable zone(Javadoc).........E/885d4349-0098-4b3c-8bc7-ef2a651968a0
    boolean removeMemory(final String memoryId);

//begin of modifiable zone(Javadoc).......C/833c1d4f-44c6-4f58-9322-6a6aef146c52

//end of modifiable zone(Javadoc).........E/833c1d4f-44c6-4f58-9322-6a6aef146c52
    MemoryModel getMemoryById(final int id);

}
