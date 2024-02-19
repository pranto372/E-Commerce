import 'package:crafty_bay/presentation/state_holders/create_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/review_list_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ProductWishListController>().getProductWishList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Get.find<ProductWishListController>().getProductWishList(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (value){
          Get.find<MainBottomNavController>().backToHome();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: (){
                Get.find<MainBottomNavController>().backToHome();
              },
            ),
            title: const Text("WishList", style: TextStyle(
              fontSize: 18,
            ),),
            elevation: 3,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GetBuilder<ProductWishListController>(
              builder: (productWishListController) {
                return Visibility(
                  visible: productWishListController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: GridView.builder(
                      itemCount: productWishListController.productWishListModel.data?.length ?? 0,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.90,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 4
                      ),
                      itemBuilder: (context, index){
                      return FittedBox(
                          child: ProductItemCard(
                              product: productWishListController
                                  .productWishListModel.data![index].product!));
                    }
                  ),
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
