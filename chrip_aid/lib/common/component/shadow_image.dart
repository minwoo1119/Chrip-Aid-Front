import 'dart:ui';
import 'package:flutter/material.dart';

class ImageShadow extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double sigma;
  final Color color;
  final Offset offset;

  const ImageShadow({
    super.key,
    required this.child,
    this.opacity = 0.3,
    this.sigma = 7,
    this.color = Colors.black,
    this.offset = const Offset(3, 7),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Transform.translate(
            offset: offset,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaY: sigma, sigmaX: sigma),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                child: Opacity(
                  opacity: opacity,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
