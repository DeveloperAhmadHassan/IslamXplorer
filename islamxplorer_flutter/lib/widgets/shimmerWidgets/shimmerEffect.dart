import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget{
  const ShimmerEffect({
    required this.height,
    required this.width,
    this.radius = 15,
    this.color,
    super.key
  });

  final double height, width, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(radius)
          ),
        ),
        baseColor: Colors.grey.shade700,
        highlightColor: Colors.grey.shade500
    );
  }

}