import "package:expandable_text/expandable_text.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../core/app_export.dart";
import "../../data/model/travel_data_response.dart";
import "../../theme/color.dart";
import "../../widgets/custom_elevated_button.dart";
import "../../widgets/custom_icon_button.dart";
import "../home_screen/provider/home_provider.dart";

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({super.key});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  City? city;
  var longText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Retrieve the data from the arguments
      city = ModalRoute.of(context)!.settings.arguments as City?;
      if (city != null) {
        ref.read(homeStateProvider.notifier).loadFavoriteCities();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(
            PrefUtils().getIsDarkMode() == true ? 0xFF000000 : 0xFFFFFFFF),
        body: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            var value = ref.watch(homeStateProvider);
            var provider = ref.watch(homeStateProvider.notifier);
            if (value.isLoading == true) {
              return const Center(child: CircularProgressIndicator());
            } else if (value.error != "") {
              return Center(child: Text(value.error ?? ""));
            } else {
              if (city == null) {
                return const Center(child: Text("City not found!"));
              }
              return SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(children: [
                    Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(20.h),
                        child: Column(children: [
                          _buildProductImageSection(
                              context, city!, value, provider),
                          SizedBox(height: 8.v),
                          _buildTwelveSection(context, city!, value, provider),
                          SizedBox(height: 14.v),
                          ExpandableText(
                            collapseOnTextTap: true,
                            longText,
                            expandText: 'Read more',
                            collapseText: 'Read less',
                            maxLines: 5,
                            linkColor: travel,
                          ),
                          SizedBox(height: 31.v),
                          _buildInfoSection(context),
                        ])),
                  ]),
                ),
              );
            }
          },
        ),
        bottomNavigationBar: _buildBookSection(context),
      ),
    );
  }
}

/// Section Widget
Widget _buildProductImageSection(BuildContext context, City city,
    CityUIStates value, HomeStateNotifier provider) {
  return SizedBox(
      height: 380.v,
      width: double.maxFinite,
      child: Stack(alignment: Alignment.bottomRight, children: [
        SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                Column(
                  children: [
                    Stack(alignment: Alignment.topLeft, children: [
                      CustomImageView(
                          imagePath: city.image,
                          height: 350,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                          radius: BorderRadius.circular(20.h),
                          alignment: Alignment.center),
                      Positioned(
                        left: 12.h,
                        top: 12.v,
                        child: CustomIconButton(
                            decoration: BoxDecoration(
                                color: gray50,
                                borderRadius: BorderRadius.circular(10)),
                            height: 40.adaptSize,
                            width: 40.adaptSize,
                            padding: EdgeInsets.all(12.h),
                            onTap: () {
                              NavigatorService.goBack();
                            },
                            child: CustomImageView(
                                imagePath: ImageConstant.imgArrowLeftGray400)),
                      )
                    ]),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 15,
                  child: InkWell(
                    onTap: () {
                      value.favoriteCitiesList.contains(city)
                          ? provider.removeCityFromFavorite(city!)
                          : provider.addCityToFavorite(city!);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                1.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CustomImageView(
                          color: value.favoriteCitiesList.contains(city)
                              ? Colors.red
                              : Colors.black,
                          width: 20,
                          height: 20,
                          imagePath:
                              ImageConstant.imgFavoriteSecondarycontainer,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ))
      ]));
}

/// Section Widget
Widget _buildTwelveSection(BuildContext context, City city, CityUIStates value,
    HomeStateNotifier provider) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(city.title,
              style: TextStyle(
                  fontSize: 27.fSize,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 3.v),
          Padding(
              padding: EdgeInsets.only(left: 3.h),
              child: Row(children: [
                CustomImageView(
                    imagePath: ImageConstant.imgStar,
                    height: 16.adaptSize,
                    width: 16.adaptSize,
                    margin: EdgeInsets.only(bottom: 1.v)),
                Padding(
                    padding: EdgeInsets.only(left: 4.h, top: 2.v),
                    child: Text("${city.rating} (355 Reviews)",
                        style: TextStyle(
                            color: gray700,
                            fontSize: 14.fSize,
                            fontWeight: FontWeight.w400)))
              ]))
        ]),
        Padding(
            padding: EdgeInsets.only(top: 8.v, bottom: 24.v),
            child: Text("lbl_show_map".tr,
                style: TextStyle(
                    color: travel,
                    fontSize: 14.fSize,
                    fontWeight: FontWeight.w700)))
      ]);
}

class Info {
  String icon;
  String title;

  Info({required this.icon, required this.title});
}

/// Section Widget
Widget _buildInfoSection(BuildContext context) {
  List<Info> infoList = [
    Info(icon: ImageConstant.imgWifi, title: "1 Heater"),
    Info(icon: ImageConstant.imgFood, title: "Dinner"),
    Info(icon: ImageConstant.imgBathTub, title: "1 Tub"),
    Info(icon: ImageConstant.imgFrame, title: "Pool")
  ];

  return SizedBox(
    width: double.maxFinite,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("lbl_facilities".tr,
          style: TextStyle(
              fontSize: 24.fSize,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600)),
      SizedBox(height: 16.v),
      SizedBox(
        height: 74,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Container(
                height: 70,
                width: (MediaQuery.of(context).size.width - 100) / 4,
                decoration: BoxDecoration(
                    color: gray50, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageView(
                      height: 32,
                      width: 32,
                      imagePath: infoList[index].icon,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      infoList[index].title,
                      style: const TextStyle(
                          color: Color(0xFFB8B8B8),
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ]),
  );
}

/// Section Widget
Widget _buildBookSection(BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 10, top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
            padding: EdgeInsets.only(top: 4.v, bottom: 3.v),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("lbl_price".tr,
                      style: TextStyle(
                          fontSize: 14.fSize, fontWeight: FontWeight.bold)),
                  Padding(
                      padding: EdgeInsets.only(top: 3.v),
                      child: Text("\$199",
                          style: TextStyle(
                              color: tealA400,
                              fontSize: 30.fSize,
                              fontWeight: FontWeight.bold)))
                ])),
        const SizedBox(
          width: 50,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: travel.withOpacity(0.6),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                  offset:
                      const Offset(0.0, 5.0), // shadow direction: bottom right
                )
              ],
              color: Colors.transparent,
              shape: BoxShape.rectangle,
            ),
            child: CustomElevatedButton(
              onPressed: () {},
              buttonTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
              buttonStyle: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(travel),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ))),
              height: 52.v,
              text: "lbl_book_now".tr,
            ),
          ),
        )
      ]));
}
