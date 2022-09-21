import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:weather_tdd_flutter/data/datasources/remote_data_source.dart';
import 'package:weather_tdd_flutter/domain/repositories/weather_repository.dart';

@GenerateMocks([
  WeatherRepository,
  RemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
