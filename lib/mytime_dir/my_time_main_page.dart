import 'package:flutter/material.dart';

class MyTimePage extends StatefulWidget {
  const MyTimePage({super.key});

  @override
  State<MyTimePage> createState() => _MyTimePageState();
}

class _MyTimePageState extends State<MyTimePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Animation Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: _toggleAnimation,
                iconSize: 48.0,
              ),
            ),
            SizedBox(height: 20.0),
            ScaleTransition(
              scale: _animation,
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: _toggleAnimation,
                iconSize: 48.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
