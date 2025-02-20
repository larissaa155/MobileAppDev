import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawingApp(),
    );
  }
}

class DrawingApp extends StatefulWidget {
  @override
  _DrawingAppState createState() => _DrawingAppState();
}

class _DrawingAppState extends State<DrawingApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emoji Drawing App')),
      body: Center(
        child: CustomPaint(
          painter: SmileyPainter(),
          size: Size(300, 300),
        ),
      ),
    );
  }
}

class SmileyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    paint.color = Colors.yellow;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 100, paint);

    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width / 2 - 35, size.height / 2 - 30), 10, paint);

    canvas.drawCircle(Offset(size.width / 2 + 35, size.height / 2 - 30), 10, paint);

    Paint smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    
    Rect mouthRect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2 + 30), radius: 40);
    canvas.drawArc(mouthRect, 0, 3.14, false, smilePaint); 
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _DrawingAppState extends State<DrawingApp> {
  String selectedEmoji = "smiley";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emoji Drawing App')),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedEmoji,
            items: [
              DropdownMenuItem(value: "smiley", child: Text("Smiley Face")),
              DropdownMenuItem(value: "party", child: Text("Party Face")),
              DropdownMenuItem(value: "heart", child: Text("Heart Emoji")),
            ],
            onChanged: (value) {
              setState(() {
                selectedEmoji = value!;
              });
            },
          ),
          Expanded(
            child: Center(
              child: CustomPaint(
                painter: EmojiPainter(selectedEmoji),
                size: Size(300, 300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmojiPainter extends CustomPainter {
  final String emojiType;

  EmojiPainter(this.emojiType);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    if (emojiType == "smiley") {
      
    } else if (emojiType == "party") {
      
      paint.color = Colors.purple;
      Path hat = Path()
        ..moveTo(size.width / 2, size.height / 2 - 100)
        ..lineTo(size.width / 2 - 50, size.height / 2)
        ..lineTo(size.width / 2 + 50, size.height / 2)
        ..close();
      canvas.drawPath(hat, paint);

      paint.color = Colors.red;
      canvas.drawCircle(Offset(size.width / 2 + 30, size.height / 2 - 50), 5, paint);
      canvas.drawCircle(Offset(size.width / 2 - 30, size.height / 2 - 70), 5, paint);
    } else if (emojiType == "heart") {
      paint.color = Colors.red;
      Path heart = Path()
        ..moveTo(size.width / 2, size.height / 2 + 30)
        ..cubicTo(size.width / 2 + 40, size.height / 2 - 50, size.width / 2 + 90, size.height / 2, size.width / 2, size.height / 2 + 100)
        ..cubicTo(size.width / 2 - 90, size.height / 2, size.width / 2 - 40, size.height / 2 - 50, size.width / 2, size.height / 2 + 30);
      canvas.drawPath(heart, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: CustomPaint(
          painter: EmojiPainter(selectedEmoji),
          size: Size(300, 300),
        ),
      ),
    ),
  );
}
