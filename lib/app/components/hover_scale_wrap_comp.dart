import 'package:flutter/material.dart';

class HoverScaleWrapper extends StatefulWidget {
  final Widget child;
  final double scale;
  final Duration duration;
  final VoidCallback? onTap;

  const HoverScaleWrapper({
    super.key,
    required this.child,
    this.scale = 1.1,
    this.duration = const Duration(milliseconds: 200),
    this.onTap,
  });

  @override
  State<HoverScaleWrapper> createState() => _HoverScaleWrapperState();
}

class _HoverScaleWrapperState extends State<HoverScaleWrapper> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedScale(
        scale: _isHovering ? widget.scale : 1.0,
        duration: widget.duration,
        child: GestureDetector(
          onTap: widget.onTap,
          child: widget.child,
        ),
      ),
    );
  }
}
