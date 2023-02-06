import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/wallet_provider.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:meesooklife_app/screen/wallet/wallet_detail.dart';
import 'package:meesooklife_app/widget/tab_bar.dart';
import 'package:meesooklife_app/widget/text_button.dart';
import 'package:meesooklife_app/widget/wallet_detail.dart';
import 'package:provider/provider.dart';
import '../../constant/font.dart';
import '../../constant/image.dart';
import '../../constant/theme.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  //int index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MSLButton(
            text: context.read<WalletProvider>().getindex == 0
                ? 'ສົ່ງເງິນ'
                : 'ສົ່ງເງິນໃນຮ້ານຄ້າ',
            onpressed: () async {
              if (context.read<WalletProvider>().getindex == 0) {
                if (context.read<WalletProvider>().getuserWalletHistory !=
                    null) {
                  context.read<WalletProvider>().setUserPayment(
                      context,
                      context
                          .read<WalletProvider>()
                          .getuserwalletModel!
                          .userWallet!
                          .moneyBuy);
                }
              } else {
                if (context.read<WalletProvider>().getbranchWalletHistory !=
                    null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WalletDetailPage(),
                    ),
                  );
                }
              }
            },
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
        body: Consumer<WalletProvider>(
          builder: (context, walletmodel, _) {
            return walletmodel.getuserwalletModel != null ||
                    walletmodel.getbranchrwalletModel != null
                ? DefaultTabController(
                    initialIndex: walletmodel.getindex,
                    length: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          indicatorColor: MyColors.tealColor,
                          onTap: (value) async {
                            walletmodel.setindex = value;
                          },
                          tabs: const [
                            TabBars(title: 'ເງິນໃນກະເປົ່າ'),
                            TabBars(title: 'ເງິນໃນຮ້ານຄ້າ'),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: MyColors.hoverColors),
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 10.w),
                              child: RichText(
                                text: TextSpan(
                                  text: walletmodel.getindex == 0
                                      ? 'ເງິນທີ່ຈະສົ່ງໃຫ້ Meesooklife4289: '
                                      : 'ເງິນໃນຮ້ານຄ້າ ທີ່ຈະສົ່ງໃຫ້ Meesooklife4289: ',
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontFamily: FONT_NOTOSANS,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp),
                                  children: [
                                    TextSpan(
                                        text: walletmodel.getindex == 0
                                            ? walletmodel
                                                        .getuserWalletHistory !=
                                                    null
                                                ? '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(walletmodel.getuserwalletModel!.userWallet!.moneyBuy)} ກີບ'
                                                : '0 ກີບ'
                                            : walletmodel
                                                        .getbranchWalletHistory !=
                                                    null
                                                ? '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(walletmodel.getbranchrwalletModel!.userWallet!.moneySale)} ກີບ'
                                                : '0 ກີບ',
                                        style: TextStyle(
                                            color: MyColors.cancelColor,
                                            fontFamily: FONT_NOTOSANS,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Divider(thickness: 2, indent: 10, endIndent: 10),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              walletmodel.getuserWalletHistory != null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 70),
                                      child: ListView.builder(
                                        itemCount: walletmodel
                                            .getuserWalletHistory!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return WalletDetail(
                                              images: MyImages.logo,
                                              billNo:
                                                  'ລະຫັດບິນ: ${walletmodel.getuserWalletHistory![index].billNo}',
                                              wallet:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(walletmodel.getuserWalletHistory![index].total)} ກີບ',
                                              detail:
                                                  'ໄດ້ຈາກການຊື້ສິນຄ້າໃນລະບົບ Meesooklife4289ຂອງພວກເຮົາ',
                                              date: (walletmodel
                                                      .getuserWalletHistory![
                                                          index]
                                                      .createdAt)
                                                  .toString()
                                                  .split('.')
                                                  .first);
                                        },
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            'ຍັງບໍ່ມີຂໍ້ມູນ',
                                            style: TextStyle(
                                                color: MyColors.hintColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                              walletmodel.getbranchWalletHistory != null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 70),
                                      child: ListView.builder(
                                        itemCount: walletmodel
                                            .getbranchWalletHistory!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return WalletDetail(
                                              images: MyImages.logo,
                                              billNo:
                                                  'ລະຫັດບິນ: ${walletmodel.getbranchWalletHistory![index].billNo}',
                                              wallet:
                                                  '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(walletmodel.getbranchWalletHistory![index].total)} ກີບ',
                                              detail:
                                                  'ໄດ້ຈາກການຂາຍສິນຄ້າໃນລະບົບ Meesooklife4289ຂອງພວກເຮົາ',
                                              date: (walletmodel
                                                      .getbranchWalletHistory![
                                                          index]
                                                      .createdAt)
                                                  .toString()
                                                  .split('.')
                                                  .first);
                                        },
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            'ຍັງບໍ່ມີຂໍ້ມູນ',
                                            style: TextStyle(
                                                color: MyColors.hintColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ))
                : const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: MyColors.blueColor,
                    color: MyColors.tealColor,
                  ));
          },
        ));
  }
}
