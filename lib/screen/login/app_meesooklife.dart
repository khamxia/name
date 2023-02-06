import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:meesooklife_app/screen/dashboard/dashboard_page.dart';
import 'package:meesooklife_app/screen/login/meesooklife_login.dart';
import 'package:meesooklife_app/screen/offline/offline_page.dart';
import 'package:meesooklife_app/utilities/login_sharepref.dart';
import 'package:provider/provider.dart';

class AppMeesookLife extends StatefulWidget {
  const AppMeesookLife({super.key});

  @override
  State<AppMeesookLife> createState() => _AppMeesookLifeState();
}

class _AppMeesookLifeState extends State<AppMeesookLife> {
  ConnectivityResult _connectivityResult = ConnectivityResult.wifi;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool checkOnline = true;

  @override
  void initState() {
    initialization();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      _updateConnectionStatus(event);
    });
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.wifi;
    try {
      result = await _connectivity.checkConnectivity();
      setState(() {
        if (result != ConnectivityResult.none) {
          checkOnline = true;
        } else {
          checkOnline = false;
        }
      });
    } catch (e) {
      debugPrint('Count not get connectivity. $e');
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectivityResult = result;
    });
    if (_connectivityResult != ConnectivityResult.none) {
      await context.read<LoginProvider>().setUserDashboard(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: checkOnline == true
          ? FutureBuilder(
              future: LoginSharePref().getTokenResponse(),
              builder: (context, snapshot) {
                print('data ${snapshot.data}');
                // if (snapshot.data == null) {
                //   return LoadingPage();
                // } else {
                  if (snapshot.data != '') {
                    return DashboardPage();
                  } else {
                    return MeesookLifeLogin();
                  }
               // }
              },
            )
          : OfflinePage(onPressed: () {
              setState(() {
                initConnectivity();
                _connectivitySubscription =
                    _connectivity.onConnectivityChanged.listen((event) {
                  _updateConnectionStatus(event);
                });
              });
            }),
    );
  }
}
