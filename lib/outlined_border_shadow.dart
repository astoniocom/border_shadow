import 'package:border_shadow/border_shadow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class OutlinedBorderShadow extends OutlinedBorder with ShadowsPainter {
  OutlinedBorderShadow({
    BorderSide? side,
    required this.child,
    required this.boxShadow,
  }) : super(side: side ?? child.side);

  @override
  final OutlinedBorder child;

  @override
  final List<BoxShadow> boxShadow;

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is OutlinedBorderShadow) {
      final result = child.lerpFrom(a.child, t);
      if (result is OutlinedBorder) {
        return OutlinedBorderShadow(
          child: result,
          boxShadow: BoxShadow.lerpList(a.boxShadow, boxShadow, t)!,
        );
      }
    }

    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is OutlinedBorderShadow) {
      final result = child.lerpTo(b.child, t);
      if (result is OutlinedBorder) {
        return OutlinedBorderShadow(
          child: result,
          boxShadow: BoxShadow.lerpList(b.boxShadow, boxShadow, t)!,
        );
      }
    }

    return super.lerpTo(b, t);
  }

  @override
  OutlinedBorder copyWith({BorderSide? side, OutlinedBorder? child, List<BoxShadow>? boxShadow}) {
    return OutlinedBorderShadow(
      child: (child ?? this.child).copyWith(side: side),
      boxShadow: boxShadow ?? this.boxShadow,
      side: side ?? this.side,
    );
  }

  @override
  ShapeBorder scale(double t) {
    final scalledChild = child.scale(t);

    return OutlinedBorderShadow(
      child: scalledChild is OutlinedBorder ? scalledChild : child,
      boxShadow: BoxShadow.lerpList(null, boxShadow, t)!,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    paintShadow(canvas, rect);

    child.paint(canvas, rect, textDirection: textDirection);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is OutlinedBorderShadow && other.side == side && other.child == child && listEquals<BoxShadow>(other.boxShadow, boxShadow);
  }

  @override
  int get hashCode => hashValues(side, child, hashList(boxShadow));

  @override
  String toString() {
    return '${objectRuntimeType(this, 'OutlinedBorderShadow')}($side, $boxShadow, $child)';
  }
}
