import java.util.ArrayList;
import java.util.List;

public class Registry {
    private List<Pet> animals;

    public Registry(List<Pet> animals) {
        this.animals = animals;
    }
    public Registry() {
        this(new ArrayList<>());
    }
    public void addAnimal(Pet pet){
        animals.add(pet);
    }

    public List<Pet> getAnimals() {
        return animals;
    }

}

