import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/src/core/waveform_painters_ab.dart';
import 'package:flutter_audio_waveforms/src/util/waveform_alignment.dart';
import 'package:flutter_audio_waveforms/src/waveforms/polygon_waveform/polygon_waveform.dart';

///ActiveWaveformPainter for the [PolygonWaveform]
class PolygonActiveWaveformPainter extends ActiveWaveformPainter {
  // ignore: public_member_api_docs
  PolygonActiveWaveformPainter({
    required super.color,
    super.gradient,
    required super.activeSamples,
    required super.waveformAlignment,
    required super.style,
    required super.sampleWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final continousActivePaint = Paint()
      ..style = style
      ..color = color
      ..shader = gradient?.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    final path = Path();
    final isStroked = style == PaintingStyle.stroke;

    for (var i = 0; i < activeSamples.length; i++) {
      final x = sampleWidth * i;
      final y = activeSamples[i];
      if (isStroked) {
        path.lineTo(x, y);
      } else {
        if (i == activeSamples.length - 1) {
          path.lineTo(x, 0);
        } else {
          path.lineTo(x, y);
        }
      }
    }
   
    canvas.drawPath(path, continousActivePaint);
  }
}
