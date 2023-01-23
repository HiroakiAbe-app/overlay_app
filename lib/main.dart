import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OverlayEntry? _entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('テキスト'),
            Builder(
              builder: (BuildContext context) => GestureDetector(
                onTap: () => onTap(context),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  child: const Text(
                    'context',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onTap(BuildContext context) {
    Offset targetOffset = Offset.zero;
    RenderObject? renderObject = context.findRenderObject();
    if (renderObject != null && renderObject is RenderBox) {
      targetOffset = renderObject.localToGlobal(Offset.zero);
    }
    final OverlayState? overlayState = Overlay.of(context);
    if (overlayState == null) return;
    _entry = OverlayEntry(
      builder: (context) => Positioned(
        width: 50,
        height: 50,
        left: targetOffset.dx,
        top: targetOffset.dy,
        child: GestureDetector(
          onTap: removeEntry,
          child: const ColoredBox(color: Colors.red),
        ),
      ),
    );
    overlayState.insert(_entry!);
  }

  void removeEntry() {
    if (_entry != null) {
      _entry!.remove();
      _entry = null;
    }
  }
}
