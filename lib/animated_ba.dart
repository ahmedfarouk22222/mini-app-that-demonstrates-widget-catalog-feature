import 'package:flutter/material.dart';

class AnimatedModalBarrierExample extends StatefulWidget {
  const AnimatedModalBarrierExample({super.key});

  @override
  State<AnimatedModalBarrierExample> createState() =>
      _AnimatedModalBarrierExampleState();
}

class _AnimatedModalBarrierExampleState
    extends State<AnimatedModalBarrierExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  bool _showBarrier = false;

  @override
  void initState() {
    super.initState();

    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.black54,
    ).animate(_controller);
  }

  void _toggleBarrier() {
    setState(() {
      _showBarrier = !_showBarrier;
      if (_showBarrier) {
        _controller.forward();
      } else {
        _controller.reverse();
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
      appBar: AppBar(title: const Text("AnimatedModalBarrier Example")),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _toggleBarrier,
              child: Text(_showBarrier ? "Hide Barrier" : "Show Barrier"),
            ),
          ),

          // Barrier overlay
          if (_showBarrier)
            AnimatedModalBarrier(
              color: Tween<Color?>(
                begin: Colors.transparent,
                end: Colors.black54,
              ).animate(_controller),
              dismissible: false,
              semanticsLabel: "Dismiss barrier",
              onDismiss: () {
                _toggleBarrier();
              },
            ),
        ],
      ),
    );
  }
}
