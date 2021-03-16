# Flutter

> It's a brief introduction of flutter!

> ​	Flutter is Google’s UI toolkit for building beautiful, natively compiled applications for [mobile](https://flutter.dev/docs), [web](https://flutter.dev/web), and [desktop](https://flutter.dev/desktop) from a single codebase.

[TOC]

## Three Main Characteristic

### Fast Development

Paint your app to life in milliseconds with Stateful Hot Reload. Use a rich set of fully-customizable widgets to build native interfaces in minutes.

### Expressive and Flexible UI

Quickly ship features with a focus on native end-user experiences. Layered architecture allows for full customization, which results in incredibly fast rendering and expressive and flexible designs.

### Native Performance

Flutter’s widgets incorporate all critical platform differences such as scrolling, navigation, icons and fonts, and your Flutter code is compiled to native ARM machine code using [Dart's native compilers](https://dart.dev/platforms).

## Try Flutter in your browser

#### Counter

> The counter project can record your clicks.When you click it once, the number will add one.

```dart
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  double val = 0;

  void change() {
    setState(() {
      val += 1;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('$val'))),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () => change(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Container(
          child: Counter(),
        ),
      ),
    );
  }
}

Future<void> main() async {
  runApp(MyApp());
}
```

<img src="../../assets/Lab1/flutter/flutter_test_demo.png" style="float:left">flutter_test_demo</img>

> You can try more practice in [Official Website](https://flutter.dev/codelabs).

## Fast development

Flutter's *hot reload* helps you quickly and easily experiment, build UIs, add features, and fix bugs faster. Experience sub-second reload times without losing state on emulators, simulators, and hardware.

## Expressive, beautiful UIs

Delight your users with Flutter's built-in beautiful Material Design and Cupertino (iOS-flavor) widgets, rich motion APIs, smooth natural scrolling, and platform awareness.

> You can get an award winning mindfulness app built with Flutter.
>
> Download: [iOS](https://itunes.apple.com/us/app/reflectly-mindfulness-journal/id1241229134), [Android](https://play.google.com/store/apps/details?id=com.reflectlyApp&e=-EnableAppDetailsPageRedesign)
> [Learn more](https://reflect.ly/)

## Native Performance

Flutter’s widgets incorporate all critical platform differences such as scrolling, navigation, icons and fonts to provide full native performance on both iOS and Android.

> [More examples](https://flutter.dev/showcase)