import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:meesooklife_app/screen/model/success_model.dart';
import 'package:meesooklife_app/screen/model/wallet_model.dart';
import 'package:meesooklife_app/constant/routes.dart' as user_route;
import 'package:meesooklife_app/services/branch_set_payment.dart';
import 'package:meesooklife_app/services/user_wallet.dart';
import 'package:meesooklife_app/utilities/calculate_price.dart';
import '../services/user_send_payment.dart';
import '../utilities/login_sharepref.dart';
import '../widget/alert_diog/upload_loading.dart';

class WalletProvider extends ChangeNotifier {
  WalletsModels? _userwalletrModel;
  List<UserWalletHistory>? _userWalletHistory = [];
  SuccessModel? _successModel;
  int index = 0;
  WalletsModels? _branchwalletrModel;
  List<UserWalletHistory>? _branchWalletHistory = [];

  WalletsModels? get getuserwalletModel => _userwalletrModel;
  List<UserWalletHistory>? get getuserWalletHistory => _userWalletHistory;
  int get getindex => index;
  WalletsModels? get getbranchrwalletModel => _branchwalletrModel;
  List<UserWalletHistory>? get getbranchWalletHistory => _branchWalletHistory;

  set setindex(int index) {
    this.index = index;
    notifyListeners();
  }

  Future<void> setUserWallet(BuildContext context) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();

    ///// ສົ່ງເງິນທັງໝົດຂອງທ່ານ
    String payload = jsonEncode({'status': 3});

    if (accesstoken.isNotEmpty) {
      _userwalletrModel = await userswallets(context, accesstoken, payload);
      if (_userwalletrModel != null) {
        _userWalletHistory = _userwalletrModel!.userWalletHistory;
      }
    }
    notifyListeners();
  }

  Future<void> setBranchWallet(BuildContext context) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();

    /// ສາຄາສົ່ງເງິນ
    String payload = jsonEncode({'status': 2});

    if (accesstoken.isNotEmpty) {
      _branchwalletrModel = await userswallets(context, accesstoken, payload);
      if (_branchwalletrModel != null) {
        _branchWalletHistory = _branchwalletrModel!.userWalletHistory;
      }
    }
    notifyListeners();
  }

  Future<void> setUserPayment(BuildContext context, int money) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({'money': money.toString()});
    if (accesstoken.isNotEmpty) {
      _successModel = await userPayment(context, accesstoken, payload);
      if (_successModel != null) {
        showMessageSuccess(context, 'ການສົ່ງເງິນສຳເລັດແລ້ວ');
        Navigator.pop(context);
      }
    }
    notifyListeners();
  }

  Future<void> setBranchsetPayment(
      BuildContext context, int moneys, File files) async {
    final key = GlobalKey<State>();
    LoadingDialog.showLoading(context, key);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _successModel =
          await branchsetPayment(context, accesstoken, moneys, files);
      if (_successModel != null) {
        showMessageSuccess(context, 'ການສົ່ງເງິນສຳເລັດແລ້ວ');
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }
    notifyListeners();
  }
}
