import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/payment_provider.dart';
import 'package:meesooklife_app/constant/font.dart';
import 'package:meesooklife_app/business_provider/products_provider.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/screen/model/products_model.dart';
import 'package:provider/provider.dart';
import '../../../constant/theme.dart';
import '../../product_detail/product_detail_page.dart';

class ProductAll extends StatefulWidget {
  const ProductAll({super.key});

  @override
  State<ProductAll> createState() => _ProductAllState();
}

class _ProductAllState extends State<ProductAll> {
  final TextEditingController searchController = TextEditingController();

  List<Product> products = [];

  @override
  void initState() {
    products = context.read<ProductsProvider>().getProducts;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ສິນຄ້າທັງໝົດ',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
        ),
        body: Consumer2<ProductsProvider, PaymentProvider>(
          builder: (context, prmodels, paymodel, _) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'ຄົ້ນຫາສິນຄ້າ',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (val) {
                        setState(() {
                          products = prmodels.getProducts
                              .where((element) =>
                                  element.name!.toLowerCase().contains(val))
                              .toList();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: products.isNotEmpty
                          ? GridView.builder(
                              shrinkWrap: true,
                              itemCount: products.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                mainAxisExtent: size.height * 0.34,
                              ),
                              itemBuilder: (context, index) {
                                // return ProductsWidget(
                                //   onTap: () {
                                //     prmodels.setPrAmount =
                                //         prmodels.getProducts[index].amount!;
                                //     prmodels.setAmount = 0;
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) => ProductDetailPage(
                                //           prImage: products[index].images,
                                //           prName:
                                //               products[index].name.toString(),
                                //           prDetail: products[index]
                                //               .details
                                //               .toString(),
                                //           prPice: products[index].sellingPrice!,
                                //           prAmount: products[index].amount!,
                                //           branchId: products[index].branchId!,
                                //           proId: products[index].id!,
                                //         ),
                                //       ),
                                //     );
                                //   },
                                //   imageProduct: products[index]
                                //       .images
                                //       .first
                                //       .image
                                //       .toString(),
                                //   nameProduct: products[index].name.toString(),
                                //   subNameProduct:
                                //       products[index].details.toString(),
                                //   priceProduct: products[index].sellingPrice!,
                                // );
                                return GestureDetector(
                                  onTap: () {
                                    paymodel.setBankRqCode(context,
                                        prmodels.getProducts[index].branchId!);
                                    paymodel.setAddress(context);
                                    prmodels.setPrAmount =
                                        prmodels.getProducts[index].amount!;
                                    prmodels.setAmount = 0;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetailPage(
                                          prImage: products[index].images,
                                          prName:
                                              products[index].name.toString(),
                                          prDetail: products[index]
                                              .details
                                              .toString(),
                                          prPice: products[index].sellingPrice!,
                                          prAmount: products[index].amount!,
                                          branchId: products[index].branchId!,
                                          proId: products[index].id!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    elevation: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 170.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.r),
                                                  topRight:
                                                      Radius.circular(10.r),
                                                ),
                                                color: MyColors.whiteColor,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      products[index]
                                                          .images
                                                          .first
                                                          .image
                                                          .toString()),
                                                  fit: BoxFit.fill,
                                                  // width: double.infinity,
                                                  // height: 110.h,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: Text(
                                                products[index].name.toString(),
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: MyColors.blackColor,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(products[index].sellingPrice)} ກີບ',
                                                style: const TextStyle(
                                                  color: MyColors.cancelColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.zero,
                                              width: double.infinity,
                                              height: 50.h,
                                              decoration: BoxDecoration(
                                                color: MyColors.cartColor,
                                                // gradient: MSLheme.appBarGradient,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                border: Border.all(
                                                    color:
                                                        MyColors.hoverColors),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'ເພີ່ມເຂົ້າກະຕ່າ',
                                                  style: TextStyle(
                                                      color:
                                                          MyColors.whiteColor,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                              'ບໍ່ມີສິນຄ້າ',
                              style: TextStyle(
                                  fontSize: 20.sp, color: MyColors.hintColor),
                            )))
                ],
              ),
            );
          },
        ));
  }
}
