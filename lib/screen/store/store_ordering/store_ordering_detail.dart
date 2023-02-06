import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/store_provider.dart';
import 'package:meesooklife_app/constant/font.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/screen/hero/hero_page.dart';
import 'package:meesooklife_app/screen/model/order_model.dart';
import 'package:meesooklife_app/widget/store_billno_detail.dart';
import 'package:meesooklife_app/widget/text_button.dart';
import 'package:provider/provider.dart';
import '../../../constant/theme.dart';

class StoreOrderingDetail extends StatefulWidget {
  final List<OrderDetail> orderDetail;
  final int totals;
  final String logoUser;
  final String name;
  final String numberPhone;
  final String prName;
  final String distName;
  final String villName;
  final String sippingName;
  final String orderId;
  final String paymentInfo;
  final String billNo;
  final DateTime dateTime;
  const StoreOrderingDetail(
      {super.key,
      required this.orderDetail,
      required this.totals,
      required this.logoUser,
      required this.name,
      required this.numberPhone,
      required this.prName,
      required this.distName,
      required this.villName,
      required this.sippingName,
      required this.orderId,
      required this.paymentInfo,
      required this.billNo,
      required this.dateTime});

  @override
  State<StoreOrderingDetail> createState() => _StoreOrderingDetailState();
}

class _StoreOrderingDetailState extends State<StoreOrderingDetail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, storemodel, _) {
        return Scaffold(
          bottomSheet: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                    child: MSLButton(
                        text: 'ຍົກເລີກ',
                        onpressed: () async {
                          await storemodel.setOrderCanecl(
                              context, widget.orderId);
                        })),
                SizedBox(width: 5.w),
                Expanded(
                    child: MSLButton(
                        text: 'ຕົກລົງ',
                        onpressed: () async {
                          await storemodel.setBranchConfirmOrder(
                              context, widget.orderId);
                        })),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(
              'ລາຍລະອຽດການສັ່ງຊື້',
              style: appBarStyle(),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: MyColors.tealColor,
                        radius: 21.r,
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundImage: AssetImage(MyImages.logo),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'ລໍຖ້າກວດສອບ',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20.sp,
                                color: MyColors.waitColor.withOpacity(0.5)),
                          ),
                          Icon(Icons.hourglass_empty_outlined,
                              color: MyColors.waitColor.withOpacity(0.5)),
                        ],
                      ),
                      SizedBox(
                        width: 25.w,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text('ເລກບິນ'),
                          Text(widget.billNo),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('ວັນທີ່ສ້າງບິນ'),
                          Text(
                              DateFormat('dd/MM/yyyy').format(widget.dateTime)),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: const [
                          Text('ໃບບິນ'),
                          Text('==================='),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'ຊື່ສິນຄ້າ',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('ລາຄາ'),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('ຈຳນວນ'),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('ລາຄາລວມ'),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 2),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.orderDetail.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return StoreBillNoDetail(
                          proName: '${widget.orderDetail[index].name}',
                          proAmount: NumberFormat.currency(
                                  symbol: '', decimalDigits: 0)
                              .format(widget.orderDetail[index].amount),
                          proPrice: NumberFormat.currency(
                                  symbol: '', decimalDigits: 0)
                              .format(widget.orderDetail[index].sellingPrice),
                          proTotal: NumberFormat.currency(
                                  symbol: '', decimalDigits: 0)
                              .format(widget.orderDetail[index].amount! *
                                  widget.orderDetail[index].sellingPrice!));
                    },
                  ),
                  const Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ລາຄາລວມທັງໝົດ:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.sp)),
                        Text(
                          '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(widget.totals)}  ກີບ',
                          style: TextStyle(
                              color: MyColors.cancelColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 2),
                  Text('ຫຼັກຖານການຊຳລະເງິນ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.sp)),
                  Container(
                    width: double.infinity,
                    height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: MyColors.hoverColors),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 100.w),
                      child: GestureDetector(
                        child: Hero(
                          tag: 'imageHero',
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: MyColors.hoverColors),
                              image: widget.paymentInfo.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(widget.paymentInfo),
                                      fit: BoxFit.fill)
                                  : const DecorationImage(
                                      image: AssetImage(MyImages.loading),
                                      fit: BoxFit.fill),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HeroPages(images: widget.paymentInfo),
                              ));
                        },
                      ),
                    ),
                  ),
                  const Divider(thickness: 2),
                  Text('ຂໍ້ມູນລູກຄ້າ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.sp)),
                  ListTile(
                    leading: widget.logoUser.isEmpty
                        ? CircleAvatar(
                            radius: 30.r,
                            backgroundImage: const AssetImage(MyImages.image),
                          )
                        : CircleAvatar(
                            radius: 30.r,
                            backgroundImage: NetworkImage(widget.logoUser),
                          ),
                    title: Text(widget.name),
                    subtitle: Text(widget.numberPhone),
                  ),
                  const Divider(thickness: 2),
                  Text('ສະຖານທີ່ສົ່ງ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.sp)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildshipping('ບ້ານ: ', '${widget.villName}'),
                      buildshipping('ເມືອງ: ', '${widget.distName}'),
                      buildshipping('ແຂວງ: ', '${widget.prName}'),
                      buildshipping(
                          'ບໍລິສັດຂົນສົ່ງ: ', '${widget.sippingName}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildshipping(String title, String detail) {
    return RichText(
        text: TextSpan(
            text: title,
            style: const TextStyle(
                color: MyColors.blackColor,
                fontWeight: FontWeight.w500,
                fontFamily: FONT_NOTOSANS),
            children: [
          TextSpan(
              text: detail,
              style: const TextStyle(
                  color: MyColors.hintColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: FONT_NOTOSANS))
        ]));
  }
}
