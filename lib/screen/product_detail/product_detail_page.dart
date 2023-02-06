import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/payment_provider.dart';
import 'package:meesooklife_app/business_provider/products_provider.dart';
import 'package:meesooklife_app/constant/font.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/widget/button_detail_product.dart';
import 'package:provider/provider.dart';
import '../../constant/theme.dart';
import '../../database/user_database/sqlite_database.dart';
import '../../widget/alert_diog/add_new_product.dart';
import '../../widget/alert_diog/alert_error.dart';
import '../model/products_model.dart';
import '../payment/payment_one_page.dart';

class ProductDetailPage extends StatefulWidget {
  final List<PImage> prImage;
  final String prName;
  final int prAmount;
  final int prPice;
  final String prDetail;
  final int branchId;
  final int proId;
  const ProductDetailPage(
      {super.key,
      required this.prImage,
      required this.prName,
      required this.prAmount,
      required this.prPice,
      required this.prDetail,
      required this.branchId,
      required this.proId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentPos = 0;
  final TextEditingController moneycontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductsProvider, PaymentProvider>(
      builder: (context, prmodels, paymodels, _) {
        return Scaffold(
            bottomSheet: ButtonDetailProduct(
              moneycontroller: moneycontroller,
              onPressed: () async {
                // data.add(
                //     CartModel(prId: widget.proId, amount: prmodels.getAmount));
                // prmodels.setCartModel = data;
                // if (prmodels.getAmount > 0) {
                //   // Navigator.push(
                //   //     context,
                //   //     MaterialPageRoute(
                //   //         builder: (context) => PaymentPage(
                //   //               prices: widget.prPice,
                //   //               productName: widget.prName,
                //   //               bId: widget.branchId,
                //   //             ))).then((va) {
                //   //   data.clear();
                //   // });
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const PaymentPage(),
                //       ));
                // } else {
                //   alertdiogError(
                //       context: context,
                //       title: 'ກະລຸນາເພີ່ມສິນຄ້າກ່ອນ',
                //       image: MyImages.erroricon);
                //   Future.delayed(const Duration(seconds: 1)).then((value) {
                //     Navigator.pop(context);
                //   });
                // }
                context.read<PaymentProvider>().sqliteRead(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PaymentPage(intBrId: widget.branchId),
                    )).then((value) {
                  setState(() {});
                  context.read<PaymentProvider>().setTotalPrice = 0;
                });
              },
              addCartOnPressed: () {
                if (widget.prAmount > 0) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AddNewProduct(
                        prdImage: widget.prImage.first.image.toString(),
                        prdId: widget.proId,
                        prdName: widget.prName,
                        prdAmount: widget.prAmount,
                        prdCategory: 'ຖົງ',
                        prdPrice: widget.prPice,
                        brId: widget.branchId,
                        brhName: widget.prName,
                      );
                    },
                  ).then((value) {
                    setState(() {});
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const ErrorAlertDialog(
                          content:
                              'ຂໍອະໄພ ສິນຄ້າລາຍການນີ້ບໍ່ມີແລ້ວ ກະລຸນາສັ່ງຊື້ລາຍການອື່ນ\n ຂໍຂອບໃຈ',
                          icon: MyImages.erroricon);
                    },
                  );
                }
              },
            ),
            appBar: AppBar(
              title: Text(
                'ລາຍລະອຽດສິນຄ້າ',
                style: appBarStyle(),
              ),
              flexibleSpace: Container(
                decoration:
                    const BoxDecoration(gradient: MSLheme.appBarGradient),
              ),
              actions: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FutureBuilder(
                    future: SQLiteHelper().readData(),
                    builder: (context, snapshot) {
                      return GestureDetector(
                        onTap: () {
                          context.read<PaymentProvider>().sqliteRead(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PaymentPage(intBrId: widget.branchId),
                              )).then((value) {
                            setState(() {});
                            context.read<PaymentProvider>().setTotalPrice = 0;
                          });
                        },
                        child: Badge(
                          position: BadgePosition.topEnd(top: -3.r),
                          badgeContent: Text(
                            snapshot.data == null
                                ? ''
                                : '${snapshot.data!.length}',
                            style: TextStyle(
                                color: MyColors.whiteColor, fontSize: 12.sp),
                          ),
                          child: const Icon(Icons.shopping_cart),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: CarouselSlider.builder(
                        itemCount: widget.prImage.length,
                        itemBuilder: (context, index, realIndex) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(
                                    widget.prImage[index].image.toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 1,
                          aspectRatio: 2.0,
                          initialPage: 2,
                          onPageChanged: (index, reason) => setState(() {
                            currentPos = index;
                          }),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.prImage.map((url) {
                        int index = widget.prImage.indexOf(url);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPos == index
                                ? MyColors.tealColor
                                : Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: RichText(
                        maxLines: 2,
                        text: TextSpan(
                          text: widget.prName.toString(),
                          style: TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 18.h,
                              fontWeight: FontWeight.bold,
                              fontFamily: FONT_NOTOSANS,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'ຈຳນວນສິນຄ້າ ',
                          style: const TextStyle(color: MyColors.hintColor),
                          children: [
                            TextSpan(
                              text: NumberFormat.currency(
                                      symbol: '', decimalDigits: 0)
                                  .format(widget.prAmount),
                              style:
                                  const TextStyle(color: MyColors.cancelColor),
                            ),
                            const TextSpan(text: ' ອັນ')
                          ]),
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: widget.prAmount.toDouble() <= 20
                              ? 2
                              : widget.prAmount.toDouble() <= 70
                                  ? 3
                                  : widget.prAmount.toDouble() <= 100
                                      ? 4
                                      : 5,
                          minRating: 1.0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 0),
                          itemSize: 18.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.red,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        Text(
                          '${widget.prAmount.toDouble() <= 20 ? 1.5 : widget.prAmount.toDouble() <= 70 ? 2.6 : widget.prAmount.toDouble() <= 100 ? 3.5 : 4.5}',
                        ),
                        const SizedBox(width: 30),
                        Text(
                          '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(widget.prPice)} ກີບ',
                          style: const TextStyle(
                              color: MyColors.cancelColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    const Text('ລາຍລະອຽດ:'),
                    Text(
                      '   ${widget.prDetail}',
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: GestureDetector(
                        onTap: () {
                          prmodels.setProductByBranch(
                              context, widget.branchId.toString());
                          context
                              .read<PaymentProvider>()
                              .setBankRqCode(context, widget.branchId);
                          context.read<PaymentProvider>().setAddress(context);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30.r,
                              backgroundColor: MyColors.tealColor,
                              child: Icon(Icons.shopping_cart,
                                  color: MyColors.whiteColor, size: 30.r),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  widget.prName.toString(),
                                  style: TextStyle(color: MyColors.blueColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
