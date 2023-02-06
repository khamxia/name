import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meesooklife_app/screen/model/branch_products_model.dart';
import 'package:meesooklife_app/constant/routes.dart' as user_route;
import 'package:meesooklife_app/screen/model/member_model.dart';
import 'package:meesooklife_app/screen/model/order_model.dart';
import 'package:meesooklife_app/screen/model/success_model.dart';
import 'package:meesooklife_app/services/branch_close_open.dart';
import 'package:meesooklife_app/services/get_member.dart';
import 'package:meesooklife_app/services/get_order_success.dart';
import 'package:meesooklife_app/services/get_ordering.dart';
import 'package:meesooklife_app/services/get_top_branch_product.dart';
import 'package:meesooklife_app/services/post_branch_confirm_order.dart';
import 'package:meesooklife_app/services/post_order_canecl.dart';

import '../services/get_branch_products.dart';
import '../services/post_update_user_image.dart';
import '../utilities/login_sharepref.dart';

class StoreProvider extends ChangeNotifier {
  BranchProductsModel? _branchProductsModel;
  List<Product> _products = [];
  int _amount = 0;
  double _total = 0;
  SuccessModel? _successModel;
  OrderModel? _orderModel;
  List<Order> _orders = [];
  BranchProductsModel? _topBranchProductsModel;
  List<Product> _topProducts = [];
  MemberModel? _memberModel;
  List<Member> _members = [];
  OrderModel? _orderSuccessModel;
  List<Order> _orderSuccess = [];

  BranchProductsModel? get getbranchProductsModel => _branchProductsModel;
  List<Product> get getproducts => _products;
  int get getamount => _amount;
  double get gettotal => _total;
  SuccessModel? get getupdateuserProfileSuccess => _successModel;
  OrderModel? get getorderingModel => _orderModel;
  List<Order> get getorders => _orders;
  BranchProductsModel? get gettopBranchProductsModel => _topBranchProductsModel;
  List<Product> get gettopProducts => _topProducts;
  MemberModel? get getmemberModel => _memberModel;
  List<Member> get getmembers => _members;
  OrderModel? get getorderSuccessModel => _orderSuccessModel;
  List<Order> get getorderSuccess => _orderSuccess;

  set setAmount(int amount) {
    _amount = amount;
    notifyListeners();
  }

  set setTotal(double total) {
    _total = total;
    notifyListeners();
  }

  //////////////// get branch products
  Future<void> setBranchProductsModel(BuildContext context) async {
    Navigator.pushNamed(context, user_route.Route.loading);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      // ignore: use_build_context_synchronously
      _branchProductsModel = await branchProducts(context, accesstoken);
      if (_branchProductsModel != null) {
        _products = _branchProductsModel!.products;
        Navigator.pushNamed(context, user_route.Route.storesaller)
            .then((value) {
          Navigator.pop(context);
        });
      }
    }
    notifyListeners();
  }

  Future<void> setUpdateUserP(BuildContext context, File newfiles) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _successModel = await updateUserImage(context, accesstoken, newfiles);
    }
    notifyListeners();
  }

  Future<void> setOrdering(BuildContext context) async {
    // Navigator.pushNamed(context, user_route.Route.loading);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _orderModel = await ordering(context, accesstoken);
      if (_orderModel != null) {
        _orders = _orderModel!.orders;

        //     .then((value) {
        //   Navigator.pop(context);
        // });
        // Navigator.pop(context);
      }
    }
    notifyListeners();
  }

  Future<void> setBranchConfirmOrder(BuildContext context, String id) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({'order_id': id});
    if (accesstoken.isNotEmpty) {
      _successModel = await branchConfirmOrder(context, accesstoken, payload);
      if (_successModel != null) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
    notifyListeners();
  }

  Future<void> setOrderSuccess(BuildContext context) async {
    // Navigator.pushNamed(context, user_route.Route.loading);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _orderSuccessModel = await orderSuccess(context, accesstoken);
      if (_orderSuccessModel != null) {
        _orderSuccess = _orderSuccessModel!.orders;

        //     .then((value) {
        //   Navigator.pop(context);
        // });
        // Navigator.pop(context);

      }
    }
    notifyListeners();
  }

  Future<void> updateOrdering(BuildContext context) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _orderModel = await ordering(context, accesstoken);
      if (_orderModel != null) {
        _orders = _orderModel!.orders;
      }
    }
    notifyListeners();
  }

  Future<void> setOrderCanecl(BuildContext context, String orderid) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({'order_id': orderid});
    if (accesstoken.isNotEmpty) {
      _successModel = await orderCanecl(context, accesstoken, payload);
      if (_successModel != null) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
    notifyListeners();
  }

  Future<void> setTopBranchProduct(BuildContext context) async {
    // Navigator.pushNamed(context, user_route.Route.loading);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _topBranchProductsModel = await topBranchProduct(context, accesstoken);
      if (_topBranchProductsModel != null) {
        _topProducts = _topBranchProductsModel!.products;
      }
    }
    notifyListeners();
  }

  //////////////// get branch products
  Future<void> setBranchRemainProducts(BuildContext context) async {
    Navigator.pushNamed(context, user_route.Route.loading);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      // ignore: use_build_context_synchronously
      _branchProductsModel = await branchProducts(context, accesstoken);
      if (_branchProductsModel != null) {
        _products = _branchProductsModel!.products;
        Navigator.pushNamed(context, user_route.Route.storeproductremain)
            .then((value) {
          Navigator.pop(context);
        });
      }
    }
    notifyListeners();
  }

  Future<void> setUseMember(BuildContext context) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _memberModel = await usemember(context, accesstoken);
      if (_memberModel != null) {
        _members = _memberModel!.members;
      }
    }
    notifyListeners();
  }

  Future<void> setBranchCloseOnpen(BuildContext context) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({});
    if (accesstoken.isNotEmpty) {
      await branchCloseOpen(context, accesstoken, payload);
    }
    notifyListeners();
  }
}
