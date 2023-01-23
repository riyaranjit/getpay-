import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final Widget child;
  final bool enable;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final Color baseColor;
  final Color highlightColor;

  CustomShimmer(
      {this.child,
        this.enable = false,
        this.width,
        this.height = 1,
        this.baseColor,
        this.highlightColor,
        this.padding = const EdgeInsets.all(0)})
      : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return this.enable
        ? Shimmer.fromColors(
        enabled: true,
        baseColor: baseColor!=null? baseColor :  Colors.grey[300],
        highlightColor: highlightColor!=null? highlightColor :  Colors.grey[100],
        child: width != null
            ? Container(
          margin: padding,
          width: width,
          height: height,
          color: Colors.white,
        )
            : child)
        : child;
  }
}