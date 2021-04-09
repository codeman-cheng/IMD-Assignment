# HelloToast
> a test project for layout 

- [HelloToast](#hellotoast)
  - [Screenshot](#screenshot)
    - [Program ScreenShot](#program-screenshot)
    - [Layout ScreenShot](#layout-screenshot)
    - [Runtime ScreenShot](#runtime-screenshot)
  - [Video](#video)
  - [Code](#code)
    - [MainActivity.java](#mainactivityjava)
    - [layout/activity_main.xml](#layoutactivity_mainxml)
    - [land/activity_main.xml](#landactivity_mainxml)
    - [colors.xml](#colorsxml)
    - [string.xml](#stringxml)
## Screenshot
### Program ScreenShot
![programShot](../../assets/Lab3/programShot.png)
### Layout ScreenShot
- Layout
  ![LayoutShot](../../assets/Lab3/layoutShot.png)
- Land
  ![LandShot](../../assets/Lab3/landShot.png)
### Runtime ScreenShot
- ![Runtime1](../../assets/Lab3/runtime_1.png)

- ![Runtime2](../../assets/Lab3/runtime_2.png)
  
- ![Runtime3](../../assets/Lab3/runtime_3.png)
  
- ![Runtime4](../../assets/Lab3/runtime_4.png)

## Video
[视频链接](../../assets/Lab3/lab3.mp4)

## Code
### MainActivity.java
```java
package com.example.hellotoast;

import androidx.appcompat.app.AppCompatActivity;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    private int mCount = 0;
    private TextView mShowCount;
    private Button zero;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (null != savedInstanceState) {
            int intType = savedInstanceState.getInt("intType");
        }
        setContentView(R.layout.activity_main);
        mShowCount = (TextView) findViewById(R.id.show_count);
        zero = (Button) findViewById(R.id.zero);
    }


    @Override
    protected void onRestoreInstanceState(Bundle savedInstanceState) {
        super.onRestoreInstanceState(savedInstanceState);
        // 取出保存的count数据
        int intType = savedInstanceState.getInt("intType");
        mCount = intType;
        // 重新调整颜色以及数据
        zero.setBackgroundColor(Color.BLUE);
        if (mShowCount != null)
            if(mCount % 2 != 0) {
                mShowCount.setBackgroundColor(Color.MAGENTA );
                mShowCount.setTextColor(Color.WHITE);
            }
            else {
                mShowCount.setBackgroundColor(Color.YELLOW);
                mShowCount.setTextColor(Color.BLUE);
            }
        mShowCount.setText(Integer.toString(mCount));
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        // 保存count数据
        outState.putInt("intType", mCount);
    }

    public void showToast(View view) {
        Toast toast = Toast.makeText(this, R.string.toast_message,
                Toast.LENGTH_SHORT);
        toast.show();
    }

    public void countUp(View view) {
        ++mCount;
        zero.setBackgroundColor(Color.BLUE);
        if (mShowCount != null)
            if(mCount % 2 != 0) {
                mShowCount.setBackgroundColor(Color.MAGENTA );
                mShowCount.setTextColor(Color.WHITE);
            }
            else {
                mShowCount.setBackgroundColor(Color.YELLOW);
                mShowCount.setTextColor(Color.BLUE);
            }
            mShowCount.setText(Integer.toString(mCount));
    }

    public void countZero(View view) {
        mCount = 0;
        zero.setBackgroundColor(Color.GRAY);
        mShowCount.setBackgroundColor(Color.YELLOW);
        mShowCount.setTextColor(Color.BLUE);
        if (mShowCount != null)
            mShowCount.setText(Integer.toString(mCount));
    }
}
```

### layout/activity_main.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/Toast"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <Button
        android:id="@+id/zero"
        style="@style/Widget.AppCompat.Button"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_marginStart="10dp"
        android:layout_marginLeft="10dp"
        android:background="#888888"
        android:onClick="countZero"
        android:text="@string/zero"
        android:textColor="@color/white"
        app:backgroundTint="#888888"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toStartOf="@+id/Count"
        app:layout_constraintStart_toStartOf="parent" />

    <Button
        android:id="@+id/Count"
        style="@style/Widget.AppCompat.Button"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_marginStart="10dp"
        android:layout_marginLeft="10dp"
        android:layout_marginEnd="10dp"
        android:layout_marginRight="10dp"
        android:background="#0000FF"
        android:onClick="countUp"
        android:text="@string/count"
        android:textColor="@color/white"
        app:backgroundTint="#0000FF"
        app:layout_constraintBaseline_toBaselineOf="@+id/zero"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toEndOf="@+id/zero" />

    <TextView
        android:id="@+id/show_count"
        android:layout_width="0dp"
        android:layout_height="0dp"
        android:layout_marginStart="10dp"
        android:layout_marginLeft="10dp"
        android:layout_marginEnd="10dp"
        android:layout_marginRight="10dp"
        android:background="#FFFF00"
        android:gravity="center"
        android:text="@string/show_count"
        android:textAlignment="center"
        android:textAllCaps="true"
        android:textColor="#0000FF"
        android:textIsSelectable="false"
        android:textSize="160sp"
        android:textStyle="bold"
        app:layout_constraintBottom_toTopOf="@+id/zero"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintHorizontal_bias="0.0"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/toast"
        app:layout_constraintVertical_bias="1.0" />

    <androidx.constraintlayout.widget.Group
        android:id="@+id/group"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content" />

    <Button
        android:id="@+id/toast"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_marginStart="10dp"
        android:layout_marginLeft="10dp"
        android:layout_marginEnd="10dp"
        android:layout_marginRight="10dp"
        android:background="#0000FF"
        android:onClick="showToast"
        android:text="@string/toast"
        app:backgroundTint="#0000FF"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintHorizontal_bias="1.0"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

### land/activity_main.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/Toast"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <Button
        android:id="@+id/zero"
        style="@style/Widget.AppCompat.Button"
        android:layout_width="wrap_content"
        android:layout_height="44dp"
        android:layout_marginTop="70dp"
        android:background="#888888"
        android:onClick="countZero"
        android:text="@string/zero"
        android:textColor="@color/white"
        app:backgroundTint="#888888"
        app:layout_constraintStart_toStartOf="@+id/toast"
        app:layout_constraintTop_toBottomOf="@+id/toast" />

    <Button
        android:id="@+id/Count"
        style="@style/Widget.AppCompat.Button"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="70dp"
        android:background="#1736E1"
        android:onClick="countUp"
        android:text="@string/count"
        android:textColor="@color/white"
        app:backgroundTint="#1736E1"
        app:layout_constraintStart_toStartOf="@+id/zero"
        app:layout_constraintTop_toBottomOf="@+id/zero" />

    <TextView
        android:id="@+id/show_count"
        android:layout_width="0dp"
        android:layout_height="0dp"
        android:layout_marginStart="10dp"
        android:layout_marginLeft="10dp"
        android:layout_marginTop="10dp"
        android:layout_marginEnd="10dp"
        android:layout_marginRight="10dp"
        android:layout_marginBottom="10dp"
        android:background="#FFFF00"
        android:gravity="center"
        android:text="@string/show_count"
        android:textAlignment="center"
        android:textAllCaps="true"
        android:textColor="#3F51B5"
        android:textIsSelectable="false"
        android:textSize="160sp"
        android:textStyle="bold"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toEndOf="@+id/Count"
        app:layout_constraintTop_toTopOf="parent" />

    <Button
        android:id="@+id/toast"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginStart="10dp"
        android:layout_marginLeft="10dp"
        android:layout_marginTop="10dp"
        android:background="#1736E1"
        android:onClick="showToast"
        android:text="@string/toast"
        app:backgroundTint="#1736E1"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

### colors.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="purple_200">#FFBB86FC</color>
    <color name="purple_500">#FF6200EE</color>
    <color name="purple_700">#FF3700B3</color>
    <color name="teal_200">#FF03DAC5</color>
    <color name="teal_700">#FF018786</color>
    <color name="black">#FF000000</color>
    <color name="white">#FFFFFFFF</color>
    <color name="blue">#FF0000FF</color>
</resources>
```

### string.xml
```xml
<resources>
    <string name="app_name">Hello Toast`</string>
    <string name="toast">TOAST</string>
    <string name="count">COUNT</string>
    <string name="show_count">0</string>
    <string name="toast_message">Hello Toast!</string>
    <string name="zero">ZERO</string>
</resources>
```