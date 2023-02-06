import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/business_provider/history_provider.dart';
import 'package:meesooklife_app/business_provider/payment_provider.dart';
import 'package:meesooklife_app/business_provider/profile_provider.dart';
import 'package:meesooklife_app/business_provider/wallet_provider.dart';
import 'package:meesooklife_app/constant/size.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:meesooklife_app/business_provider/products_provider.dart';
import 'package:meesooklife_app/business_provider/store_provider.dart';
import 'package:meesooklife_app/screen/login/app_meesooklife.dart';
import 'package:provider/provider.dart';
import 'constant/routes.dart' as user_route;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MeesookLifeApp());
}

class MeesookLifeApp extends StatelessWidget {
  const MeesookLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StoreProvider>(
            create: (context) => StoreProvider()),
        ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider()),
        ChangeNotifierProvider<ProductsProvider>(
            create: (context) => ProductsProvider()),
        ChangeNotifierProvider<PaymentProvider>(
            create: (context) => PaymentProvider()),
        ChangeNotifierProvider<ProfileProvider>(
            create: (context) => ProfileProvider()),
        ChangeNotifierProvider<WalletProvider>(
            create: (context) => WalletProvider()),
        ChangeNotifierProvider<HistoryProvider>(
            create: (context) => HistoryProvider()),
      ],
      child: ScreenUtilInit(
        designSize: MeesooklifeSize.defaultSize,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            title: 'MSL4289',
            routes: user_route.Route.getAllRoute(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'NotoSans'),
            home: const AppMeesookLife(),
          );
          //   },
          // );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
