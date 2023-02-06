import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:meesooklife_app/screen/model/success_model.dart';
import 'package:meesooklife_app/utilities/calculate_price.dart';
import '../services/post_update_branch_logo.dart';
import '../services/post_update_branch_profile.dart';
import '../services/post_update_branch_qrcode.dart';
import '../services/post_update_user_profile.dart';
import '../utilities/login_sharepref.dart';
import '../widget/alert_diog/upload_loading.dart';

class ProfileProvider extends ChangeNotifier {
  SuccessModel? _successModel;

  SuccessModel? get getSuccessModel => _successModel;

  Future<void> setUpdateUserProfile(BuildContext context, String fName,
      String lName, int phone, int prId, int drId, int villId) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({
      'name': fName,
      'last_name': lName,
      'phone': phone.toString(),
      'pr_id': prId,
      'dr_id': drId,
      'vill_id': villId,
    });
    if (accesstoken.isNotEmpty) {
      _successModel = await updateUserProfile(context, accesstoken, payload);
    }
  }

  Future<void> setUpdateBranchLogo(BuildContext context, File files) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    final key = GlobalKey<State>();
    LoadingDialog.showLoading(context, key);
    if (accesstoken.isNotEmpty) {
      _successModel = await updateBranchLogo(context, accesstoken, files);
      if (_successModel != null) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> setUpdateBranchProfile(BuildContext context, String bName,
      int prId, int disId, int vilId) async {
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({
      'branch_name': bName,
      'pr_id': prId,
      'dr_id': disId,
      'vill_id': vilId
    });
    if (accesstoken.isNotEmpty) {
      _successModel = await updateBranchProfile(context, accesstoken, payload);
    }
  }

  Future<void> setUpdateBranchQRCode(
      BuildContext context, int bankAcount, File files) async {
    final key = GlobalKey<State>();
    LoadingDialog.showLoading(context, key);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    if (accesstoken.isNotEmpty) {
      _successModel =
          await updateBranchQRCode(context, accesstoken, bankAcount, files);
          
      if (_successModel != null) {
        showMessageSuccess(context, 'ອັບເດດສຳເລັດ QRCode ');
        Navigator.pop(context);
      }
    }
  }
}
