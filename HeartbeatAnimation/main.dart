import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart Animation',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HeartPage(),
    );
  }
}

class HeartPage extends StatefulWidget {
  @override
  _HeartPageState createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final List<Confetti> confetti = [];
  final int numberOfConfetti = 50;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController with standard bounds
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    // Create a Tween to handle the scaling range
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Initialize confetti
    for (int i = 0; i < numberOfConfetti; i++) {
      confetti.add(Confetti());
    }

    // Start the confetti animation
    animateConfetti();
  }

  void animateConfetti() {
    Future.delayed(Duration(milliseconds: 50), () {
      if (mounted) {
        // Check if widget is still mounted
        setState(() {
          for (var particle in confetti) {
            particle.updatePosition();
            if (particle.y > MediaQuery.of(context).size.height) {
              particle.resetPosition();
            }
          }
        });
        animateConfetti();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Animation'),
      ),
      body: Stack(
        children: [
          // Confetti layer
          CustomPaint(
            painter: ConfettiPainter(confetti),
            size: Size.infinite,
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Happy Valentine\'s Day',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                SizedBox(height: 20),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset('lib/assets/heart.png',
                      width: 200, height: 200),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Confetti {
  double x = 0;
  double y = 0;
  double speed = 0;
  double angle = 0;
  Color color = Colors.pink; // Initialize with a default color
  double size = 0;

  static final math.Random random = math.Random();
  static final List<Color> colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
  ];

  Confetti() {
    resetPosition();
  }

  void resetPosition() {
    x = random.nextDouble() * 400;
    y = -random.nextDouble() * 400;
    speed = 1 + random.nextDouble() * 4;
    angle = random.nextDouble() * 2 * math.pi;
    color = colors[random.nextInt(colors.length)];
    size = 5 + random.nextDouble() * 5;
  }

  void updatePosition() {
    y += speed;
    x += math.sin(angle) * 2;
    angle += 0.1;
  }
}

class ConfettiPainter extends CustomPainter {
  final List<Confetti> confetti;

  ConfettiPainter(this.confetti);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (var particle in confetti) {
      paint.color = particle.color;
      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
