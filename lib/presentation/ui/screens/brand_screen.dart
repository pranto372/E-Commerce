
import 'package:crafty_bay/presentation/state_holders/brand_list_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/category_brand_item.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: GetBuilder<BrandListController>(builder: (brandListController) {
          return Visibility(
            visible: brandListController.inProgress == false,
            replacement: const CenterCircularProgressIndicator(),
            child: GridView.builder(
              itemCount: brandListController.brandListModel.brandListItem?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                return FittedBox(
                  child: CategoryBrandItem(
                    brandListItem: brandListController.brandListModel.brandListItem![index],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  AppBar get appBar {
    return AppBar(
      title: const Text('Brand'),
    );
  }
}