import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/payment_provider.dart';
import 'package:meesooklife_app/business_provider/products_provider.dart';
import 'package:meesooklife_app/database/user_database/sqlite_database.dart';
import 'package:meesooklife_app/screen/payment/payment_user_checkout.dart';
import 'package:meesooklife_app/screen/products/components/product_by_branch_detail.dart';
import 'package:meesooklife_app/widget/alert_diog/add_new_product.dart';
import 'package:provider/provider.dart';
import '../../../constant/font.dart';
import '../../../constant/image.dart';
import '../../../constant/my_colors.dart';
import '../../../constant/theme.dart';

class ProductByBranch extends StatefulWidget {
  const ProductByBranch({super.key});

  @override
  State<ProductByBranch> createState() => _ProductByBranchState();
}

class _ProductByBranchState extends State<ProductByBranch> {
  final TextEditingController searchController = TextEditingController();
  Widget searchAppBar = Text('ສິນຄ້າໃນຮ້ານຄ້າ', style: appBarStyle());
  bool isSearching = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: MSLheme.appBarGradient,
                borderRadius: BorderRadius.circular(5.r)),
            child: TextButton(
              onPressed: () {
                context.read<PaymentProvider>().sqliteRead(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentUserCheckOut(),
                    )).then((value) {
                  setState(() {});
                  context.read<PaymentProvider>().setTotalPrice = 0;
                });
              },
              child: Text(
                'ສັ່ງຊື້',
                style: TextStyle(
                    color: MyColors.whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: searchAppBar,
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                    if (isSearching) {
                      searchController.clear();
                      searchAppBar = Container(
                        width: double.infinity,
                        height: 55.h,
                        child: TextField(
                          controller: searchController,
                          autofocus: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: MyColors.whiteColor,
                              isDense: true,
                              hintText: 'ຄົ້ນຫາສິນຄ້າ',
                              hintStyle: TextStyle(
                                  fontSize: 14.sp, color: MyColors.hintColor),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 20.sp,
                                color: MyColors.hintColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {
                                    isSearching = !isSearching;
                                  });
                                  if (!isSearching) {
                                    searchAppBar = Text('ສິນຄ້າໃນຮ້ານຄ້າ',
                                        style: appBarStyle());
                                  }
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 20.sp,
                                  color: MyColors.blueColor,
                                ),
                              )),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      );
                    } else {
                      searchAppBar =
                          Text('ສິນຄ້າໃນຮ້ານຄ້າ', style: appBarStyle());
                    }
                  });
                },
                icon: const Icon(
                  Icons.search_rounded,
                  color: MyColors.whiteColor,
                )),
            Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: FutureBuilder(
                  future: SQLiteHelper().readData(),
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () {
                        context.read<PaymentProvider>().sqliteRead(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentUserCheckOut(),
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
                )),
          ],
        ),
        body: Consumer2<ProductsProvider, PaymentProvider>(
          builder: (context, promodels, paymentmodel, _) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 10.h, left: 5.w, right: 5.w, bottom: 80.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.hoverColors),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: MSLheme.cardGradient,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: ExpansionTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: MyColors.whiteColor,
                                child: CircleAvatar(
                                  backgroundColor: MyColors.whiteColor,
                                  radius: 18,
                                  backgroundImage: NetworkImage(promodels
                                      .getProductbybranch!.branchs.branchLogo
                                      .toString()),
                                ),
                              ),
                              title: Text(
                                promodels.getProductbybranch!.branchs.branchName
                                    .toString(),
                                maxLines: 1,
                                style: TextStyle(
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              subtitle: Text(
                                promodels
                                    .getProductbybranch!.branchs.branchPhone
                                    .toString(),
                                maxLines: 1,
                                style: TextStyle(
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                              ),
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            'ສະຖານທີ່ຕັ້ງ',
                                            style: TextStyle(
                                                color: MyColors.whiteColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'ບ້ານ : ${promodels.getProductbybranch!.branchs.villName.toString()}',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: MyColors.whiteColor,
                                                  fontSize: 14.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'ເມືອງ : ${promodels.getProductbybranch!.branchs.drName.toString()}',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: MyColors.whiteColor,
                                                  fontSize: 14.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'ແຂວງ : ${promodels.getProductbybranch!.branchs.prName.toString()}',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: MyColors.whiteColor,
                                                  fontSize: 14.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        'ສິນຄ້າທັງໝົດ',
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp),
                      ),
                    ),
                    promodels.getProductbybranchlist != null
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            // itemCount: promodels.getProductbybranchlist!.length,
                            itemCount: promodels.getProductbybranchlist!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return searchController.text.isEmpty ||
                                      promodels
                                          .getProductbybranchlist![index].name
                                          .toString()
                                          .toUpperCase()
                                          .contains(searchController.text
                                              .toUpperCase())
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductByBranchDetail(
                                                images: promodels
                                                    .getProductbybranchlist![
                                                        index]
                                                    .images,
                                                pname: promodels
                                                    .getProductbybranchlist![
                                                        index]
                                                    .name,
                                                amount: promodels
                                                    .getProductbybranchlist![
                                                        index]
                                                    .amount,
                                                price: promodels
                                                    .getProductbybranchlist![
                                                        index]
                                                    .sellingPrice,
                                                detail: promodels
                                                    .getProductbybranchlist![
                                                        index]
                                                    .details,
                                              ),
                                            ));
                                      },
                                      child: Card(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 125.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.r),
                                                    bottomLeft:
                                                        Radius.circular(5.r)),
                                                image: promodels
                                                        .getProductbybranchlist![
                                                            index]
                                                        .images
                                                        .first
                                                        .image
                                                        .isEmpty
                                                    ? const DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: AssetImage(
                                                          MyImages.msl1,
                                                        ),
                                                      )
                                                    : DecorationImage(
                                                        image: NetworkImage(
                                                            promodels
                                                                .getProductbybranchlist![
                                                                    index]
                                                                .images
                                                                .first
                                                                .image
                                                                .toString()),
                                                        fit: BoxFit.fill),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  promodels
                                                      .getProductbybranchlist![
                                                          index]
                                                      .name
                                                      .toString(),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16.sp,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                Text(
                                                  promodels
                                                      .getProductbybranchlist![
                                                          index]
                                                      .details
                                                      .toString(),
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      color: MyColors.hintColor,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 6.h,
                                                      bottom: 6.h,
                                                      right: 8.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(promodels.getProductbybranchlist![index].sellingPrice)} ກີບ',
                                                        style: TextStyle(
                                                            color: MyColors
                                                                .cancelColor,
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      TextButton(
                                                        style: TextButton.styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    color: MyColors
                                                                        .hoverColors,
                                                                    width: 1.w),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.r))),
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AddNewProduct(
                                                                  prdImage: promodels
                                                                      .getProductbybranchlist![
                                                                          index]
                                                                      .images
                                                                      .first
                                                                      .image,
                                                                  prdId: promodels
                                                                      .getProductbybranchlist![
                                                                          index]
                                                                      .id,
                                                                  prdName: promodels
                                                                      .getProductbybranchlist![
                                                                          index]
                                                                      .name,
                                                                  prdAmount: promodels
                                                                      .getProductbybranchlist![
                                                                          index]
                                                                      .amount,
                                                                  prdCategory:
                                                                      'ຖົງ',
                                                                  prdPrice: promodels
                                                                      .getProductbybranchlist![
                                                                          index]
                                                                      .sellingPrice,
                                                                  brId: promodels
                                                                      .getBranchId,
                                                                  brhName: promodels
                                                                      .getProductbybranchlist![
                                                                          index]
                                                                      .branchName);
                                                            },
                                                          ).then((value) {
                                                            setState(() {});
                                                          });
                                                        },
                                                        child: Text(
                                                          'ເພີ່ມເຂົ້າກະຕ່າ',
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .blueColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14.sp),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ))
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          )
                        : const Center(
                            child: Text('ຮ້ານຄ້າຍັງນີ້ຍັງບໍ່ມີສິນຄ້າ'),
                          ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
