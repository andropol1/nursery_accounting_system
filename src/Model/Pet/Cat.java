package Model;

import java.time.LocalDate;
import java.util.List;

public class Cat extends Pet {
    public Cat(int pet_id, String name, LocalDate birthdate, List<String> commands) {
        super(pet_id, name, birthdate, commands);
    }
}
