import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/constant/font.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:meesooklife_app/business_provider/store_provider.dart';
import 'package:meesooklife_app/screen/store/store_sale/store_sale_detail.dart';
import 'package:meesooklife_app/widget/best_product.dart';
import 'package:meesooklife_app/widget/store_list_item.dart';
import 'package:provider/provider.dart';
import '../../constant/my_colors.dart';
import '../../constant/theme.dart';
import 'package:meesooklife_app/constant/routes.dart' as user_route;

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ຮ້ານຄ້າ',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
        ),
        body: Consumer2<LoginProvider, StoreProvider>(
          builder: (context, loginModel, storeModel, _) {
            return loginModel.getUserBranch!.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 110,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                gradient: MSLheme.appBarGradient,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context,
                                        user_route.Route.storedetailpage)
                                    .then((va) async {
                                  await loginModel.setUserDashboard(context);
                                });
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 50, bottom: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: MSLheme.cardGradient,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: MyColors.whiteColor,
                                        child: CircleAvatar(
                                          backgroundColor: MyColors.whiteColor,
                                          radius: 18,
                                          backgroundImage: NetworkImage(
                                              loginModel.getBranchLogo
                                                  .toString()),
                                        ),
                                      ),
                                      title: Text(
                                        loginModel.getBranchName.toString(),
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: MyColors.whiteColor,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      subtitle: Text(
                                        '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(double.tryParse(loginModel.getMoneySale.toString()))} ກີບ',
                                        style: const TextStyle(
                                            color: MyColors.whiteColor),
                                      ),
                                      trailing: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: MyColors.blueColor,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.r),
                                          child: const Text(
                                            'ລາຍລະອຽດ',
                                            style: TextStyle(
                                                color: MyColors.whiteColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          child: Text(
                            'ລາຍການ',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  StoreListItem(
                                      onTap: () async {
                                        await storeModel
                                            .setBranchRemainProducts(context);
                                      },
                                      icon: Icons.shopping_cart_outlined,
                                      title: 'ສິນຄ້າທີ່ຍັງເຫຼືອ'),
                                  StoreListItem(
                                      onTap: () {
                                        storeModel.setOrderSuccess(context);
                                        Navigator.pushNamed(context,
                                            user_route.Route.storeordersuccess);
                                      },
                                      icon: Icons.storefront_outlined,
                                      title: 'ສັ່ງຊື້ສຳເລັດແລ້ວ'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  StoreListItem(
                                      onTap: () {
                                        storeModel.setOrdering(context);
                                        Navigator.pushNamed(context,
                                            user_route.Route.storeordering);
                                      },
                                      icon: Icons.shopping_basket_outlined,
                                      title: 'ສັ່ງຊື້ໃໝ່'),
                                  StoreListItem(
                                      onTap: () async {
                                        storeModel.setUseMember(context);
                                        await storeModel
                                            .setBranchProductsModel(context);
                                      },
                                      icon: Icons.shopping_bag_outlined,
                                      title: 'ຂາຍສິນຄ້າ'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            'ສິນຄ້າທີ່ຂາຍດີສຸດ',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        storeModel.gettopProducts.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 10.w),
                                child: Container(
                                  height: 300.h,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: storeModel.gettopProducts.length,
                                    itemBuilder: (context, index) {
                                      return BestProduct(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StoreSaleDetail(
                                                  images: storeModel
                                                      .gettopProducts[index]
                                                      .images,
                                                  pname: storeModel
                                                      .gettopProducts[index]
                                                      .name
                                                      .toString(),
                                                  amount: storeModel
                                                      .gettopProducts[index]
                                                      .amount!,
                                                  price: storeModel
                                                      .gettopProducts[index]
                                                      .sellingPrice!,
                                                  detail: storeModel
                                                      .gettopProducts[index]
                                                      .details
                                                      .toString(),
                                                ),
                                              ));
                                        },
                                        image: storeModel.gettopProducts[index]
                                            .images.first.image
                                            .toString(),
                                        title: storeModel
                                            .gettopProducts[index].name
                                            .toString(),
                                        description: storeModel
                                            .gettopProducts[index].details
                                            .toString(),
                                        price:
                                            '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(storeModel.gettopProducts[index].sellingPrice)} ກີບ',
                                        titleCart: 'ລາຍລະອຽດ',
                                      );
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ທ່ານຍັງບໍ່ມີຮ້ານຄ້າ',
                          style: TextStyle(
                              color: MyColors.hintColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
          },
        ));
  }
}
