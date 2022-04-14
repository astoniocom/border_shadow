import 'package:flutter/painting.dart';

mixin ShadowsPainter on ShapeBorder {
  ShapeBorder get child;
  List<BoxShadow> get boxShadow;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => child.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => child.getOuterPath(rect, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get dimensions => child.dimensions;

  void paintShadow(Canvas canvas, Rect rect) {
    final clipPath = Path()
      ..addRect(const Rect.fromLTWH(-2500, -2500, 5000, 5000))
      ..addPath(getInnerPath(rect), Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.clipPath(clipPath);

    for (final BoxShadow boxShadow in boxShadow) {
      final Paint paint = boxShadow.toPaint();
      final Rect bounds = rect.shift(boxShadow.offset).inflate(boxShadow.spreadRadius);

      canvas.drawPath(getOuterPath(bounds), paint);
    }
  }
}
