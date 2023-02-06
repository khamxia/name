import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meesooklife_app/business_provider/history_provider.dart';
import 'package:meesooklife_app/business_provider/store_provider.dart';
import 'package:meesooklife_app/business_provider/wallet_provider.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/constant/theme.dart';
import 'package:meesooklife_app/business_provider/login_provider.dart';
import 'package:meesooklife_app/business_provider/products_provider.dart';
import 'package:meesooklife_app/utilities/clear_sharepref.dart';
import 'package:meesooklife_app/widget/card_item.dart';
import 'package:meesooklife_app/constant/routes.dart' as user_route;
import 'package:provider/provider.dart';

import '../history/history_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer5<LoginProvider, ProductsProvider, StoreProvider,
        WalletProvider, HistoryProvider>(
      builder:
          (context, model, promodel, storemodel, walletmodel, hismodel, _) {
        return Scaffold(
          body: model.getUserDashBoardModel != null
              ? NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        leading: const SizedBox(),
                        backgroundColor: MyColors.whiteColor,
                        expandedHeight: 170.0.w,
                        floating: false,
                        pinned: false,
                        flexibleSpace: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                        context, user_route.Route.profile)
                                    .then((val2) {
                                  model.setUserDashboard(context);
                                });
                              },
                              child: Container(
                                height: 200.h,
                                decoration: BoxDecoration(
                                    gradient: MSLheme.appBarGradient,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.r),
                                      bottomRight: Radius.circular(20.r),
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 60.h),
                                  child: SingleChildScrollView(
                                    child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 20.r,
                                          backgroundColor: MyColors.whiteColor,
                                          child: model.getImage.isNotEmpty
                                              ? CircleAvatar(
                                                  backgroundColor:
                                                      MyColors.whiteColor,
                                                  radius: 18.r,
                                                  backgroundImage: NetworkImage(
                                                      model.getImage),
                                                )
                                              : CircleAvatar(
                                                  backgroundColor:
                                                      MyColors.whiteColor,
                                                  radius: 18.r,
                                                  backgroundImage:
                                                      const AssetImage(
                                                          MyImages.account),
                                                ),
                                        ),
                                        title: Text(
                                          '${model.getFname.toString()} ${model.getLname.toString()}',
                                          style: const TextStyle(
                                              color: MyColors.whiteColor),
                                        ),
                                        subtitle: Text(
                                          model.getNumberPhone.toString(),
                                          style: const TextStyle(
                                              color: MyColors.whiteColor),
                                        ),
                                        trailing: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: MyColors.blueColor,
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0.r),
                                            child: const Text(
                                              'ລາຍລະອຽດ',
                                              style: TextStyle(
                                                  color: MyColors.whiteColor),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            )),
                        bottom: PreferredSize(
                            preferredSize: Size.fromHeight(50.h),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.w,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(30.r)),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      shadowColor: MyColors.blueColor,
                                      elevation: 5,
                                      backgroundColor: MyColors.blueColor,
                                    ),
                                    onPressed: () async {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          user_route.Route.logout,
                                          (route) => false);
                                      await clearShatePref(context);
                                    },
                                    child: Text(
                                      'ອອກຈາກລະບົບ',
                                      style: TextStyle(
                                          color: MyColors.whiteColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ))),
                      ),
                    ];
                  },
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.h),
                        child: Column(
                          children: [
                            CardItem(
                                title: 'ຈຳນວນເງິນ',
                                subtitle:
                                    'ຈຳນວນເງິນທີ່ຕ້ອງສົ່ງໃຫ້ Meesooklife4289',
                                icon: Icons.attach_money,
                                color: MyColors.tealColor,
                                onTap: () {
                                  walletmodel.setUserWallet(context);
                                  walletmodel.setBranchWallet(context);
                                  Navigator.pushNamed(
                                      context, user_route.Route.walletpage);
                                }),
                            CardItem(
                                title: 'ສິນຄ້າ',
                                subtitle: 'ຈຳນວນສິນຄ້າທັງໝົດໃນລະບົບ',
                                icon: Icons.shopping_bag_outlined,
                                color: Colors.green.shade600,
                                onTap: () {
                                  promodel.setCategory(context);
                                }),
                            CardItem(
                              title: 'ຮ້ານຄ້າ',
                              subtitle: 'ລາຍລະອຽດຂອງຮ້ານຄ້າ',
                              icon: Icons.shopping_cart,
                              color: Colors.amber.shade700,
                              onTap: () {
                                storemodel.setTopBranchProduct(context);
                                Navigator.pushNamed(
                                    context, user_route.Route.storepage);
                              },
                            ),
                            CardItem(
                                title: 'ປະຫວັດ',
                                subtitle: 'ທຸກໆປະຫວັດການເຄື່ອນໄຫວທັງໝົດຂອງທ່ານ',
                                icon: Icons.history,
                                color: MyColors.backgroundWeb,
                                onTap: () {
                                  hismodel.clearHistory();
                                  hismodel.setHistoryCompleted(context);
                                  hismodel.setHistoryCanceled(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HistoryPage(),
                                      ));
                                }),
                          ],
                        ),
                      ),
                    ),
                  ))
              : const SizedBox(),
        );
      },
    );
  }
}
