import 'package:custom_painter_showcase/math_function_designer/math_function_designer.dart';
import 'package:custom_painter_showcase/ruler/ruler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cutom painter usecases'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: const Text('Régua'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const Ruler(),
                ),
              ),
            ),
            ListTile(
              title: const Text('Imagens matemáticas'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const MathFunctionDesigner(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
