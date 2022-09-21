import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_tdd_flutter/data/datasources/remote_data_source.dart';
import 'package:weather_tdd_flutter/data/exception.dart';
import 'package:weather_tdd_flutter/data/failure.dart';
import 'package:weather_tdd_flutter/domain/repositories/weather_repository.dart';

import '../../domain/entities/weather.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
