public class Counter implements AutoCloseable {
    static int count;

    public void add(){
        count++;
    }

    @Override
    public void close() {

    }

}
