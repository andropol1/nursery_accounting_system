package Model;

import java.time.LocalDate;
import java.util.List;

public class Hamster extends Pet {
    public Hamster(int pet_id, String name, LocalDate birthdate, List<String> commands) {
        super(pet_id, name, birthdate, commands);
    }
}
