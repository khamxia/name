import 'package:flutter/cupertino.dart';
import 'package:meesooklife_app/screen/dashboard/dashboard_page.dart';
import 'package:meesooklife_app/screen/history/history_page.dart';
import 'package:meesooklife_app/screen/login/meesooklife_login.dart';
import 'package:meesooklife_app/screen/products/components/product_all.dart';
import 'package:meesooklife_app/screen/products/product_page.dart';
import 'package:meesooklife_app/screen/profile/profile.dart';
import 'package:meesooklife_app/screen/store/store_detail/update_profile.dart';
import 'package:meesooklife_app/screen/store/store_page.dart';
import 'package:meesooklife_app/screen/store/store_product/store_product.dart';
import 'package:meesooklife_app/screen/wallet/wallet_page.dart';
import '../screen/products/components/product_by_branch.dart';
import '../screen/store/store_detail/store_detail_page.dart';
import '../screen/store/store_detail/update_rqcode.dart';
import '../screen/store/store_order_success/store_order_success.dart';
import '../screen/store/store_ordering/store_ordering.dart';
import '../screen/store/store_sale/store_sale.dart';
import '../widget/loading.dart';

class Route {
  static const loading = '/loading';
  static const login = '/login';
  static const logout = '/logout';
  static const profile = '/profile';
  static const walletpage = '/walletpage';
  static const productpage = '/productpage';
  static const storepage = '/storepage';
  static const productsall = '/productsall';
  static const storedetailpage = '/storedetailpage';
  static const storesaller = '/storesaller';
  static const updatebranchprofile = '/updatebranchprofile';
  static const updateqrcode = '/updateqrcode';
  static const storeordering = '/storeordering';
  static const storeordersuccess = '/storeordersuccess';
  static const productbybranch = '/productbybranch';
  static const storeproductremain = '/storeproductremain';


  static Map<String, WidgetBuilder> getAllRoute() => _routes;

  static final Map<String, WidgetBuilder> _routes = {
    '/loading': (context) => const LoadingPage(),
    '/login': (context) => const DashboardPage(),
    '/logout': (context) => const MeesookLifeLogin(),
    '/profile': (context) => const Profile(),
    '/walletpage': (context) => const WalletPage(),
    '/productpage': (context) => const ProductPage(),
    '/storepage': (context) => const StorePage(),
    '/productsall': (context) => const ProductAll(),
    '/storedetailpage': (context) => const StoreDetailPage(),
    '/storesaller': (context) => const StoreSale(),
    '/updatebranchprofile': (context) => const UpdateBranchProfile(),
    '/updateqrcode': (context) => const UpdateQRCode(),
    '/storeordering': (context) => const StoreOrdering(),
    '/storeordersuccess': (context) => const StoreOrderSuccess(),
    '/productbybranch': (context) => const ProductByBranch(),
    '/storeproductremain': (context) => const StoreProductAll(),
  };
}
