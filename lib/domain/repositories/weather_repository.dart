import 'package:dartz/dartz.dart';
import 'package:weather_tdd_flutter/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
