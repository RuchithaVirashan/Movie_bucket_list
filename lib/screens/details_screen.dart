import 'dart:async';
import 'dart:developer';
import 'package:html/parser.dart' show parse;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_bucket_list/components/common/button.dart';
import 'package:movie_bucket_list/components/details/nameAndTime.dart';
import 'package:movie_bucket_list/globle/staus/connection.dart';
import 'package:movie_bucket_list/globle/staus/sucess.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/common/backbutton.dart';
import '../globle/constants.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> selctedMovieDetails;
  const DetailsScreen({super.key, required this.selctedMovieDetails});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var isLoading = true;
  StreamSubscription<ConnectivityResult>? subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  int initLevel = 0;
  bool showedDialog = false;

  List showList = [];

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

  Future<void> addIdToWishList(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String idList = prefs.getString('idList') ?? '';
    List<String> idsToWL = idList.split(',');
    if (!idsToWL.contains(id)) {
      idsToWL.add(id);
      showSuccessDialog(
        context,
        'Successfully added to wishlist',
        'Okay',
        () => Navigator.of(context).pop(),
      );
    } else {
      showSuccessDialog(
        context,
        'Alredy added',
        'Okay',
        () => Navigator.of(context).pop(),
      );
    }
    idList = idsToWL.join(',');
    log('list $idList');
    await prefs.setString('idList', idList);
  }

  dynamic converter() {
    var document =
        parse(widget.selctedMovieDetails['_embedded']['show']['summary']);
    var text = document.body?.text;
    return text;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            pinned: false,
            floating: false,
            backgroundColor: Colors.transparent,
            expandedHeight: relativeHeight * 494,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.selctedMovieDetails['_embedded']['show']['image'] != null
                    ? widget.selctedMovieDetails['_embedded']['show']['image']
                        ['medium']
                    : 'https://eticketsolutions.com/demo/themes/e-ticket/img/movie.jpg',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            leading: const BackButtonWidget(),
            title: Padding(
              padding: EdgeInsets.only(left: relativeWidth * 20),
              child: const Text(
                '',
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        top: relativeHeight * 30,
                        left: relativeWidth * 36,
                        right: relativeWidth * 36,
                      ),
                      child: NameAndTimeWidget(
                        name: widget.selctedMovieDetails['name'],
                        summary: converter(),
                        date: widget.selctedMovieDetails['airdate'],
                        time: widget.selctedMovieDetails['_embedded']['show']
                                    ['runtime'] !=
                                null
                            ? widget.selctedMovieDetails['_embedded']['show']
                                    ['runtime']
                                .toString()
                            : '-- . --',
                        rate: widget.selctedMovieDetails['_embedded']['show']
                                    ['rating']['average'] !=
                                null
                            ? '${widget.selctedMovieDetails['_embedded']['show']['rating']['average'].toString()} / 10'
                            : '-- / 10',
                        genres: widget.selctedMovieDetails['_embedded']['show']
                                    ['genres'] !=
                                null
                            ? widget.selctedMovieDetails['_embedded']['show']
                                ['genres']
                            : ['Not Specified'],
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      top: relativeHeight * 30,
                      bottom: relativeHeight * 30,
                      left: relativeWidth * 150,
                      right: relativeWidth * 36,
                    ),
                    child: ButtonWidget(
                      onPressed: () async {
                        addIdToWishList(
                            widget.selctedMovieDetails['id'].toString());
                      },
                      buttonName: 'Add to WishList',
                      tcolor: Colors.red,
                      bcolor: Color(0xFF154478),
                      borderColor: Colors.grey,
                      radius: 8,
                      fcolor: Colors.white,
                      minHeight: relativeHeight * 60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
