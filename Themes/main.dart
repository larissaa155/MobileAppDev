import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
  );

  ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
  );

  bool _isDark = false;

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDark = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDark ? _darkTheme : _lightTheme,
      home: ThemeDemo(toggleTheme: _toggleTheme, isDark: _isDark),
    );
  }
}

class ThemeDemo extends StatelessWidget {
  final Function(bool) toggleTheme;
  final bool isDark;

  const ThemeDemo({super.key, required this.toggleTheme, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Theme Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Choose the Theme:", style: TextStyle(fontSize: 22,),),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => toggleTheme(false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade100,
                  ),
                  child: const Text("Light Theme", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () => toggleTheme(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade200,
                  ),
                  child: const Text("Dark Theme", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  "Mobile App Development Testing",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
