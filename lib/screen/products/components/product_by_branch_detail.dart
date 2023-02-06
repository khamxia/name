import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/screen/model/products_by_branch_model.dart';
import 'package:meesooklife_app/widget/text_button.dart';
import '../../../constant/font.dart';
import '../../../constant/my_colors.dart';
import '../../../constant/theme.dart';

class ProductByBranchDetail extends StatefulWidget {
  final List<BYImage> images;
  final String pname;
  final int amount;
  final int price;
  final String detail;
  const ProductByBranchDetail(
      {super.key,
      required this.images,
      required this.pname,
      required this.amount,
      required this.price,
      required this.detail});

  @override
  State<ProductByBranchDetail> createState() => _ProductByBranchDetailState();
}

class _ProductByBranchDetailState extends State<ProductByBranchDetail> {
  int currentPos = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: MSLButton(
            text: 'ປິດ',
            onpressed: () {
              Navigator.pop(context);
            }),
      ),
      appBar: AppBar(
        title: Text(
          'ລາຍລະອຽດສິນຄ້າ',
          style: appBarStyle(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
        ),
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
                  itemCount: widget.images.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(
                              widget.images[index].image.toString()),
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
                children: widget.images.map((url) {
                  int index = widget.images.indexOf(url);
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
                    text: widget.pname.toString(),
                    style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 16.sp,
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
                        text: '${widget.amount}',
                        style: const TextStyle(color: MyColors.cancelColor),
                      ),
                      const TextSpan(text: ' ອັນ')
                    ]),
              ),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: widget.amount.toDouble() <= 20
                        ? 2
                        : widget.amount.toDouble() <= 70
                            ? 3
                            : widget.amount.toDouble() <= 100
                                ? 4
                                : 5,
                    minRating: 1.0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0),
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
                      '${widget.amount.toDouble() <= 20 ? 1.5 : widget.amount.toDouble() <= 70 ? 2.6 : widget.amount.toDouble() <= 100 ? 3.5 : 4.5}'),
                  const SizedBox(width: 30),
                  Text(
                    '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(widget.price)} ກີບ',
                    style: TextStyle(
                        color: MyColors.cancelColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp),
                  ),
                ],
              ),
              const Text('ລາຍລະອຽດ:'),
              Text('  ${widget.detail} '),
            ],
          ),
        ),
      ),
    );
  }
}
