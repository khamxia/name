import 'package:flutter/cupertino.dart';
import 'package:meesooklife_app/business_provider/store_provider.dart';
import 'package:provider/provider.dart';

Future<void> bMinusCalculation(BuildContext context, int money) async {
  int amount = context.read<StoreProvider>().getamount;
  int myMoney = 0;
  if (amount > 0) {
    amount--;
    myMoney = amount * money;
  }
  context.read<StoreProvider>().setAmount = amount;
  context.read<StoreProvider>().setTotal = myMoney.toDouble();
}

Future<void> bPlusCalculation(BuildContext context, int money) async {
  int amount = context.read<StoreProvider>().getamount;
  int myMoney = 0;

  amount++;
  myMoney = amount * money;
  context.read<StoreProvider>().setAmount = amount;
  context.read<StoreProvider>().setTotal = myMoney.toDouble();
}
