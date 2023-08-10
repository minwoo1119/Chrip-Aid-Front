import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:flutter/material.dart';

class CustomSpeechBalloon extends StatelessWidget {
  final Widget child;

  const CustomSpeechBalloon({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SpeechBalloonPainter(),
      child: child,
    );
  }
}

class _SpeechBalloonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..color = CustomColor.mainColor
      ..strokeWidth = kLineMiddleSize
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint backgroundPaint = Paint()
      ..color = CustomColor.backGroundSubColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final Paint removePaint = Paint()
      ..color = CustomColor.backGroundSubColor
      ..strokeWidth = kLineMiddleSize
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final double width = size.width;
    final double height = size.height;

    final double nipWidth = width * 0.08 < 29 ? 29 : width * 0.08;
    final double nipHeight = height * 0.18 < 36 ? 36 : height * 0.18;

    final double triangleWOffset = width / 1.2;

    const Color shadowColor = Colors.black;
    const double elevation = 7.0;

    final BorderRadius borderRadius = BorderRadius.circular(kBorderRadiusSize);
    final Rect rect = Rect.fromLTRB(0, 0, width, height);
    final RRect balloon = borderRadius.toRRect(rect);
    final Path balloonPath = Path()..addRRect(balloon);

    final Path removePath = Path()
      ..moveTo(triangleWOffset - nipWidth / 2 - 5, height - 0.1)
      ..lineTo(triangleWOffset + nipWidth / 2 + 5, height - 0.1);

    final Path nipPath = Path()
      ..moveTo(triangleWOffset - nipWidth / 2 - 5, height)
      ..quadraticBezierTo(
        triangleWOffset - nipWidth / 2 + 1,
        height,
        triangleWOffset - nipWidth / 2 + 5,
        height + 2,
      )
      ..quadraticBezierTo(
        triangleWOffset,
        nipHeight / 2 + height - 10,
        triangleWOffset - nipWidth / 2 + 7,
        nipHeight + height,
      )
      ..lineTo(triangleWOffset + nipWidth / 2, height + 2)
      ..quadraticBezierTo(
        triangleWOffset + nipWidth / 2 + 2,
        height,
        triangleWOffset + nipWidth / 2 + 5,
        height,
      );

    canvas.drawShadow(balloonPath, shadowColor, elevation, false);
    canvas.drawShadow(nipPath, shadowColor, elevation, false);
    canvas.drawPath(balloonPath, backgroundPaint);
    canvas.drawPath(balloonPath, borderPaint);
    canvas.drawPath(removePath, removePaint);
    canvas.drawPath(nipPath, backgroundPaint);
    canvas.drawPath(nipPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
