import 'package:flutter/material.dart';
import 'package:meesooklife_app/business_provider/products_provider.dart';
import 'package:provider/provider.dart';

Future<void> minuscalculateMyAmount(BuildContext context, int money) async {
  int amount = context.read<ProductsProvider>().getPrAmount;
  int myMoney = 0;
  int newamount = context.read<ProductsProvider>().getAmount;
  newamount++;
  if (amount > 0 && newamount > 0) {
    amount--;
    myMoney = newamount * money;
  }
  context.read<ProductsProvider>().setPrAmount = amount;
  context.read<ProductsProvider>().setTotal = myMoney.toDouble();
  context.read<ProductsProvider>().setAmount = newamount;
}

Future<void> plusCalculationMyAmount(
    BuildContext context, int money, int amounts) async {
  int amount = context.read<ProductsProvider>().getPrAmount;
  int myMoney = 0;
  int newamount = context.read<ProductsProvider>().getAmount;

  if (amount < amounts) {
    amount++;
    myMoney = newamount * money;
    newamount--;
  }
  context.read<ProductsProvider>().setPrAmount = amount;
  context.read<ProductsProvider>().setTotal = myMoney.toDouble();
  context.read<ProductsProvider>().setAmount = newamount;
}
