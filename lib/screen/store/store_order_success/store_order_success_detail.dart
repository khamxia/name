import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/constant/font.dart';
import 'package:meesooklife_app/screen/model/order_model.dart';
import 'package:meesooklife_app/widget/text_button.dart';
import '../../../constant/image.dart';
import '../../../constant/my_colors.dart';
import '../../../constant/theme.dart';
import '../../../widget/store_billno_detail.dart';
import '../../hero/hero_page.dart';

class StoreOrderSuccessDetail extends StatefulWidget {
  final List<OrderDetail> orderModel;
  final int totals;
  final String userLogo;
  final String userName;
  final String userPhone;
  final String userprovince;
  final String userdistrict;
  final String uservillage;
  final String usersipping;
  final String paymentInfo;
  final String billNo;
  final DateTime dateTime;
  const StoreOrderSuccessDetail(
      {super.key,
      required this.orderModel,
      required this.totals,
      required this.userLogo,
      required this.userName,
      required this.userPhone,
      required this.userprovince,
      required this.userdistrict,
      required this.uservillage,
      required this.usersipping,
      required this.paymentInfo,
      required this.billNo,
      required this.dateTime});

  @override
  State<StoreOrderSuccessDetail> createState() =>
      _StoreOrderSuccessDetailState();
}

class _StoreOrderSuccessDetailState extends State<StoreOrderSuccessDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: MSLButton(
            text: 'ສຳເລັດແລ້ວ',
            onpressed: () {
              Navigator.pop(context);
            }),
      ),
      appBar: AppBar(
        title: Text(
          'ລາຍລະອຽດການສັ່ງຊື້ສຳເລັດ',
          style: appBarStyle(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 70),
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
                        'ສຳເລັດແລ້ວ',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20.sp,
                            color: MyColors.succcessColors.withOpacity(0.5)),
                      ),
                      Image.asset(
                        MyImages.success,
                        width: 40.w,
                        height: 40.h,
                        color: MyColors.succcessColors.withOpacity(0.5),
                      ),
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
                      Text(DateFormat('dd/MM/yyyy').format(widget.dateTime)),
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
                itemCount: widget.orderModel.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return StoreBillNoDetail(
                      proName: widget.orderModel[index].name.toString(),
                      proAmount: widget.orderModel[index].amount.toString(),
                      proPrice:
                          NumberFormat.currency(symbol: '', decimalDigits: 0)
                              .format(widget.orderModel[index].sellingPrice),
                      proTotal:
                          NumberFormat.currency(symbol: '', decimalDigits: 0)
                              .format(widget.orderModel[index].amount! *
                                  widget.orderModel[index].sellingPrice!));
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
                            fontWeight: FontWeight.w500, fontSize: 16)),
                    Text(
                        '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(widget.totals)} ກີບ'),
                  ],
                ),
              ),
              const Divider(thickness: 2),
              Text('ຫຼັກຖານການຊຳລະເງິນ',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)),
              Container(
                width: double.infinity,
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: MyColors.hoverColors),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 100.w),
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
              const Text('ຂໍ້ມູນລູກຄ້າ',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              ListTile(
                leading: widget.userLogo.isEmpty
                    ? CircleAvatar(
                        radius: 30.r,
                        backgroundImage: const AssetImage(MyImages.image),
                      )
                    : CircleAvatar(
                        radius: 30.r,
                        backgroundImage:
                            NetworkImage(widget.userLogo.toString()),
                      ),
                title: Text(widget.userName.toString()),
                subtitle: Text(widget.userPhone.toString()),
              ),
              const Divider(thickness: 2),
              const Text('ສະຖານທີ່ສົ່ງ',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildshipping('ບ້ານ: ', '${widget.uservillage}'),
                  buildshipping('ເມືອງ: ', '${widget.userdistrict}'),
                  buildshipping('ແຂວງ: ', '${widget.userprovince}'),
                  buildshipping('ບໍລິສັດຂົນສົ່ງ: ', '${widget.usersipping}'),
                ],
              ),
            ],
          ),
        ),
      ),
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
