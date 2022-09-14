import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Ruler extends StatefulWidget {
  const Ruler({Key? key}) : super(key: key);

  @override
  State<Ruler> createState() => _RulerState();
}

class _RulerState extends State<Ruler> {
  double position = 0;
  String value = "0.00";

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height - 56 - statusBarHeight;
    double width = MediaQuery.of(context).size.width;
    double pd = 0;
    MediaQuery.of(context).devicePixelRatio;
    if (Platform.isAndroid) {
      pd = 5.95;
    } else if (Platform.isIOS) {
      pd = 6.299;
    } else {
      pd = 3.28;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Régua",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        titleSpacing: 0,
      ),
      body: Center(
        child: Stack(children: <Widget>[
          CustomPaint(
            size: Size(width, 400),
            painter: ScaleBackground(height, pd),
          ),
          CustomPaint(
            size: Size(height, width),
            painter: MeasureBar(height, width, position, value),
          ),
          GestureDetector(
            onVerticalDragUpdate: (pos) {
              setState(() {
                double y = pos.localPosition.dy;
                if (y > 0) {
                  position = pos.localPosition.dy;
                } else {
                  position = 0;
                }
                value = (position / 10 / pd).toStringAsFixed(2);
              });
            },
          ),
          Positioned(
            width: 100,
            bottom: 20,
            left: width / 2 - 50,
            child: ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(value);
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class ScaleBackground extends CustomPainter {
  //         <-- CustomPainter class

  double height, pd;

  ScaleBackground(this.height, this.pd);

  @override
  void paint(Canvas canvas, Size size) {
    //                                             <-- Insert your painting code here.
    for (double i = 0; i < height; i += 1) {
      double long;
      if (i % 10 == 0) {
        long = 60;
        final paragraphStyle = ParagraphStyle(textAlign: TextAlign.center);
        final textStyle = ui.TextStyle(color: Colors.black);
        final paragraphBuilder = ParagraphBuilder(paragraphStyle)
          ..pushStyle(textStyle)
          ..addText("${(i / 10).round()}");
        final paragraph = paragraphBuilder.build()
          ..layout(ParagraphConstraints(width: 30));
        canvas.drawParagraph(
            paragraph, Offset(long, i * pd - paragraph.height / 2));
      } else if ((i - 80) % 5 == 0) {
        long = 40;
      } else {
        long = 30;
      }
      final p1 = Offset(0, i * pd);
      final p2 = Offset(long, i * pd);
      final paint = Paint()
        ..color = Colors.black
        ..strokeWidth = 1;
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class MeasureBar extends CustomPainter {
  double height, width, position;
  String value;

  MeasureBar(this.height, this.width, this.position, this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(0, position);
    final p2 = Offset(size.width, position);
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);
    final paragraphStyle = ParagraphStyle(textAlign: TextAlign.center);
    final textStyle = ui.TextStyle(
        color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold);
    final paragraphBuilder = ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText("↕ Arraste para medir ↕\n$value");
    final paragraph = paragraphBuilder.build()
      ..layout(ParagraphConstraints(width: 220));
    canvas.drawParagraph(
        paragraph, Offset(width / 2 - paragraph.width / 2, position + 20));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}