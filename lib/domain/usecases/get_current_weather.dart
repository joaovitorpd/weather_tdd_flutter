import 'package:dartz/dartz.dart';
import 'package:weather_tdd_flutter/data/failure.dart';
import 'package:weather_tdd_flutter/domain/entities/weather.dart';
import 'package:weather_tdd_flutter/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, Weather>> execute(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}
