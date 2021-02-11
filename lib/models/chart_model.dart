part of 'models.dart';

class ChartModel {
  final double productivity;
  final double count;

  ChartModel(this.productivity, this.count);
}

class WeatherGraphicModel {
  WeatherGraphicModel(this.weather, this.average);
  final String weather;
  final double average;
}
