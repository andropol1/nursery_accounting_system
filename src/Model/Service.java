import java.util.List;

public class Service {
    private Registry registry;

    public Service(Registry registry) {
        this.registry = registry;
    }

    public void addAnimal(int pet_id) throws Exception {
        try(Counter counter = new Counter()) {
            counter.add();
        }finally{
            switch(pet_id){
                case 1:
                    registry.addAnimal(new Cat(pet_id, view.getName(), view.getDate(), view.getCommands()));
                    break;
                case 2:
                    registry.addAnimal(new Dog(pet_id, view.getName(), view.getDate(), view.getCommands()));
                    break;
                case 3:
                    registry.addAnimal(new Hamster(pet_id, view.getName(), view.getDate(), view.getCommands()));
                    break;
            }

        }

    }
    public void showAnimals(){
        for (int i = 0; i < registry.getAnimals().size(); i++) {
            System.out.printf("%s. %s\n", (i+1), registry.getAnimals().get(i));
        }
    }
}
