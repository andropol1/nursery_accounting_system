import Model.Registry;

import java.util.Scanner;

public class Menu {
    private Registry registry;
    private View view;

    public Menu(Registry registry, View view) {
        this.registry = registry;
        this.view = view;
    }
    public void start() throws Exception {
        Scanner scan = new Scanner(System.in);
        while (true) {
            System.out.println("""
                    0 - Выход
                    1 - Добавить животное
                    2 - Обучить животное команде
                    3 - Показать список животных
                    4 - Показать команды, которые умеет выполнять животное
                    5 - Показать количество животных
                    """);
            int select = scan.nextInt();
            switch (select) {
                case 0:
                    System.exit(0);
                    break;
                case 1:
                    System.out.println("""
                            Выберите вид нового животного (введите цифру): \n
                            1. Cat
                            2. Dog
                            3. Hamster
                            """);
                    int select_id = scan.nextInt();
                    registry.addAnimal(select_id);
                    break;
                case 2:
                    System.out.println("Выберите имя животного, которое хотите обучить:");
                    registry.showAnimals();
                    scan.nextLine();
                    String name = scan.nextLine();
                    for (int j = 0; j < registry.getAnimals().size(); j++) {
                        if (registry.getAnimals().get(j).getName().equals(name)) {
                            registry.getAnimals().get(j).addCommand(view.getCommands());
                            }
                        }
                    break;
                case 3:
                    registry.showAnimals();
                    break;
                case 4:
                    System.out.println("Выберите имя животного, команды которого хотите увидеть:");
                    registry.showAnimals();
                    scan.nextLine();
                    String input = scan.nextLine();
                    for (int i = 0; i < registry.getAnimals().size(); i++) {
                        if (registry.getAnimals().get(i).getName().equals(input)) {
                            for (String str :
                                    registry.getAnimals().get(i).getCommands()) {
                                System.out.println(str);
                            }
                    }

                    }
                    break;
                case 5:
                    System.out.println(Counter.count);
                    break;
            }
        }
    }
}
