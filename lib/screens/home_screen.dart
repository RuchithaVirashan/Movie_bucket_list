import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../components/common/default_text.dart';
import '../components/common/progess_bar.dart';
import '../globle/constants.dart';
import '../globle/staus/connection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLoading = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<ConnectivityResult>? subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  int initLevel = 0;
  bool showedDialog = false;

  @override
  void didChangeDependencies() {
    getConnectivity();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && isAlertSet == false) {
        // ignore: use_build_context_synchronously
        showConnetionDialog(
          context,
          isDeviceConnected,
          isAlertSet,
        );
        setState(() {
          isAlertSet = true;
        });
      } else {
        setState(() {
          isAlertSet = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return Scaffold(
      body: isLoading
          ? Container(
              height: relativeHeight * 932,
              width: relativeWidth * 430,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/ammas logo.jpeg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.83),
                    BlendMode.srcOver,
                  ),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: relativeHeight * 50.0,
                        left: relativeWidth * 120.0,
                        right: relativeWidth * 120.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: const Image(
                          image: AssetImage('assets/ammas logo.jpeg'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: relativeHeight * 20.0,
                        left: relativeWidth * 120.0,
                        right: relativeWidth * 120.0,
                      ),
                      child: CommonProgressBar(
                        percentage: initLevel == 0
                            ? 0.0
                            : initLevel == 1
                                ? 0.4
                                : initLevel == 2
                                    ? 0.8
                                    : 1,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : CustomScrollView(
              slivers: [
                // SliverAppBar.medium(
                //   backgroundColor: Colors.white,
                //   expandedHeight: relativeHeight * 0,
                //   leading: IconButton(
                //     icon: Icon(Icons.arrow_back_ios_new),
                //     onPressed: () {
                //       Navigator.pushNamed(context, '/main');
                //     },
                //     color: Colors.black,
                //   ),
                //   title: Padding(
                //     padding: EdgeInsets.only(left: relativeWidth * 20),
                //     child: const Text(
                //       '',
                //     ),
                //   ),
                // ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.only(
                          top: relativeHeight * 60,
                          left: relativeWidth * 30,
                          right: relativeWidth * 110,
                        ),
                        child: DefaultText(
                          colorR: Color(0xFF22242E),
                          content: 'Find Your \nFavorite Movie',
                          fontSizeR: 36,
                          fontWeightR: FontWeight.w400,
                          textAlignR: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: relativeHeight * 10,
                          left: relativeWidth * 36,
                          right: relativeWidth * 36,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: relativeHeight * 10,
                                left: relativeWidth * 36,
                                right: relativeWidth * 36,
                              ),
                              child: const Center(
                                child: DefaultText(
                                  colorR: Color.fromRGBO(25, 30, 29, 1),
                                  content:
                                      'Buy our amazing recipes before the countdown hits 0! Don\'t miss the chance.',
                                  fontSizeR: 12,
                                  fontWeightR: FontWeight.w500,
                                  textAlignR: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}