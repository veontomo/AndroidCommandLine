package com.veontomo.cli;
import android.app.Activity;
import android.app.AlertDialog;
import android.os.Bundle;
import android.widget.Button;
import android.widget.Toast;
import java.util.Random;

public class MainActivity extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Button button = new Button(this);
        int number = (new Random()).nextInt(50);
        button.setText("Fibonacci: " + String.valueOf(number));

        button.setOnClickListener(v -> {
            int fib = fibonacci(1, 1, number);
            new AlertDialog.Builder(MainActivity.this)
                    .setTitle(getString(R.string.fibonacci))
                    .setMessage(getString(R.string.f) + number + " = " + fib)
                    .show();
        });
        
        setContentView(button);
    }

    private int fibonacci(int a, int b, int counter){
        if (counter <= 1) return a;
        return fibonacci(b, a + b, counter - 1);
    }
}