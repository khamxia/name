import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:meesooklife_app/screen/model/history_model.dart';
import 'package:meesooklife_app/constant/routes.dart' as user_route;
import '../services/post_history.dart';
import '../utilities/login_sharepref.dart';

class HistoryProvider extends ChangeNotifier {
  // HistoryModel? _historyModel;
  // List<Datum>? _datas = [];
  int _currentIndex = 0;
  HistoryModel? _historyModelCompleted;
  List<Datum>? _datasCompleted = [];
  HistoryModel? _historyModelCanceled;
  List<Datum>? _datasCanceled = [];
  bool _isLoadingCompleted = false;

  List<Datum>? get getdatasCompleted => _datasCompleted;
  HistoryModel? get gethistoryModelCompleted => _historyModelCompleted;
  List<Datum>? get getdatasCanceled => _datasCanceled;
  HistoryModel? get gethistoryModelCancel => _historyModelCanceled;
  int get getcurrentIndex => _currentIndex;
  bool get getisLoadingCompleted => _isLoadingCompleted;

  set setcurrentIndex(int currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }

  Future<void> setHistoryCompleted(BuildContext context) async {
    // Navigator.pushNamed(context, user_route.Route.loading);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({"status": 'completed'});
    if (accesstoken.isNotEmpty) {
      _historyModelCompleted = await history(context, accesstoken, payload);
      if (_historyModelCompleted != null) {
        _datasCompleted = _historyModelCompleted!.data;
      }
    }
    notifyListeners();
  }

  Future<void> setHistoryCanceled(BuildContext context) async {
    // Navigator.pushNamed(context, user_route.Route.loading);
    String? accesstoken = await LoginSharePref().getTokenResponse();
    String payload = jsonEncode({"status": 'cancel'});
    if (accesstoken.isNotEmpty) {
      _historyModelCanceled = await history(context, accesstoken, payload);
      if (_historyModelCanceled != null) {
        _datasCanceled = _historyModelCanceled!.data;
      }
    }
    notifyListeners();
  }

  void clearHistory() {
    _datasCompleted!.clear();
    _datasCanceled!.clear();
    notifyListeners();
  }
}
