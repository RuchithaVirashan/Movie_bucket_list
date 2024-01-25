import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart' as flutter;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_bucket_list/models/movie_model.dart';
import '../components/common/default_text.dart';
import '../components/common/progess_bar.dart';
import '../globle/constants.dart';
import '../globle/staus/connection.dart';
import 'package:dio/dio.dart';

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
  void initState() {
    super.initState();
    fetchData();
  }

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

  Future<void> fetchData() async {
    Response response;
    const String apiUrl = 'https://api.tvmaze.com/schedule/web';

    setState(() {
      // loadingStatus = "loading";
    });
    try {
      response = await Dio().get(apiUrl);

      if (response.statusCode == 200) {
        ShowResponse showResponse = ShowResponse.fromJson(response.data);

        log('responce ${showResponse.showList}');

        setState(() {
          // categoryList = categoryResponse.categoryList;
          // loadingStatus = "";
        });
      }
    } catch (e) {
      setState(() {
        // loadingStatus = "error";
      });
    }
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
                  image: const AssetImage('assets/logo.jpeg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.88),
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
                        child: flutter.Image(
                          image: AssetImage('assets/logo.jpeg'),
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
                          top: relativeHeight * 80,
                          left: relativeWidth * 30,
                          right: relativeWidth * 30,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const DefaultText(
                              colorR: Color(0xFF22242E),
                              content: 'Find Your \nFavorite Movie',
                              fontSizeR: 36,
                              fontWeightR: FontWeight.w400,
                              textAlignR: TextAlign.start,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: IconButton(
                                icon: flutter.Image.asset(
                                  'assets/wishlist.png',
                                  height: relativeHeight * 40,
                                  width: relativeWidth * 40,
                                ),
                                onPressed: () {
                                  print('object');
                                  fetchData();
                                },
                              ),
                            ),
                          ],
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
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: relativeWidth * 120,
                                  height: relativeHeight * 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const DefaultText(
                                        colorR: Color(0xFF22242E),
                                        content: 'Filter',
                                        fontSizeR: 12,
                                        fontWeightR: FontWeight.w400,
                                        textAlignR: TextAlign.start,
                                      ),
                                      flutter.Image.asset(
                                        'assets/filter.png',
                                        height: relativeHeight * 20,
                                        width: relativeWidth * 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: relativeHeight * 20,
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
