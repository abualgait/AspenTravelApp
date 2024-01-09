import 'package:aspen_app/core/usecase/usecase.dart';
import 'package:aspen_app/domain/usecase/get_favorite_data.dart';
import 'package:aspen_app/domain/usecase/insert_favorite_city.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/failures.dart';
import '../../../data/model/travel_data_response.dart';
import '../../../domain/usecase/get_travel_data.dart';
import '../../../domain/usecase/remove_favorite_city.dart';
import '../../../injection_container.dart';

final homeStateProvider =
    StateNotifierProvider<HomeStateNotifier, CityUIStates>((ref) {
  return HomeStateNotifier(
      getTravelDataUseCase: sl(),
      addFavoriteCityUseCase: sl(),
      deleteFavoriteCityUseCase: sl(),
      getFavoriteCitiesUseCase: sl());
});

class HomeStateNotifier extends StateNotifier<CityUIStates> {
  final GetTravelDataUseCase getTravelDataUseCase;
  final GetFavoriteCitiesUseCase getFavoriteCitiesUseCase;
  final AddFavoriteCityUseCase addFavoriteCityUseCase;
  final DeleteFavoriteCityUseCase deleteFavoriteCityUseCase;

  HomeStateNotifier(
      {required this.getTravelDataUseCase,
      required this.addFavoriteCityUseCase,
      required this.getFavoriteCitiesUseCase,
      required this.deleteFavoriteCityUseCase})
      : super(CityUIStates());

  void loadTravelData() async {
    state = CityUIStates(isLoading: true);
    var response =
        await getTravelDataUseCase(const ParamsGetTravelData(locationId: ""));
    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          state = CityUIStates(isLoading: false, error: failure.errorMessage);
        } else if (failure is ConnectionFailure) {
          state = CityUIStates(isLoading: false, error: failure.errorMessage);
        }
      },
      (data) {
        state = CityUIStates(
            isLoading: false,
            popular: data.popularCities,
            recommended: data.recommendedCities,
            categories: data.categories);
      },
    );
  }

  void loadFavoriteCities() async {
    state = state.copyWith(isLoading: true);
    var response = await getFavoriteCitiesUseCase(NoParams());
    response.fold(
      (failure) {
        if (failure is DatabaseFailure) {
          state = state.copyWith(
              isLoading: false,
              isFavLoading: false,
              error: failure.errorMessage);
        } else if (failure is ConnectionFailure) {
          state = state.copyWith(
              isLoading: false,
              isFavLoading: false,
              error: failure.errorMessage);
        }
      },
      (data) {
        state = state.copyWith(
            isLoading: false,
            isFavLoading: false,
            favoriteCitiesList: data ?? []);
      },
    );
  }

  void addCityToFavorite(City city) async {
    await addFavoriteCityUseCase(city);
    loadFavoriteCities();
  }

  void removeCityFromFavorite(City city) async {
    await deleteFavoriteCityUseCase(city);
    loadFavoriteCities();
  }

  void toggleSelection(int index) {
    var currentList = state.categories;
    currentList.forEach((item) => item.isSelected = false);
    currentList[index].isSelected = !currentList[index].isSelected;
    state = state.copyWith(categories: currentList);
  }
}

class CityUIStates {
  bool isLoading;
  bool isFavLoading;
  String error;
  List<City> popular;
  List<City> favoriteCitiesList;
  List<City> recommended;
  List<Category> categories;

  CityUIStates({
    this.isLoading = false,
    this.isFavLoading = false,
    this.error = "",
    this.popular = const [],
    this.recommended = const [],
    this.categories = const [],
    this.favoriteCitiesList = const [],
  });

  CityUIStates copyWith({
    bool? isLoading,
    bool? isFavLoading,
    String? error,
    List<City>? popular,
    List<City>? recommended,
    List<Category>? categories,
    List<City>? favoriteCitiesList,
  }) {
    return CityUIStates(
      isLoading: isLoading ?? this.isLoading,
      isFavLoading: isFavLoading ?? this.isFavLoading,
      error: error ?? this.error,
      popular: popular ?? this.popular,
      recommended: recommended ?? this.recommended,
      categories: categories ?? this.categories,
      favoriteCitiesList: favoriteCitiesList ?? this.favoriteCitiesList,
    );
  }
}
