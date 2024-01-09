import 'dart:convert';

import 'package:aspen_app/core/network/network_manager.dart';

import '../../../core/fixture/dummy_travel_data.dart';
import '../../model/travel_data_response.dart';

abstract class TravelRemoteDataSource {
  Future<TravelApiResponse> getTravelData();
}

class SurahRemoteDataSourceImpl implements TravelRemoteDataSource {
  final NetworkManagerImpl networkManager;

  SurahRemoteDataSourceImpl({
    required this.networkManager,
  });

  @override
  Future<TravelApiResponse> getTravelData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    var response = TravelApiResponse.fromJson(
        json.decode(jsonData)); //json.decode(fixture_reader.json))
    return response;
  }
}


