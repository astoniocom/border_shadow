import 'package:border_shadow/shadows_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InputBorderShadow extends InputBorder with ShadowsPainter {
  InputBorderShadow({
    required this.child,
    required this.boxShadow,
    bool? isOutline,
  })  : isOutline = isOutline ?? child.isOutline,
        super(borderSide: child.borderSide);

  @override
  final InputBorder child;

  @override
  final List<BoxShadow> boxShadow;

  @override
  final bool isOutline;

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is InputBorderShadow) {
      final result = child.lerpFrom(a.child, t);
      if (result is InputBorder) {
        return InputBorderShadow(
          child: result,
          boxShadow: BoxShadow.lerpList(a.boxShadow, boxShadow, t)!,
        );
      }
    }

    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is InputBorderShadow) {
      final result = child.lerpTo(b.child, t);
      if (result is InputBorder) {
        return InputBorderShadow(
          child: result,
          boxShadow: BoxShadow.lerpList(b.boxShadow, boxShadow, t)!,
        );
      }
    }

    return super.lerpTo(b, t);
  }

  @override
  InputBorder copyWith({BorderSide? borderSide, InputBorder? child, List<BoxShadow>? boxShadow, bool? isOutline}) {
    return InputBorderShadow(
      child: (child ?? this.child).copyWith(borderSide: borderSide),
      boxShadow: boxShadow ?? this.boxShadow,
      isOutline: isOutline ?? this.isOutline,
    );
  }

  @override
  ShapeBorder scale(double t) {
    final scalledChild = child.scale(t);

    return InputBorderShadow(
      child: scalledChild is InputBorder ? scalledChild : child,
      boxShadow: BoxShadow.lerpList(null, boxShadow, t)!,
      isOutline: isOutline,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {double? gapStart, double gapExtent = 0.0, double gapPercentage = 0.0, TextDirection? textDirection}) {
    paintShadow(canvas, rect);

    child.paint(canvas, rect, gapStart: gapStart, gapExtent: gapExtent, gapPercentage: gapPercentage, textDirection: textDirection);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is InputBorderShadow && other.borderSide == borderSide && other.child == child && listEquals<BoxShadow>(other.boxShadow, boxShadow);
  }

  @override
  int get hashCode => hashValues(borderSide, child, hashList(boxShadow));

  @override
  String toString() {
    return '${objectRuntimeType(this, 'InputBorderShadow')}($borderSide, $boxShadow, $child)';
  }
}
