import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/screen/model/history_model.dart';

import '../../constant/font.dart';
import '../../constant/image.dart';
import '../../constant/my_colors.dart';
import '../../constant/theme.dart';
import '../../widget/store_billno_detail.dart';

class HistoryBillNoSuccess extends StatefulWidget {
  final List<OrderDetail> orderDetail;
  final String total;
  final String images;
  final String userName;
  final String userPhone;
  final String uservillage;
  final String userdistrict;
  final String userprovince;
  final String sipping;
  final String billNo;
  final DateTime dateTime;
  const HistoryBillNoSuccess(
      {super.key,
      required this.total,
      required this.orderDetail,
      required this.images,
      required this.userName,
      required this.userPhone,
      required this.uservillage,
      required this.userdistrict,
      required this.userprovince,
      required this.sipping,
      required this.billNo,
      required this.dateTime});

  @override
  State<HistoryBillNoSuccess> createState() => _HistoryBillNoSuccessState();
}

class _HistoryBillNoSuccessState extends State<HistoryBillNoSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Text(
              'ສຳເລັດແລ້ວ',
              style: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
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
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 70),
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
                itemCount: widget.orderDetail.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return StoreBillNoDetail(
                      proName: widget.orderDetail[index].name,
                      proAmount: widget.orderDetail[index].amount.toString(),
                      proPrice:
                          NumberFormat.currency(symbol: '', decimalDigits: 0)
                              .format(widget.orderDetail[index].sellingPrice)
                              .toString(),
                      proTotal:
                          NumberFormat.currency(symbol: '', decimalDigits: 0)
                              .format((widget.orderDetail[index].amount *
                                  widget.orderDetail[index].sellingPrice)));
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
                            fontWeight: FontWeight.w500, fontSize: 16.sp)),
                    Text(
                        '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(int.parse(widget.total))}  ກີບ'),
                  ],
                ),
              ),
              const Divider(thickness: 2),
              Text('ຂໍ້ມູນລູກຄ້າ',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)),
              ListTile(
                leading: widget.images.isEmpty
                    ? CircleAvatar(
                        backgroundColor: MyColors.whiteColor,
                        radius: 30.r,
                        backgroundImage: const AssetImage(MyImages.loading),
                      )
                    : CircleAvatar(
                        backgroundColor: MyColors.whiteColor,
                        radius: 30.r,
                        backgroundImage: NetworkImage(widget.images),
                      ),
                title: Text(widget.userName),
                subtitle: Text(widget.userPhone),
              ),
              const Divider(thickness: 2),
              Text('ສະຖານທີ່ສົ່ງ',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildshipping('ບ້ານ: ', '${widget.uservillage}'),
                  buildshipping('ເມືອງ: ', '${widget.userdistrict}'),
                  buildshipping('ແຂວງ: ', '${widget.userprovince}'),
                  buildshipping('ບໍລິສັດຂົນສົ່ງ: ', '${widget.sipping}'),
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
