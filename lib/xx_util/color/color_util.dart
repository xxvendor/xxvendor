import 'dart:math';
import 'dart:ui';

Color rgba(int r, int g, int b, double a) {
  return Color.fromRGBO(r, g, b, a);
}

Color randomColor(double a) {
  final rnd = Random.secure();
  return Color.fromRGBO(
      rnd.nextInt(256), rnd.nextInt(256), rnd.nextInt(256), a);
}
