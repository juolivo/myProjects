package shufflearrays;
import acm.program.*;

public class ShuffleArrays extends ConsoleProgram {
    
    private static final int SIZE = 4;
    
    private void printArray(int[] array) {
        print("< ");
        for (int i=0; i<array.length; i++) print(array[i] + " ");
        println(">");
    }
    
    
    private static int[] shuffleArrays(int[] array1, int[] array2) {
        int n = array1.length;
        int[] result = new int[2*n];
        for (int i=0; i<n; i++) {
            result[2*i] = array1[i];
            result[2*i+1] = array2[i];
        }
        return result;
    }

    
    public void run() {
        int[] array1 = new int[SIZE];
        for (int i=0; i<SIZE; i++) array1[i] = i + 10;
        int[] array2 = new int[SIZE];
        for (int i=0; i<SIZE; i++) array2[i] = i + 20;        
        print("Initial Array 1: ");
        printArray(array1);
        print("Initial Array 2: ");
        printArray(array2);   
        print("Shuffled Array: ");
        printArray(shuffleArrays(array1,array2));
    }
    
    
    public static void main(String[] args) {
        new ShuffleArrays().start();
    }
    
}
