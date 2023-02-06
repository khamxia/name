import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meesooklife_app/business_provider/store_provider.dart';
import 'package:meesooklife_app/constant/font.dart';
import 'package:meesooklife_app/constant/image.dart';
import 'package:meesooklife_app/constant/my_colors.dart';
import 'package:provider/provider.dart';
import '../../../constant/theme.dart';

class StoreProductAll extends StatefulWidget {
  const StoreProductAll({super.key});

  @override
  State<StoreProductAll> createState() => _StoreProductAllState();
}

class _StoreProductAllState extends State<StoreProductAll> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ສິນຄ້າທີ່ຍັງເຫຼືອ',
            style: appBarStyle(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: MSLheme.appBarGradient),
          ),
        ),
        body: Consumer<StoreProvider>(
          builder: (context, storemodels, _) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'ຄົ້ນຫາສິນຄ້າ',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: storemodels.getproducts.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return searchController.text.isEmpty ||
                                storemodels.getproducts[index].name
                                    .toString()
                                    .toUpperCase()
                                    .contains(
                                        searchController.text.toUpperCase())
                            ? Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5.r),
                                            bottomLeft: Radius.circular(5.r)),
                                        image: storemodels.getproducts[index]
                                                    .images.first.image ==
                                                null
                                            ? const DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                  MyImages.msl1,
                                                ),
                                              )
                                            : DecorationImage(
                                                image: NetworkImage(storemodels
                                                    .getproducts[index]
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              storemodels
                                                  .getproducts[index].name
                                                  .toString(),
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            Text(
                                              '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(storemodels.getproducts[index].sellingPrice)} ກີບ',
                                              style: TextStyle(
                                                  color: MyColors.cancelColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          storemodels.getproducts[index].details
                                              .toString(),
                                          maxLines: 2,
                                          style: const TextStyle(
                                              color: MyColors.hintColor,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        Text(
                                          storemodels.getproducts[index].amount
                                              .toString(),
                                          maxLines: 2,
                                          style: const TextStyle(
                                              color: MyColors.hintColor,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              )
                            : const SizedBox();
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
