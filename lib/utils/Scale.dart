import 'dart:ui';

const double baselineWidth = 375;
const double baselineHeight = 812;

double scaleFont(double size) {
  final width = window.physicalSize.width / window.devicePixelRatio;
  if (width >= baselineWidth) {
    return roundToNearestPixel(size);
  }
  return roundToNearestPixel(
    (width / baselineWidth) * size,
  );
}

double roundToNearestPixel(double layoutSize) {
  final devicePixelRatio = window.devicePixelRatio;
  return (layoutSize * devicePixelRatio).round() / devicePixelRatio;
}

double scale(int value) {
  final width = window.physicalSize.width / window.devicePixelRatio;
  if (width >= baselineWidth) {
    return roundToNearestPixel(baselineWidth);
  }
  return roundToNearestPixel((width / baselineWidth) * value);
}

double verticalScale(double value) {
  final height = window.physicalSize.height / window.devicePixelRatio;
  if (height >= baselineHeight) {
    return roundToNearestPixel(value);
  }
  return roundToNearestPixel((height / baselineHeight) * value);
}
