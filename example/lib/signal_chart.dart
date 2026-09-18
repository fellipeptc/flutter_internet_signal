import 'package:flutter/material.dart';

class SignalChart extends StatelessWidget {
  final List<double> values;

  const SignalChart({
    super.key,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade500),
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomPaint(
        painter: SignalChartPainter(values),
      ),
    );
  }
}

class SignalChartPainter extends CustomPainter {
  SignalChartPainter(this.values);

  final List<double> values;

  static const double minDbm = -100;
  static const double maxDbm = -30;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final paint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final path = Path();

    final stepX = values.length > 1 ? size.width / (values.length - 1) : size.width;

    for (var i = 0; i < values.length; i++) {
      final dbm = values[i].clamp(minDbm, maxDbm);

      final normalized = (dbm - minDbm) / (maxDbm - minDbm);

      final x = i * stepX;
      final y = size.height - (normalized * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SignalChartPainter oldDelegate) {
    return oldDelegate.values != values;
  }
}
