import 'package:border_shadow/border_shadow.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum BorderType { rounded, beveld, continuous, stadium }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BorderType borderType = BorderType.rounded;
  double brdRadius = 8.0;
  double blurRadius = 15.0;
  double spreadRadius = 0;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(brdRadius);
    final childBorder = {
      BorderType.rounded: RoundedRectangleBorder(borderRadius: borderRadius),
      BorderType.beveld: BeveledRectangleBorder(borderRadius: borderRadius),
      BorderType.continuous: ContinuousRectangleBorder(borderRadius: borderRadius),
      BorderType.stadium: const StadiumBorder(),
    }[borderType]!;

    final List<BoxShadow> boxShadow = [
      BoxShadow(
        color: Colors.blue,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      )
    ];

    final shape = OutlinedBorderShadow(
      boxShadow: boxShadow,
      child: childBorder,
    );

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape: shape,
        )),
        textButtonTheme: TextButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape: shape,
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: shape,
          ).copyWith(elevation: MaterialStateProperty.all(0)),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: shape,
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorderShadow(
            child: OutlineInputBorder(
              borderRadius: borderRadius,
            ),
            boxShadow: boxShadow,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Border Shadow demo")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                OutlinedButton(onPressed: () => setState(() => borderType = BorderType.rounded), child: const Text("Outlined / rounded")),
                const SizedBox(height: 32),
                TextButton(onPressed: () => setState(() => borderType = BorderType.beveld), child: const Text("Text / beveld")),
                const SizedBox(height: 32),
                ElevatedButton(onPressed: () => setState(() => borderType = BorderType.continuous), child: const Text("Elevated / continuous")),
                const SizedBox(height: 32),
                FloatingActionButton(
                    onPressed: () => setState(() => borderType = BorderType.stadium),
                    child: const Text(
                      "Float / stadium",
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(height: 32),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "Text Field",
                    errorText: "Error text",
                  ),
                ),
                const SizedBox(height: 32),
                Text("Border radius ${brdRadius.round()}"),
                Slider(
                  max: 50,
                  value: brdRadius,
                  onChanged: (value) => setState(() => brdRadius = value),
                ),
                const SizedBox(height: 16),
                Text("Blur radius ${brdRadius.round()}"),
                Slider(
                  max: 50,
                  value: blurRadius,
                  onChanged: (value) => setState(() => blurRadius = value),
                ),
                const SizedBox(height: 16),
                Text("Spread radius ${spreadRadius.round()}"),
                Slider(
                  max: 50,
                  value: spreadRadius,
                  onChanged: (value) => setState(() => spreadRadius = value),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
