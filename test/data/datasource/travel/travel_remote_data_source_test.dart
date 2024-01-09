import 'dart:convert';

import 'package:aspen_app/core/network/network_manager.dart';
import 'package:aspen_app/data/datasource/travel/travel_remote_data_source.dart';
import 'package:aspen_app/data/model/travel_data_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixture/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late TravelRemoteDataSourceImpl travelRemoteDataSource;
  late NetworkManagerImpl networkManagerImpl;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    mockDio.options = BaseOptions(baseUrl: "https://google.com");
    networkManagerImpl = NetworkManagerImpl(mockDio);
    travelRemoteDataSource =
        TravelRemoteDataSourceImpl(networkManager: networkManagerImpl);
  });

  group("Make sure remote data source return success", () {
    void setUpMockDioSuccess() {
      final responsePayload = json.decode(fixture('travel_response.json'));
      final response = Response(
        data: responsePayload,
        statusCode: 200,
        requestOptions: RequestOptions(baseUrl: ""),
      );
      when(
        () => mockDio.get("/endpoint"),
      ).thenAnswer((_) async => response);
    }

    test("make sure get travel data return success", () async {
      setUpMockDioSuccess();
      var result = await travelRemoteDataSource.getTravelData();
      expect(result.categories.length, 8);
      expect(result.categories.first.title, "Location");
    });
  });
}
