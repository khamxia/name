import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:meesooklife_app/business_provider/payment_provider.dart';
import 'package:meesooklife_app/business_provider/store_provider.dart';
import 'package:meesooklife_app/database/store_database/sqilte_store_database.dart';
import 'package:meesooklife_app/screen/model/branch_products_model.dart';
import 'package:meesooklife_app/screen/store/store_payment/store_checkout.dart';
import 'package:meesooklife_app/screen/store/store_sale/add_to_cart.dart';
import 'package:meesooklife_app/screen/store/store_sale/store_sale_detail.dart';
import 'package:meesooklife_app/widget/store_button_detail.dart';
import 'package:provider/provider.dart';
import '../../../constant/font.dart';
import '../../../constant/my_colors.dart';
import '../../../constant/theme.dart';

class StoreSale extends StatefulWidget {
  const StoreSale({super.key});

  @override
  State<StoreSale> createState() => _StoreSaleState();
}

class _StoreSaleState extends State<StoreSale> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController moneycontroller = TextEditingController();
  List<Product> products = [];

  @override
  void initState() {
    products = context.read<StoreProvider>().getproducts;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    moneycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    moneycontroller.text = 20000.toString();
    return Scaffold(
        bottomSheet: StoreButtonDetail(
          moneycontroller: moneycontroller,
          onPressed: () {
            context.read<PaymentProvider>().setreadDataFormSqliteStore(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StoreCheckOut(),
                )).then((value) {
              setState(() {});
            });
          },
        ),
        appBar: AppBar(
          title: Text(
            'ຂາຍສິນຄ້າ',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
          actions: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: FutureBuilder(
                  future: SQLiteStoreHelper().readData(),
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<PaymentProvider>()
                            .setreadDataFormSqliteStore(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StoreCheckOut(),
                            )).then((value) {
                          setState(() {});
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
                ))
          ],
        ),
        body: Consumer2<StoreProvider, LoginProvider>(
          builder: (context, storemodel, loginmodel, _) {
            return Padding(
              padding: EdgeInsets.only(
                  left: 5.w, right: 5.w, top: 20.h, bottom: 70.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 55.h,
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'ຄົ້ນຫາສິນຄ້າ',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (value) {
                        setState(() {
                          products = storemodel.getproducts
                              .where((element) =>
                                  element.name!.toLowerCase().contains(value))
                              .toList();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisExtent: size.height * 0.34,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StoreSaleDetail(
                                    images: products[index].images,
                                    pname: products[index].name.toString(),
                                    amount: products[index].amount!,
                                    price: products[index].sellingPrice!,
                                    detail: products[index].details.toString(),
                                  ),
                                ));
                          }),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 170.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.r),
                                          topRight: Radius.circular(10.r),
                                        ),
                                        color: MyColors.whiteColor,
                                        image: DecorationImage(
                                          image: NetworkImage(products[index]
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Text(
                                        products[index].name.toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            color: MyColors.blackColor,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                            color: MyColors.hoverColors),
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AddToCart(
                                                  prdImage: products[index]
                                                      .images
                                                      .first
                                                      .image
                                                      .toString(),
                                                  prdId: products[index].id!,
                                                  prdName: products[index]
                                                      .name
                                                      .toString(),
                                                  prdAmount:
                                                      products[index].amount!,
                                                  prdCategory: 'ອັນ',
                                                  prdPrice: products[index]
                                                      .sellingPrice!,
                                                  brId: loginmodel.getBId,
                                                  brhName:
                                                      loginmodel.getBranchName,
                                                );
                                              },
                                            ).then((val) {
                                              setState(() {});
                                            });
                                          },
                                          child: Text(
                                            'ເພີ່ມເຂົ້າກະຕ່າ',
                                            style: TextStyle(
                                                color: MyColors.whiteColor,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
