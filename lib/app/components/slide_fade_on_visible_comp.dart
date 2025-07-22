import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SlideFadeOnVisibleComp extends StatefulWidget {
  const SlideFadeOnVisibleComp({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 3000),
    this.curve = Curves.easeOut,
    this.offsetX = 300.0,
    this.visibleFraction = 0.2,
    this.enableReverse = false, // Tambahan opsional jika ingin reverse
  });

  final Widget child;
  final Duration duration;
  final Curve curve;
  final double offsetX;
  final double visibleFraction;
  final bool enableReverse;

  @override
  State<SlideFadeOnVisibleComp> createState() => _SlideFadeOnVisibleCompState();
}

class _SlideFadeOnVisibleCompState extends State<SlideFadeOnVisibleComp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _offsetAnimation = Tween<Offset>(
      begin: Offset(widget.offsetX / 500, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerAnimation(bool visible) {
    if (!mounted) return;

    if (visible && !_hasAnimated) {
      _controller.forward();
      _hasAnimated = true;
    } else if (!visible && _hasAnimated && widget.enableReverse) {
      _controller.reverse();
      _hasAnimated = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(), // agar visibility terdeteksi ulang setiap build
      onVisibilityChanged: (info) {
        _triggerAnimation(info.visibleFraction >= widget.visibleFraction);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.translate(
              offset: _offsetAnimation.value * 500,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
