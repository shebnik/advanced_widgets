import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Tint extends SingleChildRenderObjectWidget {
  const Tint({
    required Widget child,
    Key? key,
    required this.text,
    this.blur = 10,
    this.color = Colors.black38,
    this.offset = const Offset(10, 10),
  }) : super(key: key, child: child);

  final String text;
  final double blur;
  final Color color;
  final Offset offset;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final RenderTint renderObject = RenderTint(text: text);
    updateRenderObject(context, renderObject);
    return renderObject;
  }

  @override
  void updateRenderObject(BuildContext context, RenderTint renderObject) {
    renderObject
      ..color = color
      ..blur = blur
      ..dx = offset.dx
      ..dy = offset.dy;
  }
}

class RenderTint extends RenderProxyBox {
  RenderTint({
    RenderBox? child,
    required this.text,
  })  : textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: TextStyle(
              fontSize: 32,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          textDirection: TextDirection.ltr,
        ),
        super(child);

  final String text;
  late final TextPainter textPainter;
  late double blur;
  late Color color;
  late double dx;
  late double dy;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;
    final Rect rectOuter = offset & size;
    final Rect rectInner = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      size.width - dx,
      size.height - dy,
    );
    final Canvas canvas = context.canvas..saveLayer(rectOuter, Paint());
    context.paintChild(child!, offset);
    final Paint shadowPaint = Paint()
      ..blendMode = BlendMode.srcATop
      ..imageFilter = ImageFilter.blur(sigmaX: blur, sigmaY: blur)
      ..colorFilter = ColorFilter.mode(color, BlendMode.srcOut);

    canvas
      ..saveLayer(rectOuter, shadowPaint)
      ..saveLayer(rectInner, Paint())
      ..translate(dx, dy);
    context.paintChild(child!, offset);
    context.canvas
      ..restore()
      ..restore()
      ..restore();

    context.paintChild(child!, offset);
    textPainter.layout();
    textPainter.paint(
      context.canvas,
      Offset(
        offset.dx + 2,
        offset.dy - 2,
      ),
    );
    context.paintChild(child!, Offset(offset.dx + 0.5, offset.dy - 0.5));
  }
}
