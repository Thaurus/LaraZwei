import 'package:flutter/material.dart';

class ShakeAnimator extends StatefulWidget {
  final Widget child;
  final AnimationController controller;
  final double offset;
  const ShakeAnimator({required this.controller, required this.child, this.offset = 25, super.key});

  @override
  State<ShakeAnimator> createState() => _ShakeAnimatorState();
}

class _ShakeAnimatorState extends State<ShakeAnimator> {
  late Animation<double> offsetAnimation; 

  @override
  void initState() {
    super.initState();
    offsetAnimation = Tween(begin: 0.0, end: widget.offset).chain(CurveTween(curve: Curves.elasticIn)).animate(widget.controller)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: offsetAnimation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.only(left: offsetAnimation.value + widget.offset, right: widget.offset - offsetAnimation.value),
          margin: const EdgeInsets.all(5),
          child: widget.child
        );
      }
    );
  }
}