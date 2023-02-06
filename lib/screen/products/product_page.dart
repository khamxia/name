import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/store_provider.dart';
import 'package:meesooklife_app/constant/font.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/business_provider/products_provider.dart';
import 'package:meesooklife_app/screen/product_detail/product_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:meesooklife_app/constant/routes.dart' as user_route;
import '../../business_provider/payment_provider.dart';
import '../../constant/my_colors.dart';
import '../../constant/theme.dart';
import '../../widget/best_product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> images = [MyImages.msl1, MyImages.msl2, MyImages.msl3];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ສິນຄ້າ',
          style: appBarStyle(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
        ),
      ),
      body: Consumer3<ProductsProvider, StoreProvider, PaymentProvider>(
        builder: (context, prModels, storeModel, paymodel, _) {
          return Padding(
            padding: EdgeInsets.only(
                right: 10.w, left: 10.w, top: 10.h, bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'ຄົ້ນຫາສິນຄ້າ',
                      prefixIcon: const Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: MyColors.hintColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: MyColors.hintColor),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ປະເພດສິນຄ້າ',
                          style: TextStyle(
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp),
                        ),
                        Container(
                          height: 80,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: prModels.getCategory.length,
                            itemBuilder: (context, index) {
                              return _searchController.text.isEmpty ||
                                      prModels.getCategory[index].name!
                                          .toUpperCase()
                                          .contains(_searchController.text
                                              .toUpperCase())
                                  ? GestureDetector(
                                      onTap: () async {
                                        await prModels.setProductsById(
                                            context,
                                            prModels.getCategory[index].id
                                                .toString());
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.h),
                                        child: Card(
                                          elevation: 5.r,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.w),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 46.w,
                                                  height: 46.h,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: prModels
                                                                .getCategory[
                                                                    index]
                                                                .logo !=
                                                            null
                                                        ? DecorationImage(
                                                            image: NetworkImage(
                                                                prModels
                                                                    .getCategory[
                                                                        index]
                                                                    .logo
                                                                    .toString()),
                                                          )
                                                        : const DecorationImage(
                                                            image: AssetImage(
                                                                MyImages
                                                                    .loading),
                                                          ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                      '${prModels.getCategory[index].name}'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        CarouselSlider.builder(
                          itemCount: images.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: MyColors.hoverColors),
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: AssetImage(images[index]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: 150,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ສິນຄ້າ',
                              style: TextStyle(
                                  color: MyColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            ),
                            GestureDetector(
                              onTap: () {
                                prModels.setProducts(context);
                                // Navigator.pushNamed(
                                //     context, user_route.Route.productsall);
                              },
                              child: Wrap(
                                children: [
                                  Text(
                                    'ເບິ່ງທັງໝົດ',
                                    style: TextStyle(
                                        color: MyColors.blackColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 20.sp,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        prModels.getTopTenProduct.isNotEmpty
                            ? Container(
                                height: 300.h,
                                width: double.infinity,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: prModels.getTopTenProduct.length,
                                  itemBuilder: (context, index) {
                                    return BestProduct(
                                      onTap: () {
                                        paymodel.setBankRqCode(
                                            context,
                                            prModels.getTopTenProduct[index]
                                                .branchId!);
                                        paymodel.setAddress(context);
                                        prModels.setPrAmount = prModels
                                            .getTopTenProduct[index].amount!;
                                        prModels.setAmount = 0;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailPage(
                                              prImage: prModels
                                                  .getTopTenProduct[index]
                                                  .images,
                                              prName: prModels
                                                  .getTopTenProduct[index].name
                                                  .toString(),
                                              prAmount: prModels
                                                  .getTopTenProduct[index]
                                                  .amount!,
                                              prPice: prModels
                                                  .getTopTenProduct[index]
                                                  .purchasePrice!,
                                              prDetail: prModels
                                                  .getTopTenProduct[index]
                                                  .details
                                                  .toString(),
                                              branchId: prModels
                                                  .getTopTenProduct[index]
                                                  .branchId!,
                                              proId: prModels
                                                  .getTopTenProduct[index].id!,
                                            ),
                                          ),
                                        );
                                      },
                                      image: prModels.getTopTenProduct[index]
                                          .images.first.image
                                          .toString(),
                                      title:
                                          '${prModels.getTopTenProduct[index].name}',
                                      description:
                                          '${prModels.getTopTenProduct[index].details}',
                                      price:
                                          '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(prModels.getTopTenProduct[index].purchasePrice)} ກີບ',
                                      titleCart: 'ເພີ່ມເຂົ້າກະຕ່າ',
                                    );
                                  },
                                ),
                              )
                            : const SizedBox(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: RichText(
                              text: TextSpan(
                                  text: 'ຮ້ານຄ້າ',
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      fontFamily: FONT_NOTOSANS),
                                  children: [
                                TextSpan(
                                    text:
                                        ' (ທ່ານສາມາດເຂົ້າໄປຊື້ສິນຄ້າພາຍໃນຮ້ານຄ້າໄດ້)',
                                    style: TextStyle(
                                        color: MyColors.cancelColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        fontFamily: FONT_NOTOSANS))
                              ])),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 5),
                        //   child: SizedBox(
                        //     child: GridView.builder(
                        //      physics: const NeverScrollableScrollPhysics(),
                        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //           crossAxisCount: 2,
                        //           crossAxisSpacing: 1,
                        //           mainAxisExtent: size.height * 0.17),
                        //       scrollDirection: Axis.vertical,
                        //       shrinkWrap: true,
                        //       itemCount: store.length,
                        //       itemBuilder: (context, index) {
                        //         return GestureDetector(
                        //           onTap: () {
                        //             Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                   builder: (context) => const StoreSale(),
                        //                 ));
                        //           },
                        //           child: Card(
                        //             child: SingleChildScrollView(
                        //               physics: const BouncingScrollPhysics(),
                        //               child: Column(
                        //                 mainAxisSize: MainAxisSize.min,
                        //                 children: [
                        //                   Container(
                        //                     height: 70,
                        //                     width: 200,
                        //                     decoration: const BoxDecoration(
                        //                       image: const DecorationImage(
                        //                         fit: BoxFit.fill,
                        //                         image: AssetImage(
                        //                           Images.banner2,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   ExpansionTile(
                        //                     title: Text(
                        //                       store[index],
                        //                       textAlign: TextAlign.left,
                        //                       style: TextStyle(
                        //                         fontSize: 14,
                        //                       ),
                        //                     ),
                        //                     children: [
                        //                       Text('dddddd'),
                        //                       Text('dddddd'),
                        //                       Text('dddddd'),
                        //                       Icon(Icons.keyboard_arrow_down)
                        //                     ],
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),
                       Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: prModels.gettopBranch.length,
                                    itemBuilder: (context, index) {
                                      return _searchController.text.isEmpty ||
                                              prModels.gettopBranch[index]
                                                  .branchName!
                                                  .toUpperCase()
                                                  .contains(_searchController
                                                      .text
                                                      .toUpperCase())
                                          ? GestureDetector(
                                              onTap: () {
                                                prModels.setProductByBranch(
                                                    context,
                                                    prModels
                                                        .gettopBranch[index].id
                                                        .toString());
                                                prModels.setBranchId = prModels
                                                    .gettopBranch[index].id!;
                                                context
                                                    .read<PaymentProvider>()
                                                    .setBankRqCode(
                                                        context,
                                                        Provider.of<ProductsProvider>(
                                                                context,
                                                                listen: false)
                                                            .getBranchId);
                                                context
                                                    .read<PaymentProvider>()
                                                    .setAddress(context);
                                              },
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                      width: 70,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: MyColors
                                                                .blueColor),
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              prModels
                                                                  .gettopBranch[
                                                                      index]
                                                                  .branchLogo
                                                                  .toString()),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      prModels
                                                          .gettopBranch[index]
                                                          .branchName
                                                          .toString(),
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const SizedBox();
                                    },
                                  ),
                                ),
                              )
                            
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
