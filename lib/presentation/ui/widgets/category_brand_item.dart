
import 'package:crafty_bay/data/models/brand_list_item.dart';
import 'package:crafty_bay/data/models/category_list_item.dart';
import 'package:crafty_bay/presentation/ui/screens/product_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryBrandItem extends StatelessWidget {
  const CategoryBrandItem({
    super.key,this.categoryListItem, this.brandListItem,
  });

  final CategoryListItem? categoryListItem;
  final BrandListItem? brandListItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductListScreen(
          category: categoryListItem?.categoryName ?? brandListItem?.brandName ?? '',
          categoryId: categoryListItem?.id ?? brandListItem?.id,
        ));
      },
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: AppColors.primaryColor.withOpacity(0.1),
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.network(
                  categoryListItem?.categoryImg ?? brandListItem?.brandImg ?? '',
                  width: 50,
                  height: 50,
                )),
          ),
          Text(
            categoryListItem?.categoryName ?? brandListItem?.brandName ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}