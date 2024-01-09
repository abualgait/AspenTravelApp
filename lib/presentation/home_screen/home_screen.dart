import "package:aspen_app/presentation/home_screen/provider/home_provider.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../core/app_export.dart";
import "../../data/model/travel_data_response.dart";
import "../../injection_container.dart";
import "../../theme/color.dart";

/// Popular List Item
class PopularListViewItem extends ConsumerStatefulWidget {
  final City city;

  const PopularListViewItem({required this.city, super.key});

  @override
  ConsumerState<PopularListViewItem> createState() =>
      _PopularListViewItemState();
}

class _PopularListViewItemState extends ConsumerState<PopularListViewItem> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeStateProvider.notifier).loadFavoriteCities();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      var value = ref.watch(homeStateProvider);
      var provider = ref.read(homeStateProvider.notifier);

      return Container(
        height: double.maxFinite,
        width: 155.h,
        margin: EdgeInsets.only(left: 16.h),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            CustomImageView(
              fit: BoxFit.cover,
              imagePath: widget.city.image,
              radius: BorderRadius.circular(
                15.h,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.h,
                  right: 10.h,
                  bottom: 16.v,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: darkGrey,
                          shape: BoxShape.rectangle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(200))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
                        child: Text(
                          widget.city.title,
                          style: TextStyle(
                            color: whiteA70001,
                            fontSize: 12.fSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: darkGrey,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(200))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
                            child: Row(
                              children: [
                                CustomImageView(
                                  width: 10,
                                  height: 10,
                                  imagePath: ImageConstant.imgStarPng,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.city.rating.toString(),
                                  style: TextStyle(
                                    color: whiteA70001,
                                    fontSize: 12.fSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            value.favoriteCitiesList.contains(widget.city)
                                ? provider.removeCityFromFavorite(widget.city)
                                : provider.addCityToFavorite(widget.city);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(200))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomImageView(
                                color: value.favoriteCitiesList
                                        .contains(widget.city)
                                    ? Colors.red
                                    : Colors.black,
                                width: 14,
                                height: 14,
                                imagePath:
                                    ImageConstant.imgFavoriteSecondarycontainer,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

/// Recommended List Item
class RecommendedListViewItem extends ConsumerStatefulWidget {
  final City city;

  const RecommendedListViewItem({required this.city, super.key});

  @override
  ConsumerState<RecommendedListViewItem> createState() =>
      _RecommendedListViewItemState();
}

class _RecommendedListViewItemState
    extends ConsumerState<RecommendedListViewItem> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeStateProvider.notifier).loadFavoriteCities();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      var value = ref.watch(homeStateProvider);
      var provider = ref.read(homeStateProvider.notifier);

      return Container(
        margin: EdgeInsets.only(left: 16.h),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            15.h,
          )),
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Container(
            width: 180.h,
            margin: EdgeInsets.all(3.h),
            child: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomImageView(
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                          height: 100,
                          imagePath: widget.city.image,
                          radius: BorderRadius.circular(
                            15.h,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: darkGrey,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3.0,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(200))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
                          child: Text(
                            "4N/5D",
                            style: TextStyle(
                              color: whiteA70001,
                              fontSize: 13.fSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.city.title,
                        style: const TextStyle(
                          color: Color(0xFF232323),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.v),
                      Row(
                        children: [
                          CustomImageView(
                            width: 16,
                            height: 16,
                            imagePath: ImageConstant.imgSwmIconsBroken,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Hot Deal",
                            style: TextStyle(
                              color: Color(0xFF3A544F),
                              fontSize: 12.fSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CategoryListViewItem extends ConsumerStatefulWidget {
  final Category category;

  const CategoryListViewItem({required this.category, super.key});

  @override
  ConsumerState<CategoryListViewItem> createState() =>
      _CategoryListViewItemState();
}

class _CategoryListViewItemState extends ConsumerState<CategoryListViewItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
              color: widget.category.isSelected
                  ? const Color(0xFFEAF1FF)
                  : Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(200))),
          margin: EdgeInsets.only(left: 16.h),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 7.0, bottom: 7.0),
            child: Text(
              widget.category.title.toString(),
              textAlign: TextAlign.center,
              style: widget.category.isSelected
                  ? TextStyle(
                      color: travel,
                      fontSize: 12.fSize,
                      fontWeight: FontWeight.bold,
                    )
                  : TextStyle(
                      color: const Color(0xFFB8B8B8),
                      fontSize: 12.fSize,
                      fontWeight: FontWeight.w700,
                    ),
            ),
          ),
        ),
      );
    });
  }
}

void changeLocale(BuildContext context, Locale newLocale) {
  AppLocalization.of().setLocale(newLocale);
}

Locale getCurrentLocale() {
  return AppLocalization.of().getCurrentLocale();
}

ListView PopularList(List<City> cities) {
  return ListView(
    scrollDirection: Axis.horizontal,
    children: List.generate(
      cities.length,
      (index) => InkWell(
        onTap: () {
          NavigatorService.pushNamed(AppRoutes.detailsPage,
              arguments: cities[index]);
        },
        child: PopularListViewItem(
          city: cities[index],
        ),
      ),
    ),
  );
}

ListView RecommendedList(List<City> cities) {
  return ListView(
    scrollDirection: Axis.horizontal,
    children: List.generate(
      cities.length,
      (index) => RecommendedListViewItem(
        city: cities[index],
      ),
    ),
  );
}

ListView CategoryList(
    List<Category> categories, CityUIStates value, HomeStateNotifier provider) {
  return ListView(
    scrollDirection: Axis.horizontal,
    children: List.generate(
      categories.length,
      (index) => InkWell(
        onTap: () {
          provider.toggleSelection(index);
        },
        child: Center(
          child: CategoryListViewItem(
            category: categories[index],
          ),
        ),
      ),
    ),
  );
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  final themeBloc = sl<ThemeBloc>();
  bool isDarkMode = PrefUtils().getIsDarkMode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Retrieve the data from the arguments
      ref.read(homeStateProvider.notifier).loadTravelData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      var value = ref.watch(homeStateProvider);
      var provider = ref.watch(homeStateProvider.notifier);

      if (value.isLoading == true && value.categories.isEmpty) {
        return Center(
            child: CircularProgressIndicator(
          color: travel,
        ));
      } else if (value.error != "") {
        return Center(child: Text(value.error ?? ""));
      } else {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height +
                    MediaQuery.of(context).padding.top,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.v),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'lbl_explore'.tr,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    'lbl_aspen'.tr,
                                    style: const TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: travel,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "Aspen, USA",
                                    style: TextStyle(
                                        color: Color(0xFF606060),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xFF606060),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200.0),
                              color: blueA4000c,
                            ),
                            child: const TextField(
                              style: TextStyle(color: Color(0xFFB8B8B8)),
                              decoration: InputDecoration(
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w400),
                                hintText: "Find things to do",
                                contentPadding: EdgeInsets.all(12.0),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search,
                                    color: Color(0xFFB8B8B8)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.v),
                    SizedBox(
                      height: 40,
                      width: double.maxFinite,
                      child: CategoryList(value.categories, value, provider),
                    ),
                    SizedBox(height: 16.v),
                    _buildPopularSection(context),
                    SizedBox(height: 16.v),
                    SizedBox(
                      height: 240,
                      child: PopularList(value.popular),
                    ),
                    _buildRecommendedSection(context),
                    SizedBox(
                      height: 180,
                      child: RecommendedList(value.recommended),
                    ),
                    SizedBox(height: 31.v),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }

  /// Section Widget
  Widget _buildPopularSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_popular".tr,
            style: TextStyle(
              fontSize: 20.fSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.v),
            child: Text(
              "lbl_see_all".tr,
              style: TextStyle(
                color: const Color(0xFF176FF2),
                fontSize: 14.fSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRecommendedSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.h, top: 20.v),
      child: Container(
        width: double.maxFinite,
        child: Text(
          "lbl_recommended".tr,
          style: TextStyle(
            fontSize: 20.fSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
