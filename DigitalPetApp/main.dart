import 'package:flutter/material.dart';

void main() {
  runApp(DigitalPetApp());
}

class DigitalPetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PetHome(),
    );
  }
}

class PetHome extends StatefulWidget {
  @override
  _PetHomeState createState() => _PetHomeState();
}

class _PetHomeState extends State<PetHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int happiness = 50;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void increaseHappiness() {
    setState(() {
      if (happiness < 100) happiness += 10;
    });
  }

  void decreaseHappiness() {
    setState(() {
      if (happiness > 0) happiness -= 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.pets), text: "Pet"),
            Tab(icon: Icon(Icons.fastfood), text: "Feed"),
            Tab(icon: Icon(Icons.sports_soccer), text: "Play"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.pets, size: 100),
                Text("Happiness: $happiness", style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: increaseHappiness,
              child: Text("Feed Pet"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: decreaseHappiness,
              child: Text("Play with Pet"),
            ),
          ),
        ],
      ),
    );
  }
}
