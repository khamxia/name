import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/history_provider.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/screen/history/history_billno_not_success.dart';
import 'package:meesooklife_app/screen/history/history_billno_success.dart';
import 'package:meesooklife_app/widget/tab_bar.dart';
import 'package:meesooklife_app/widget/tabbar_view.dart';
import 'package:provider/provider.dart';

import '../../constant/font.dart';
import '../../constant/image.dart';
import '../../constant/theme.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ປະຫວດການເຄື່ອນໄຫວ',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
        ),
        body: Consumer<HistoryProvider>(
          builder: (context, hismodels, _) {
            return hismodels.gethistoryModelCompleted != null ||
                    hismodels.gethistoryModelCancel != null
                ? DefaultTabController(
                    initialIndex: hismodels.getcurrentIndex,
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          indicatorColor: MyColors.tealColor,
                          onTap: (index) async {
                            hismodels.setcurrentIndex = index;
                            // hismodels.setstatus =
                            //     index == 0 ? 'completed' : 'cancel';
                            // await hismodels.setHistory(context);
                          },
                          tabs: const [
                            TabBars(title: 'ລາຍການສຳເລັດແລ້ວ'),
                            TabBars(title: 'ລາຍການຖືກຍົກເລີກ'),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                hismodels.getdatasCompleted != null
                                    ? ListView.builder(
                                        itemCount:
                                            hismodels.getdatasCompleted!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return TabBarViews(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HistoryBillNoSuccess(
                                                    orderDetail: hismodels
                                                        .getdatasCompleted![
                                                            index]
                                                        .orderDetails,
                                                    total: hismodels
                                                        .getdatasCompleted![
                                                            index]
                                                        .total
                                                        .toString(),
                                                    images: hismodels
                                                        .getdatasCompleted![
                                                            index]
                                                        .branchLogo,
                                                    userName: hismodels
                                                        .getdatasCompleted![
                                                            index]
                                                        .user,
                                                    userPhone: hismodels
                                                        .getdatasCompleted![
                                                            index]
                                                        .userPhone
                                                        .toString(),
                                                    uservillage: hismodels
                                                        .getdatasCompleted![
                                                            index]
                                                        .sippingVill,
                                                    userdistrict: hismodels
                                                        .getdatasCompleted![
                                                            index]
                                                        .sippingDr,
                                                    userprovince: hismodels
                                                        .getdatasCompleted![
                                                            index]
                                                        .sippingPr,
                                                    sipping: hismodels
                                                        .getdatasCompleted![
                                                            index]
                                                        .sippingName,
                                                    billNo: hismodels
                                                        .getdatasCompleted![
                                                            index]
                                                        .billNo
                                                        .toString(),
                                                    dateTime: hismodels
                                                        .getdatasCompleted![
                                                            index]
                                                        .createdAt,
                                                  ),
                                                ),
                                              );
                                            },
                                            widget: Center(
                                              child: Image.asset(
                                                MyImages.success,
                                                width: 50.w,
                                                height: 50.h,
                                              ),
                                            ),
                                            title:
                                                '${hismodels.getdatasCompleted![index].billNo}',
                                            subtitle: DateFormat('dd/MM/yyyy')
                                                .format(hismodels
                                                    .getdatasCompleted![index]
                                                    .createdAt),
                                            trailing:
                                                '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(hismodels.getdatasCompleted![index].total.toDouble())} ກີບ',
                                            startWay: hismodels
                                                .getdatasCompleted![index]
                                                .branchName
                                                .toString(),
                                            endWay: hismodels
                                                .getdatasCompleted![index].user
                                                .toString(),
                                          );
                                        },
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              'ຍັງບໍ່ມີຂໍ້ມູນ',
                                              style: TextStyle(
                                                  color: MyColors.hintColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                hismodels.getdatasCanceled != null
                                    ? ListView.builder(
                                        itemCount:
                                            hismodels.getdatasCanceled!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return TabBarViews(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HistoryBillNoNotSuccess(
                                                    orderDetail: hismodels
                                                        .getdatasCanceled![
                                                            index]
                                                        .orderDetails,
                                                    total: hismodels
                                                        .getdatasCanceled![
                                                            index]
                                                        .total
                                                        .toString(),
                                                    images: hismodels
                                                        .getdatasCanceled![
                                                            index]
                                                        .branchLogo,
                                                    userName: hismodels
                                                        .getdatasCanceled![
                                                            index]
                                                        .user,
                                                    userPhone: hismodels
                                                        .getdatasCanceled![
                                                            index]
                                                        .userPhone
                                                        .toString(),
                                                    uservillage: hismodels
                                                        .getdatasCanceled![
                                                            index]
                                                        .sippingVill,
                                                    userdistrict: hismodels
                                                        .getdatasCanceled![
                                                            index]
                                                        .sippingDr,
                                                    userprovince: hismodels
                                                        .getdatasCanceled![
                                                            index]
                                                        .sippingPr,
                                                    sipping: hismodels
                                                        .getdatasCanceled![
                                                            index]
                                                        .sippingName,
                                                    billNo: hismodels
                                                        .getdatasCanceled![
                                                            index]
                                                        .billNo
                                                        .toString(),
                                                    dateTime: hismodels
                                                        .getdatasCanceled![
                                                            index]
                                                        .createdAt,
                                                  ),
                                                ),
                                              );
                                            },
                                            widget: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.cancel_outlined,
                                                    color: MyColors.cancelColor,
                                                    size: 20.sp,
                                                  ),
                                                  Text(
                                                    'ຖືກຍົກເລີກແລ້ວ',
                                                    style: TextStyle(
                                                        color: MyColors
                                                            .cancelColor,
                                                        fontSize: 14.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            title:
                                                '${hismodels.getdatasCanceled![index].billNo}',
                                            subtitle: DateFormat('dd/MM/yyyy')
                                                .format(hismodels
                                                    .getdatasCanceled![index]
                                                    .createdAt),
                                            trailing:
                                                '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(hismodels.getdatasCanceled![index].total.toDouble())} ກີບ',
                                            startWay: hismodels
                                                .getdatasCanceled![index]
                                                .branchName
                                                .toString(),
                                            endWay: hismodels
                                                .getdatasCanceled![index].user
                                                .toString(),
                                          );
                                        },
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              'ຍັງບໍ່ມີຂໍ້ມູນ',
                                              style: TextStyle(
                                                  color: MyColors.hintColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: MyColors.blueColor,
                    color: MyColors.tealColor,
                  ));
          },
        ));
  }
}
