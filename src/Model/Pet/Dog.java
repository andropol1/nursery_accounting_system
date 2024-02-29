package Model;

import java.time.LocalDate;
import java.util.List;

public class Dog extends Pet {
    public Dog(int pet_id, String name, LocalDate birthdate, List<String> commands) {
        super(pet_id, name, birthdate, commands);
    }
}
