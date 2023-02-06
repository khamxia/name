import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/constant/font.dart';
import 'package:meesooklife_app/screen/store/store_order_success/store_order_success_detail.dart';
import 'package:provider/provider.dart';
import '../../../business_provider/store_provider.dart';
import '../../../constant/my_colors.dart';
import '../../../constant/theme.dart';
import '../../../widget/billno.dart';

class StoreOrderSuccess extends StatefulWidget {
  const StoreOrderSuccess({super.key});

  @override
  State<StoreOrderSuccess> createState() => _StoreOrderSuccessState();
}

class _StoreOrderSuccessState extends State<StoreOrderSuccess> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ການສັ່ງຊື້ສຳເລັດແລ້ວ',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
        ),
        body: Consumer<StoreProvider>(
          builder: (context, storemodel, _) {
            return storemodel.getorderSuccessModel != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: storemodel.getorderSuccess.isNotEmpty
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  buildExpan('ເລກບິນ'),
                                  buildExpan('ຈຳນວນ'),
                                  buildExpan('ລາຄາລວມ'),
                                  buildExpan('ວັນທີສັ່ງຊື້'),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: const Divider(
                                  thickness: 2,
                                  color: MyColors.backgroundWeb,
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: storemodel.getorderSuccess.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return BillNo(
                                      billNo: storemodel
                                          .getorderSuccess[index].billNo
                                          .toString(),
                                      amount: NumberFormat.currency(
                                              symbol: '', decimalDigits: 0)
                                          .format(storemodel
                                              .getorderSuccess[index]
                                              .orderDetails
                                              .length),
                                      total: NumberFormat.currency(
                                              symbol: '', decimalDigits: 0)
                                          .format(storemodel
                                              .getorderSuccess[index].total),
                                      date: DateFormat('dd/MM/yyyy').format(
                                          storemodel.getorderSuccess[index]
                                              .createdAt),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  StoreOrderSuccessDetail(
                                                orderModel: storemodel
                                                    .getorderSuccess[index]
                                                    .orderDetails,
                                                totals: storemodel
                                                    .getorderSuccess[index]
                                                    .total!,
                                                userLogo: storemodel
                                                    .getorderSuccess[index]
                                                    .userImage
                                                    .toString(),
                                                userName: storemodel
                                                    .getorderSuccess[index].user
                                                    .toString(),
                                                userPhone: storemodel
                                                    .getorderSuccess[index]
                                                    .userPhone
                                                    .toString(),
                                                userprovince: storemodel
                                                    .getorderSuccess[index]
                                                    .sippingPr
                                                    .toString(),
                                                userdistrict: storemodel
                                                    .getorderSuccess[index]
                                                    .sippingDr
                                                    .toString(),
                                                uservillage: storemodel
                                                    .getorderSuccess[index]
                                                    .sippingVill
                                                    .toString(),
                                                usersipping: storemodel
                                                    .getorderSuccess[index]
                                                    .sippingName
                                                    .toString(),
                                                paymentInfo: storemodel
                                                    .getorderSuccess[index]
                                                    .paymentInfo
                                                    .toString(),
                                                billNo: storemodel
                                                    .getorderSuccess[index]
                                                    .billNo
                                                    .toString(),
                                                dateTime: storemodel
                                                    .getorderSuccess[index]
                                                    .createdAt,
                                              ),
                                            ));
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(thickness: 1);
                                  },
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Text(
                              'ບໍ່ມີຂໍ້ມູນ',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: MyColors.hintColor),
                            ),
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

  Widget buildExpan(String title) {
    return Expanded(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: MyColors.tealColor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
