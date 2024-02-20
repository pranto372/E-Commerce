import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/brand_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/category_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_banner_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/brand_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/product_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:crafty_bay/presentation/ui/widgets/category_brand_item.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/banner_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/category_item.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/section_title.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/home/circle_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 8,),
              searchTextField,
              const SizedBox(height: 16,),
              GetBuilder<HomeBannerController>(
                builder: (homeBannerController) {
                  return Visibility(
                    visible: homeBannerController.inProgress == false,
                    replacement: const CenterCircularProgressIndicator(),
                    child: BannerCarousel(
                      height: 180,
                      bannerList: homeBannerController.bannerListModel.bannerList ?? [],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16,),
              SectionTitle(
                title: "All Categories",
                onTapSeeAll: (){
                  Get.find<MainBottomNavController>().changeIndex(1);
                },
              ),
              categoryList,
              const SizedBox(height: 8),
              SectionTitle(
                title: 'All Brand',
                onTapSeeAll: () {
                  Get.to(const BrandScreen());
                },
              ),
              brandList,
              const SizedBox(height: 16,),
              SectionTitle(
                title: "Popular",
                onTapSeeAll: (){
                  Get.to(() => const ProductListScreen());
                },
              ),
              GetBuilder<PopularProductController>(
                  builder: (popularProductController) {
                return Visibility(
                  visible: popularProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      popularProductController.productListModel.productList ??
                          []),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: "Special",
                onTapSeeAll: () {},
              ),
              GetBuilder<SpecialProductController>(
                  builder: (specialProductController) {
                return Visibility(
                  visible: specialProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      specialProductController.productListModel.productList ??
                          []),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              SectionTitle(
                title: "New",
                onTapSeeAll: () {},
              ),
              GetBuilder<NewProductController>(builder: (newProductController) {
                return Visibility(
                  visible: newProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      newProductController.productListModel.productList ?? []),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }


  SizedBox get brandList {
    return SizedBox(
      height: 100,
      child: GetBuilder<BrandListController>(builder: (brandListController) {
        return Visibility(
          visible: brandListController.inProgress == false,
          replacement: const CenterCircularProgressIndicator(),
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: brandListController.brandListModel.brandListItem?.length ?? 0,
            itemBuilder: (context, index) {
              return CategoryBrandItem(
                brandListItem: brandListController.brandListModel.brandListItem![index],
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(
                width: 12,
              );
            },
          ),
        );
      }),
    );
  }

  SizedBox get categoryList {
    return SizedBox(
              height: 130,
              child: GetBuilder<CategoryController>(
                builder: (categoryController) {
                  return Visibility(
                    visible: categoryController.inProgress == false,
                    replacement: const CenterCircularProgressIndicator(),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryController.categoryListModel.categoryList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return CategoryItem(
                          category: categoryController.categoryListModel.categoryList![index],
                        );
                      },
                      separatorBuilder: (_, __) {
                        return const SizedBox(width: 8,);
                      },
                    ),
                  );
                }
              ),
            );
  }

  SizedBox productList(List<ProductModel> productList) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ProductItemCard(
            product: productList[index],
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(width: 8,);
        },
      ),
    );
  }
  
  TextFormField get searchTextField {
    return TextFormField(
              decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: Colors.grey.shade200,
                prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            );
  }

  AppBar get appBar{
    return AppBar(
      title: Image.asset(AssetsPath.logoNav),
      actions: [
        CircleIconButton(
          onTap: () async {
            await AuthController.clearAuthData();
            Get.offAll(()=> const VerifyEmailScreen());
          },
          iconData: Icons.person,
        ),
        const SizedBox(width: 10,),
        CircleIconButton(
          onTap: (){},
          iconData: Icons.call,
        ),
        const SizedBox(width: 10,),
        CircleIconButton(
          onTap: (){},
          iconData: Icons.notifications_active_outlined,
        ),
      ],
    );
  }
}

