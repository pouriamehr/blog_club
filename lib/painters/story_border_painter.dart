import 'package:flutter/material.dart';

class StoryBorderPainter extends CustomPainter {
  const StoryBorderPainter({required this.isViewed});

  final bool isViewed;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    const strokeWidth = 2.0;

    final erect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      const Radius.circular(17),
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // ======================================================================
    // VIEWED STORY
    // ======================================================================

    if (isViewed) {
      const viewedGradient = LinearGradient(
        colors: [Color(0xff9CC3FF), Color(0xffC1C1C1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

      paint.shader = viewedGradient.createShader(rect);

      final path = Path()..addRRect(erect);

      canvas.drawPath(_dashedPath(path, dashLength: 5, gapLength: 4), paint);
    }
    // ======================================================================
    // UNVIEWED STORY
    // ======================================================================
    else {
      const unviewedGradient = LinearGradient(
        colors: [Color(0xff376AED), Color(0xff49B0E2), Color(0xff9CECFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

      paint.shader = unviewedGradient.createShader(rect);

      canvas.drawRRect(erect, paint);
    }
  }

  // ==========================================================================
  // CREATE DASHED PATH
  // ==========================================================================

  Path _dashedPath(
      Path source, {
        required double dashLength,
        required double gapLength,
      }) {
    final dashedPath = Path();

    for (final metric in source.computeMetrics()) {
      double distance = 0;
      bool addDash = true;

      while (distance < metric.length) {
        final double segmentLength = addDash ? dashLength : gapLength;

        double end = distance + segmentLength;

        if (end > metric.length) {
          end = metric.length;
        }

        if (addDash) {
          dashedPath.addPath(metric.extractPath(distance, end), Offset.zero);
        }

        distance = end;
        addDash = !addDash;
      }
    }

    return dashedPath;
  }

  @override
  bool shouldRepaint(covariant StoryBorderPainter oldDelegate) {
    return oldDelegate.isViewed != isViewed;
  }
}
