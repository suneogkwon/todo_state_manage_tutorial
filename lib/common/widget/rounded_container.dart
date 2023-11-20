import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.radiusValue = 10,
    this.radius,
  });

  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double radiusValue;
  final BorderRadiusGeometry? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius ?? BorderRadius.circular(radiusValue),
      ),
      child: child,
    );
  }
}
