import 'package:flutter/material.dart';

class WeatherPainter extends CustomPainter {
  final double state;

  WeatherPainter({
    required this.state,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2, centerY = size.height / 2;

    final sunPainter = Paint()
      ..color = Colors.amber.withOpacity(_getSunOpacity())
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), 30, sunPainter);

    final cloudPainter = Paint()
      ..color = const Color(0xFF414141).withOpacity(_getCloudOpacity())
      ..style = PaintingStyle.fill;

    double x = centerX - 30, y = centerY + (state > 0.5 ? 20 : 30);
    const Radius radius = Radius.circular(1);

    final cloudPath = Path()
      ..moveTo(x, y)
      ..arcToPoint(Offset(x + 7, y - 37), radius: radius)
      ..arcToPoint(Offset(x + 40, y - 42), radius: radius)
      ..arcToPoint(Offset(x + 59, y - 26), radius: radius)
      ..arcToPoint(Offset(x + 59, y), radius: radius)
      ..close();

    canvas.drawPath(cloudPath, cloudPainter);

    final dropsPainter = Paint()
      ..color = Colors.blue.withOpacity(_getDropsOpacity())
      ..style = PaintingStyle.fill;

    canvas.drawLine(Offset(x + 5, y + 5), Offset(x - 5, y + 15), dropsPainter);
    canvas.drawLine(Offset(x + 15, y + 5), Offset(x + 5, y + 15), dropsPainter);
    canvas.drawLine(
        Offset(x + 25, y + 5), Offset(x + 15, y + 15), dropsPainter);
    canvas.drawLine(
        Offset(x + 35, y + 5), Offset(x + 25, y + 15), dropsPainter);
    canvas.drawLine(
        Offset(x + 45, y + 5), Offset(x + 35, y + 15), dropsPainter);
    canvas.drawLine(
        Offset(x + 55, y + 5), Offset(x + 45, y + 15), dropsPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  double _getSunOpacity() {
    return state > 0.5 ? 0 : 1;
  }

  double _getCloudOpacity() {
    if (state < 0.2) {
      return 0;
    }

    return 10 / 8 * state - 2 / 8;
  }

  double _getDropsOpacity() {
    if (state < 0.7) {
      return 0;
    }

    return 10 / 3 * state - 7 / 3;
  }
}
