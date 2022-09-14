import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class MathFunctionDesigner extends StatefulWidget {
  const MathFunctionDesigner({Key? key}) : super(key: key);

  @override
  State<MathFunctionDesigner> createState() => _MathFunctionDesignerState();
}

class _MathFunctionDesignerState extends State<MathFunctionDesigner> {
  late Color Function(double x, double y) _withColorFunction;

  @override
  void initState() {
    super.initState();
    _withColorFunction = _whiteNoiseFunction;
  }

  Color _whiteNoiseFunction(double _, double __) {
    return Color(0xff000000 + Random.secure().nextInt(0xffffff));
  }

  Color _whiteNoiseBlackAndWhiteFunction(double _, double __) {
    final component = Random.secure().nextInt(0xff);
    return Color.fromARGB(0xff, component, component, component);
  }

  Color _colorFromX(double x, double _) {
    return Color(0xff000000 + (x * x).toInt() * 10);
  }

  Color _colorFromY(double _, double y) {
    return Color(0xff000000 + (y * y).toInt() * 10);
  }

  Color _colorFromXPlusY(double x, double y) {
    return Color(0xff000000 + (x + y).toInt() * 10);
  }

  Color _colorFromXTimesY(double x, double y) {
    return Color(0xff000000 + (x * y).toInt() * 10);
  }

  Color _colorFromXRedYBlue(double x, double y) {
    return Color.fromARGB(0xff, x.toInt(), y.toInt(), 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Imagens matemáticas')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: LayoutBuilder(
                    builder: (_, constraints) => SizedBox(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: CustomPaint(
                        size: constraints.biggest,
                        painter: VideoFramePainter(
                          generateColor: _withColorFunction,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 16/9,
              children: [
                ListTile(
                  title: const Text('Ruido branco'),
                  subtitle:
                      const Text('Cor de cada pixel gerada randomicamente'),
                  onTap: () => setState(() => _withColorFunction = _whiteNoiseFunction),
                  dense: true,
                  selected: _withColorFunction == _whiteNoiseFunction,
                ),
                ListTile(
                  title: const Text('Ruido branco BW'),
                  subtitle: const Text(
                      'Preto e branco com intensidade de cada pixel gerada randomicamente'),
                  onTap: () => setState(() => _withColorFunction = _whiteNoiseBlackAndWhiteFunction),
                  dense: true,
                  selected: _withColorFunction == _whiteNoiseBlackAndWhiteFunction,
                ),
                ListTile(
                  title: const Text('f(x) = x * x'),
                  subtitle: const Text(
                      'Cor de cada pixel gerada em função da posição x do offset'),
                  onTap: () => setState(() => _withColorFunction = _colorFromX),
                  dense: true,
                  selected: _withColorFunction == _colorFromX,
                ),
                ListTile(
                  title: const Text('f(y) = y * y'),
                  subtitle: const Text(
                      'Cor de cada pixel gerada em função da posição y do offset'),
                  onTap: () => setState(() => _withColorFunction = _colorFromY),
                  dense: true,
                  selected: _withColorFunction == _colorFromY,
                ),
                ListTile(
                  title: const Text('f(x, y) = x + y'),
                  subtitle: const Text(
                      'Cor de cada pixel gerada em função da posição x e y do offset'),
                  onTap: () => setState(() => _withColorFunction = _colorFromXPlusY),
                  dense: true,
                  selected: _withColorFunction == _colorFromXPlusY,
                ),
                ListTile(
                  title: const Text('f(x, y) = x * y'),
                  subtitle: const Text(
                      'Cor de cada pixel gerada em função da posição x e y do offset'),
                  onTap: () => setState(() => _withColorFunction = _colorFromXTimesY),
                  dense: true,
                  selected: _withColorFunction == _colorFromXTimesY,
                ),
                ListTile(
                  title: const Text('f(x, y) = x is Red, y is Blue'),
                  subtitle: const Text(
                      'Cor de cada pixel gerada em função da posição x e y do offset'),
                  onTap: () => setState(() => _withColorFunction = _colorFromXRedYBlue),
                  dense: true,
                  selected: _withColorFunction == _colorFromXRedYBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoFramePainter extends CustomPainter {
  Color Function(double x, double y) generateColor;

  VideoFramePainter({required this.generateColor});

  @override
  void paint(Canvas canvas, Size size) {
    for (double y = 0; y < size.height; y++) {
      for (double x = 0; x < size.width; x++) {
        canvas.drawPoints(
          PointMode.points,
          [Offset(x, y)],
          Paint()..color = generateColor(x, y),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
