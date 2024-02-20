import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/state_holders/create_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductItemCard extends StatefulWidget {
  const ProductItemCard({
    super.key, required this.product,
  });

  final ProductModel product;

  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: (){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Alert!'),
              content: const Text('Do you want to delete this product.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel', style: TextStyle(color: Colors.grey),),
                ),
                TextButton(
                  onPressed: () {
                    Get.find<ProductWishListController>().removeWishListProduct(widget.product.id ?? 0);
                    Get.back();
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );
      },
      onTap: (){
        Get.to(()=> ProductDetailsScreen(productId: widget.product.id!,));
      },
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 190,
        width: 160,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    widget.product.image ?? '',
                    width: 160,
                    height: 120,
                    fit: BoxFit.scaleDown,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis
                      ),),
                    Row(
                      children: [
                        Text(
                          "৳${widget.product.price ?? 0}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor
                        ),),
                        const SizedBox(width: 8,),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(Icons.star, color: Colors.amber,size: 16,),
                            Text(
                              '${widget.product.star ?? 0}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black45
                            ),)
                          ],
                        ),
                        const SizedBox(width: 8,),
                        Card(
                          color: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: (){},
                              child: const Icon(
                                Icons.favorite_outline_rounded,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
