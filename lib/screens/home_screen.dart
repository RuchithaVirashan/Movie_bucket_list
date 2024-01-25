import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart' as flutter;
import 'package:country_code_picker/country_code_picker.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_bucket_list/apis/baseurl.dart';
import 'package:movie_bucket_list/components/home/movie_card.dart';
import 'package:movie_bucket_list/globle/staus/error.dart';
import 'package:movie_bucket_list/screens/details_screen.dart';
import '../components/common/default_text.dart';
import '../components/common/progess_bar.dart';
import '../components/home/no_result_found_message.dart';
import '../globle/constants.dart';
import '../globle/page_transition.dart';
import '../globle/staus/connection.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globle/staus/sucess.dart';
import 'wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLoading = true;
  StreamSubscription<ConnectivityResult>? subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  int initLevel = 0;
  bool showedDialog = false;
  List showList = [];
  DateTime selectedDate = DateTime.now();
  CountryCode selectedCountry = CountryCode.fromCode('LK');

  @override
  void initState() {
    super.initState();
    fetchData('init');
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

  Future<void> fetchData(String where) async {
    Response response;
    const String apiUrl = ApiConfig.baseUrl;

    setState(() {
      isLoading = true;
      initLevel = 2;
    });
    try {
      where == 'init'
          ? response = await Dio().get(apiUrl)
          : response = await Dio().get(
              '$apiUrl?date=${selectedDate.toIso8601String().substring(0, 10)}&country=${selectedCountry.code}');

      if (response.statusCode == 200) {
        // ShowResponse showResponse = ShowResponse.fromJson(response.data);

        setState(() {
          showList = response.data;
          log('responce ${showList.length}');
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        showErrorDialog(context, e.toString());
      });
    }
  }

  Future<void> addIdToWishList(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String idList = prefs.getString('idList') ?? '';
    List<String> idsToWL = idList.split(',');
    if (!idsToWL.contains(id)) {
      idsToWL.add(id);
    }
    idList = idsToWL.join(',');
    log('list $idList');
    await prefs.setString('idList', idList);
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
                        left: relativeWidth * 50.0,
                        right: relativeWidth * 50.0,
                      ),
                      child: flutter.Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonProgressBar(
                            percentage: initLevel == 0
                                ? 0.0
                                : initLevel == 1
                                    ? 0.4
                                    : initLevel == 2
                                        ? 0.8
                                        : 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : CustomScrollView(
              slivers: [
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
                                  Navigator.of(context).push(
                                    createRoute(
                                        WishListScreen(
                                          movieList: showList,
                                        ),
                                        TransitionType.upToDown),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: relativeHeight * 10,
                          left: relativeWidth * 10,
                          right: relativeWidth * 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: relativeHeight * 10,
                                left: relativeWidth * 20,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        title: const Text(
                                            'Filter Date and Country'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton(
                                              child: Text(selectedDate == null
                                                  ? 'Select Date'
                                                  : selectedDate
                                                      .toLocal()
                                                      .toString()
                                                      .split(' ')[0]),
                                              onPressed: () async {
                                                final date =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2020),
                                                  lastDate: DateTime(2030),
                                                );
                                                if (date != null) {
                                                  setState(() {
                                                    selectedDate = date;
                                                  });
                                                }
                                              },
                                            ),
                                            CountryCodePicker(
                                              onChanged: (country) {
                                                setState(() {
                                                  selectedCountry = country;
                                                });
                                              },
                                              initialSelection:
                                                  selectedCountry.code,
                                              favorite: const ['LK', 'US'],
                                              showCountryOnly: true,
                                              showOnlyCountryWhenClosed: true,
                                              alignLeft: false,
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              fetchData('filter');
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
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
                            showList.isEmpty
                                ? const NoResultFondMes()
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: relativeHeight * 16,
                                      // horizontal: relativeWidth * 8,
                                    ),
                                    child: GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: showList.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio:
                                                  (relativeWidth * 100) /
                                                      (relativeHeight * 175),
                                              // mainAxisExtent: relativeWidth * 400,
                                              crossAxisSpacing:
                                                  relativeWidth * 10,
                                              mainAxisSpacing:
                                                  relativeHeight * 10),
                                      itemBuilder: (context, index) {
                                        return MovieCard(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              createRoute(
                                                  DetailsScreen(
                                                    selctedMovieDetails:
                                                        showList[index],
                                                  ),
                                                  TransitionType.rightToLeft),
                                            );
                                          },
                                          index: index,
                                          movieDetails: showList,
                                          onPressedWish: () {
                                            addIdToWishList(showList[index]
                                                    ['id']
                                                .toString());
                                            showSuccessDialog(
                                              context,
                                              'Successfully added to wishlist',
                                              'Okay',
                                              () => Navigator.of(context).pop(),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )
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
