import 'package:aspen_app/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../injection_container.dart';
import '../../theme/color.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final networkInfo = sl<NetworkInfo>();
  bool isConnected = true;

  @override
  void initState() {
    networkInfo.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        if (result == ConnectivityResult.none) {
          isConnected = false;
        } else {
          isConnected = true;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: blueGray50,
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstant.imgGroup28),
                  fit: BoxFit.cover)),
          child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 13.v),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 82.v),
                    Align(
                        alignment: Alignment.center,
                        child: Image.asset(ImageConstant.imgAspenLogo)),
                    const Spacer(),
                    SizedBox(
                        width: 200.h,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("lbl_plan_your".tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      color: Colors.white,
                                      fontSize: 20)),
                              Text("msg_luxurious_vacation".tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: 40))
                            ])),
                    _buildExploreButton(context)
                  ]))),
    ));
  }

  /// Section Widget
  Widget _buildExploreButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        NavigatorService.popAndPushNamed(AppRoutes.homePage);
      },
      buttonTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),
      buttonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(travel),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ))),
      height: 52.v,
      text: "lbl_explore".tr,
      margin: EdgeInsets.only(bottom: 48.v, top: 16.v),
    );
  }
}
