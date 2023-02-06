import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:meesooklife_app/database/store_database/sqilte_store_database.dart';
import 'package:meesooklife_app/database/store_database/sqlite_store_model.dart';
import 'package:meesooklife_app/database/user_database/sqlite_model.dart';
import 'package:meesooklife_app/screen/model/address_model.dart';
import 'package:meesooklife_app/screen/model/bank_qrcode.dart';
import 'package:meesooklife_app/screen/model/exprese_model.dart';
import 'package:meesooklife_app/screen/model/success_model.dart';
import 'package:meesooklife_app/services/exprese.dart';
import 'package:meesooklife_app/services/post_bank_qrcode.dart';
import 'package:meesooklife_app/services/post_branch_check_out.dart';
import 'package:meesooklife_app/utilities/calculate_price.dart';
import 'package:meesooklife_app/widget/alert_diog/upload_loading.dart';

import '../constant/image.dart';
import '../database/user_database/sqlite_database.dart';
import '../services/get_address.dart';
import '../services/post_user_check_out.dart';
import '../utilities/login_sharepref.dart';
import '../widget/alert_diog/alert_diog_cancel_success.dart';

class PaymentProvider extends ChangeNotifier {
  BankRqCodeModel? _bankRqCodeModel;
  BranchPayment? _branchPayment;
  AddressModel? _addressModel;
  List<Province>? _provinceList = [];
  String _bankAcount = '';
  ExpreseModel? _expreseModel;
  List<Exprese> _expreseList = [];
  SuccessModel? _successModel;
  int _amount = 0;
  List<SQLiteModel> _sqliteModel = [];
  List<SqliteStoreModel> _sqliteStoreModel = [];
  int _totalPrice = 0;
  int _storeTotalPrice = 0;
  SuccessModel? _userPayementSuccess;

  BankRqCodeModel? get getBankRqCodeModel => _bankRqCodeModel;
  BranchPayment? get getBranchPayment => _branchPayment;
  AddressModel? get getAddressModel => _addressModel;
  List<Province>? get getProvinceList => _provinceList;
  String get getBankAcount => _bankAcount;
  ExpreseModel? get getExpreseModel => _expreseModel;
  List<Exprese> get getExpreseList => _expreseList;
  SuccessModel? get getSuccessModel => _successModel;
  int get getpayAmount => _amount;
  List<SQLiteModel> get getSqliteModel => _sqliteModel;
  List<SqliteStoreModel> get getSqliteStoreModel => _sqliteStoreModel;
  int get getTotalPrice => _totalPrice;
  int get getStoreTotalPrice => _storeTotalPrice;
  SuccessModel? get getUserPayementSuccess => _userPayementSuccess;

  set setpayAmount(int amount) {
    _amount = amount;
    notifyListeners();
  }

  set setSqliteModel(List<SQLiteModel> sqliteModel) {
    _sqliteModel = sqliteModel;
    notifyListeners();
  }

  set setTotalPrice(int totalPrice) {
    _totalPrice = totalPrice;
    notifyListeners();
  }

  set setStoreTotalPrice(int storeTotalPrice) {
    _storeTotalPrice = storeTotalPrice;
    notifyListeners();
  }

  Future<void> setBankRqCode(BuildContext context, int brancId) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({'branch_id': brancId});
    if (accesstoken.isNotEmpty) {
      _bankRqCodeModel = await bankQRCode(context, accesstoken, payload);
      if (_bankRqCodeModel != null) {
        _branchPayment = _bankRqCodeModel!.branchPayment;
        if (_branchPayment != null) {
          _bankAcount = _branchPayment!.bceloneNumber.toString();
        }
      }
    }
    notifyListeners();
  }

  /////////// address
  Future<void> setAddress(BuildContext context) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _addressModel = await addressModel(context, accesstoken);
      if (_addressModel != null) {
        _provinceList = _addressModel!.province;
        setExprese(context);
      }
    }
    notifyListeners();
  }

  Future<void> setExprese(BuildContext context) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _expreseModel = await exprese(context, accesstoken);
      if (_expreseModel != null) {
        _expreseList = _expreseModel!.exprese;
      }
    }
    notifyListeners();
  }

  Future<void> setUserCheckOut(
      BuildContext context,
      int expid,
      int bid,
      double total,
      int prId,
      int did,
      int vid,
      List<Map<String, dynamic>> map,
      File files) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    final key = GlobalKey<State>();
    LoadingDialog.showLoading(context, key);
    if (accesstoken.isNotEmpty) {
      _successModel = await userCheckOut(
          context, accesstoken, expid, bid, total, prId, did, vid, map, files);
      if (_successModel != null) {
        // alertdiogcancelsuccess(
        //     context: context,
        //     title: 'ການຊຳລະສຳເລັດແລ້ວ',
        //     image: MyImages.success);
        showMessageSuccess(context, 'ການສັ່ງຊື້ສຳເລັດແລ້ວ');
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        alertdiogcancelsuccess(
                context: context,
                title: 'ຂໍອະໄພເກີດຂໍ້ຜິດພາດ ການຊຳລະບໍ່ສຳເລັດ',
                image: MyImages.erroricon)
            .then((value) {
          Navigator.pop(context);
        });
      }
    }
    notifyListeners();
  }

  //////// read data form sqlite
  Future<void> sqliteRead(BuildContext context) async {
    _sqliteModel = await SQLiteHelper().readData();
    _totalPrice = 0;
    for (var i in _sqliteModel) {
      String sum = i.total.toString();
      _totalPrice = _totalPrice + int.parse(sum);
    }
    notifyListeners();
  }

  Future<void> sqliteDelete(BuildContext context, int id) async {
    await SQLiteHelper().deleteData(id).then((value) {
      print('success delete');
    });
    notifyListeners();
  }

  Future<void> setUserPayment(
      BuildContext context,
      int expId,
      int brId,
      double total,
      int pId,
      int disId,
      int villId,
      List<Map<String, dynamic>> maps,
      File qrfiles) async {
    final key = GlobalKey<State>();
    LoadingDialog.showLoading(context, key);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _userPayementSuccess = await userCheckOut(context, accesstoken, expId,
          brId, total, pId, disId, villId, maps, qrfiles);
      if (_userPayementSuccess != null) {
        // ignore: use_build_context_synchronously
        showMessageSuccess(context, 'ການສັ່ງຊື້ສຳເລັດແລ້ວ');
        await SQLiteHelper().deleteAllData();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
    notifyListeners();
  }

  ///////// read data form sqlite for store
  Future<void> setreadDataFormSqliteStore(BuildContext context) async {
    _sqliteStoreModel = await SQLiteStoreHelper().readData();
    _storeTotalPrice = 0;
    for (var i in _sqliteStoreModel) {
      String storesum = i.total.toString();
      _storeTotalPrice = _storeTotalPrice + int.parse(storesum);
    }
    notifyListeners();
  }

  Future<void> sqliteStoreDeletes(BuildContext context, int id) async {
    await SQLiteStoreHelper().deleteStoreData(id).then((value) {});
    notifyListeners();
  }

  Future<void> sqliteStoreDeleteAll(BuildContext context) async {
    await SQLiteStoreHelper().deleteAllData().then((value) {
      print('ddddddddd');
    });
    notifyListeners();
  }

  Future<void> setBranchCheckoutLast(BuildContext context, int userId, int brId,
      int total, String paymentStatus, List<Map<String, dynamic>> maps) async {
    final key = GlobalKey<State>();
    LoadingDialog.showLoading(context, key);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({
      'user_id': userId,
      'branch_id': brId,
      'total': total,
      'payment_status': paymentStatus,
      'items': maps
    });
    if (accesstoken.isNotEmpty) {
      _successModel = await branchCheckOut(context, accesstoken, payload);
      if (_successModel != null) {
        await SQLiteStoreHelper().deleteAllData();
        // ignore: use_build_context_synchronously
        showMessageSuccess(context, 'ການສັ່ງຊື້ສຳເລັດແລ້ວ');
        await SQLiteHelper().deleteAllData();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }
    notifyListeners();
  }
}
