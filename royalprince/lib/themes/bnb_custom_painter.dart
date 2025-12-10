import 'package:flutter/material.dart';

class BNBCustomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Presisi tinggi dengan perhitungan matematis
    final double width = size.width;
    final double leftCurveStart = width * 0.20;
    final double leftCurveEnd = width * 0.35;
    final double leftFabEdge = width * 0.40;
    final double rightFabEdge = width * 0.60;
    final double rightCurveStart = width * 0.65;
    final double rightCurveEnd = width * 0.80;
    
    final double topHeight = 20.0;
    final double fabArcRadius = 15.0;
    
    final Paint paint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.black87, Colors.black],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromLTRB(0, 0, width, size.height));

    // Main path dengan presisi tinggi
    final Path path = Path()
      ..moveTo(0, topHeight)
      ..quadraticBezierTo(leftCurveStart, 0, leftCurveEnd, 0)
      ..quadraticBezierTo(leftFabEdge - 1.0, 0, leftFabEdge, topHeight)
      ..arcToPoint(
        Offset(rightFabEdge, topHeight),
        radius: Radius.circular(fabArcRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(rightFabEdge, 0, rightCurveStart, 0)
      ..quadraticBezierTo(rightCurveEnd, 0, width, topHeight)
      ..lineTo(width, size.height)
      ..lineTo(0, size.height)
      ..close();

    // Soft shadow dengan presisi
    canvas.drawShadow(
      path,
      Colors.black.withOpacity(0.5),
      10.0,
      true,
    );

    canvas.drawPath(path, paint);

    // Highlight line yang presisi
    final Paint highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.4
      ..strokeCap = StrokeCap.round;

    final Path highlightPath = Path()
      ..moveTo(0, topHeight)
      ..quadraticBezierTo(leftCurveStart, 0.5, leftCurveEnd, 0.5)
      ..quadraticBezierTo(leftFabEdge - 0.5, 0.5, leftFabEdge, topHeight * 0.8)
      ..arcToPoint(
        Offset(rightFabEdge, topHeight * 0.8),
        radius: Radius.circular(fabArcRadius - 0.5),
        clockwise: false,
      )
      ..quadraticBezierTo(rightFabEdge, 0.5, rightCurveStart, 0.5)
      ..quadraticBezierTo(rightCurveEnd, 0.5, width, topHeight);

    canvas.drawPath(highlightPath, highlightPaint);

    // Inner shadow untuk depth tambahan
    final Paint innerShadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2.0);

    final Path innerShadowPath = Path()
      ..moveTo(0, topHeight + 1)
      ..quadraticBezierTo(leftCurveStart, 1, leftCurveEnd, 1)
      ..quadraticBezierTo(leftFabEdge - 1.5, 1, leftFabEdge, topHeight + 1)
      ..arcToPoint(
        Offset(rightFabEdge, topHeight + 1),
        radius: Radius.circular(fabArcRadius - 1.0),
        clockwise: false,
      )
      ..quadraticBezierTo(rightFabEdge, 1, rightCurveStart, 1)
      ..quadraticBezierTo(rightCurveEnd, 1, width, topHeight + 1);

    canvas.drawPath(innerShadowPath, innerShadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}