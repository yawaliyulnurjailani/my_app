import 'dart:math';

import 'package:flutter/material.dart';

class RotatingContainerComp extends StatefulWidget {
  final double width;
  final double height;
  final Color color;
  final Widget? child;

  const RotatingContainerComp({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    this.child,
  });

  @override
  State<RotatingContainerComp> createState() => _RotatingContainerCompState();
}

class _RotatingContainerCompState extends State<RotatingContainerComp>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
