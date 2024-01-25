import 'dart:async';
import 'dart:convert';
import 'package:html/parser.dart' show parse;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_bucket_list/globle/staus/connection.dart';

import '../components/common/backbutton.dart';
import '../components/common/default_text.dart';
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

  dynamic converter() {
    var document = parse(widget.selctedMovieDetails['_embedded']['show']['summary']);
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          // ignore: prefer_const_constructors
                          colorR: const Color.fromRGBO(25, 30, 29, 1),
                          content: widget.selctedMovieDetails['name'],
                          fontSizeR: 24,
                          fontWeightR: FontWeight.w600,
                          textAlignR: TextAlign.start,
                        ),
                        SizedBox(
                          height: relativeHeight * 10,
                        ),
                        DefaultText(
                          colorR: const Color.fromRGBO(25, 30, 29, 1),
                          content: converter(),
                          fontSizeR: 16,
                          fontWeightR: FontWeight.w400,
                          textAlignR: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: DefaultFloatingButton(
      //   price: double.parse(state.currentPrice).toStringAsFixed(2),
      //   onPressed: () {
      //     if (mounted) {
      //       StoreProvider.of<ApplicationState>(context).dispatch(
      //         AssignEditOrNot(
      //           isEdit: false,
      //         ),
      //       );
      //       Navigator.pushNamed(context, '/addCart');
      //     }
      //   },
      //   routeName: 'ADD CART',
      // ),
    );
  }
}
