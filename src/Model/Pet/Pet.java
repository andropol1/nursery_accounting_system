package Model;

import java.time.LocalDate;
import java.util.List;

public abstract class Pet {
    private final int pet_id;
    private final String name;
    private final LocalDate birthdate;
    private List<String> commands;


    public Pet(int pet_id, String name, LocalDate birthdate, List<String> commands) {
        this.pet_id = pet_id;
        this.name = name;
        this.birthdate = birthdate;
        this.commands = commands;
    }


    public void addCommand(List<String> input){
        commands.addAll(input);
    }

    public String getName() {
        return name;
    }


    public List<String> getCommands() {
        return commands;
    }

    @Override
    public String toString() {
        return "pet_id=" + pet_id +
                ", name='" + name + '\'' +
                ", birthdate=" + birthdate +
                ", commands=" + commands;
    }
}
