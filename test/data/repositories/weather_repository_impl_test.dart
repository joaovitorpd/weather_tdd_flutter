import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_tdd_flutter/data/exception.dart';
import 'package:weather_tdd_flutter/data/failure.dart';
import 'package:weather_tdd_flutter/data/models/weather_model.dart';
import 'package:weather_tdd_flutter/data/repository/weather_repository_impl.dart';
import 'package:weather_tdd_flutter/domain/entities/weather.dart';
import 'package:weather_tdd_flutter/domain/repositories/weather_repository.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late WeatherRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = WeatherRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  const tWeatherModel = WeatherModel(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tWeather = Weather(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  group('get current weather', () {
    final tCityName = 'Jakarta';

    test(
      'should return current weather when a call to data source is successfull',
      () async {
        when(mockRemoteDataSource.getCurrentWeather(tCityName))
            .thenAnswer((_) async => tWeatherModel);

        //act
        final result = await repository.getCurrentWeather(tCityName);

        //assert
        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(result, equals(Right(tWeather)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessfull',
      () async {
        //arrange
        when(mockRemoteDataSource.getCurrentWeather(tCityName))
            .thenThrow(ServerException());

        //act
        final result = await repository.getCurrentWeather(tCityName);

        //assert
        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the devide has no internet',
      () async {
        //arrange
        when(mockRemoteDataSource.getCurrentWeather(tCityName))
            .thenThrow(SocketException('Failed to connect to the network'));

        //act
        final result = await repository.getCurrentWeather(tCityName);

        //assert
        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
}
