import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:meesooklife_app/screen/model/connect_token_model.dart';
import 'package:meesooklife_app/constant/routes.dart' as user_route;
import 'package:meesooklife_app/utilities/login_sharepref.dart';
import '../screen/model/user_dashboard_model.dart';
import '../services/connect_token.dart';
import '../services/get_user_dashboard.dart';

class LoginProvider extends ChangeNotifier {
  String _accessToken = '';
  UserDashBoardModel? _userDashBoardModel;
  List<UserBranch?>? _userBranch = [];

  /////////////// user_profile
  String _fname = '';
  String _lname = '';
  String _image = '';
  int _numberPhone = 0;
  String _village = '';
  String _district = '';
  String _province = '';
  /////////////// user money
  int _moneybuy = 0;
  int _moneysale = 0;
  /////////////// user branch
  int _bId = 0;
  String _branchName = '';
  String _branchLogo = '';
  String _branchQR = '';
  String _bProvince = '';
  String _bDistrict = '';
  String _bVillage = '';
  int _bProduct = 0;
  String _bStok = '';
  int _bOrdering = 0;
  int _bOrdered = 0;
  int _bBankAcount = 0;
  int _bStatus = 0;

  String get getAccessToken => _accessToken;
  UserDashBoardModel? get getUserDashBoardModel => _userDashBoardModel;
  List<UserBranch?>? get getUserBranch => _userBranch;
  /////////  user_profile
  String get getFname => _fname;
  String get getLname => _lname;
  String get getImage => _image;
  int get getNumberPhone => _numberPhone;
  String get getVillage => _village;
  String get getDistrict => _district;
  String get getProvince => _province;
  ///////// user money
  int get getMoneyBuy => _moneybuy;
  int get getMoneySale => _moneysale;
  //////// user branch
  int get getBId => _bId;
  String get getBranchName => _branchName;
  String get getBranchLogo => _branchLogo;
  String get getBranchQR => _branchQR;
  String get getBProvince => _bProvince;
  String get getBDistrict => _bDistrict;
  String get getBVillage => _bVillage;
  int get getBProduct => _bProduct;
  String get getBStok => _bStok;
  int get getBOrdering => _bOrdering;
  int get getBOrdered => _bOrdered;
  int get getBBankAcount => _bBankAcount;
  int get getBStatus => _bStatus;
  ////////////
  ///
  set setFName(String fname) {
    _fname = fname;
    notifyListeners();
  }

  set setLName(String lname) {
    _lname = lname;
    notifyListeners();
  }

  set setPhone(int phone) {
    _numberPhone = phone;
    notifyListeners();
  }

  set setBranchName(String branchName) {
    _branchName = branchName;
    notifyListeners();
  }

  Future<void> setConnectTokenModel(
      BuildContext context, String phone, String password) async {
    Navigator.pushNamed(context, user_route.Route.loading);
    String payload = jsonEncode({'phone': phone, 'password': password});
    ConnectTokenModel? connectTokenModel = await connectToken(context, payload);
    if (connectTokenModel != null) {
      _accessToken = connectTokenModel.token.toString();
      //String data = connectTokenModelToJson(connectTokenModel);

      await LoginSharePref()
          .setTokenResponse(connectTokenModel.token.toString());
      setUserDashboard(context);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, user_route.Route.login).then((value) {
        Navigator.pop(context);
      });
    }
    notifyListeners();
  }

  Future<void> setUserDashboard(BuildContext context) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    // ConnectTokenModel? connectTokenModel =
    //     connectTokenModelFromJson(accesstoken);
    if (accesstoken.isNotEmpty) {
      _userDashBoardModel = await userDashboard(context, accesstoken);
      if (_userDashBoardModel != null) {
        _userBranch = _userDashBoardModel!.userBranch;
        for (var i in _userDashBoardModel!.userProfile) {
          _fname = i.name.toString();
          _lname = i.lastName.toString();
          _image = i.profileImage!;
          _numberPhone = i.phone!;
          _village = i.villName.toString();
          _district = i.drName.toString();
          _province = i.prName.toString();
        }
        for (var j in _userDashBoardModel!.userMoney) {
          _moneybuy = j.moneyBuy!;
          _moneysale = j.moneySale!;
        }
        for (var k in _userDashBoardModel!.userBranch) {
          _bId = k.id!;
          _branchName = k.branchName.toString();
          _branchLogo = k.branchLogo.toString();
          _branchQR = k.branchQrcode.toString();
          _bProvince = k.branchProvince.toString();
          _bDistrict = k.branchDistrict.toString();
          _bVillage = k.branchVillage.toString();
          _bProduct = k.branchProduct!;
          _bStok = k.branchProductInstock.toString();
          _bOrdering = k.branchOrderPending!;
          _bOrdered = k.branchOrderSuccess!;
          _bBankAcount = k.bceloneNumber!;
          _bStatus = k.branchStatus!;
        }
      }
    }
    notifyListeners();
  }

  void clearLogin() {
    _accessToken = '';
    _userDashBoardModel = null;
    notifyListeners();
  }
}
