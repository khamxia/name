import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/store_provider.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/screen/store/store_ordering/store_ordering_detail.dart';
import 'package:meesooklife_app/widget/billno.dart';
import 'package:provider/provider.dart';

import '../../../constant/font.dart';
import '../../../constant/theme.dart';

class StoreOrdering extends StatefulWidget {
  const StoreOrdering({super.key});

  @override
  State<StoreOrdering> createState() => _StoreOrderingState();
}

class _StoreOrderingState extends State<StoreOrdering> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ການສັ່ງຊື້ໃໝ່', style: appBarStyle()),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
        ),
        body: Consumer<StoreProvider>(
          builder: (context, storemodels, _) {
            return storemodels.getorderingModel != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: storemodels.getorders.isNotEmpty
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  buildExpan('ເລກບິນ'),
                                  buildExpan('ຈ/ນລາຍການ'),
                                  buildExpan('ເງິນລວມ'),
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
                                  itemCount: storemodels.getorders.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return BillNo(
                                      billNo:
                                          '${storemodels.getorders[index].billNo}',
                                      amount:
                                          '${storemodels.getorders[index].orderDetails.length}',
                                      total: NumberFormat.currency(
                                              symbol: '', decimalDigits: 0)
                                          .format(storemodels
                                              .getorders[index].total),
                                      date: DateFormat('dd/MM/yyyy').format(
                                          storemodels
                                              .getorders[index].createdAt),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  StoreOrderingDetail(
                                                orderDetail: storemodels
                                                    .getorders[index]
                                                    .orderDetails,
                                                totals: storemodels
                                                    .getorders[index].total!,
                                                logoUser: storemodels
                                                    .getorders[index].userImage
                                                    .toString(),
                                                name: storemodels
                                                    .getorders[index].user
                                                    .toString(),
                                                numberPhone: storemodels
                                                    .getorders[index].userPhone
                                                    .toString(),
                                                villName: storemodels
                                                    .getorders[index]
                                                    .sippingVill
                                                    .toString(),
                                                distName: storemodels
                                                    .getorders[index].sippingDr
                                                    .toString(),
                                                prName: storemodels
                                                    .getorders[index].sippingPr
                                                    .toString(),
                                                sippingName: storemodels
                                                    .getorders[index]
                                                    .sippingName
                                                    .toString(),
                                                orderId: storemodels
                                                    .getorders[index].id
                                                    .toString(),
                                                paymentInfo: storemodels
                                                    .getorders[index]
                                                    .paymentInfo
                                                    .toString(),
                                                billNo: storemodels
                                                    .getorders[index].billNo
                                                    .toString(),
                                                dateTime: storemodels
                                                    .getorders[index].createdAt,
                                              ),
                                            )).then((value) async {
                                          await storemodels
                                              .updateOrdering(context);
                                        });
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
                              'ບໍ່ມີຂໍ້ມູນການສັ່ງຊື້ໃໝ່',
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
