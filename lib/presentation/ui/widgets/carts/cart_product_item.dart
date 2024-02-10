import 'package:crafty_bay/data/models/cart_item.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class CartProductItem extends StatefulWidget {
  const CartProductItem({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {

  late ValueNotifier<int> noOfItems = ValueNotifier(widget.cartItem.quantity);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Row(
        children: [
          Image.network(
            widget.cartItem.product?.image ?? '',
            width: 100,
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.cartItem.product?.title ?? '',
                            maxLines: 1,style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            overflow: TextOverflow.ellipsis
                          ),),
                          Row(
                            children: [
                              Text("Color: ${widget.cartItem.color ?? ''}", style: const TextStyle(
                                color: Colors.black54
                              ),),
                              const SizedBox(width: 8,),
                              Text("Size: ${widget.cartItem.size ?? ''}", style: const TextStyle(
                                  color: Colors.black54
                              ),)
                            ],
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.find<CartListController>().deleteCart(widget.cartItem.productId ?? 0);
                        setState(() {

                        });
                      },
                      icon: const Icon(Icons.delete_sharp),
                      color: Colors.black38,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "৳${widget.cartItem.product?.price ?? 0}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                    ValueListenableBuilder(
                        valueListenable: noOfItems,
                        builder: (context, value, _) {
                          return ItemCount(
                            initialValue: value,
                            minValue: 1,
                            maxValue: 20,
                            color: AppColors.primaryColor,
                            step: 1,
                            decimalPlaces: 0,
                            onChanged: (v) {
                              noOfItems.value = v.toInt();
                              Get.find<CartListController>().updateQuantity(
                                  widget.cartItem.id!,
                                  noOfItems.value
                              );
                            },
                          );
                        }
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}