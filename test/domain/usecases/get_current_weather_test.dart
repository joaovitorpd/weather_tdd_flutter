import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeather usecase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(mockWeatherRepository);
  });

  const testWeatherDetail = Weather(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: '302.28',
    pressure: '1009',
    humidity: 70,
  );

  const tCityName = 'Jakarta';

  test(
    'should get current detail from repository',
    () async {
      //arrange
      when(mockWeatherRepository.GetCurrentWeather(tCityName))
          .thenAnswer((_) async => const Right(testWeatherDetail));

      //act
      final result = await usecase.execute(tCityName);

      //assert
      expect(result, equals(Right(testWeatherDetail)));
    },
  );
}
