import 'package:crafty_bay/data/models/product_details_data.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/color_selector.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/product_image_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/size_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ValueNotifier<int> noOfItems = ValueNotifier(1);
  List<Color> colors = [
    Colors.black54,
    Colors.blueGrey,
    AppColors.primaryColor,
    Colors.brown,
    Colors.black,
  ];
  List<String> sizes = [
    'S',
    'M',
    'L',
    'XL',
  ];

  Color? _selectedColor;
  String? _selectedSize;
  
  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: GetBuilder<ProductDetailsController>(
        builder: (productDetailsController) {
          return Visibility(
            visible: productDetailsController.inProgress == false,
            replacement: const CenterCircularProgressIndicator(),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductImageCarousel(
                        urls: [
                          productDetailsController.productDetails.img1 ?? '',
                          productDetailsController.productDetails.img2 ?? '',
                          productDetailsController.productDetails.img3 ?? '',
                          productDetailsController.productDetails.img4 ?? '',
                        ],
                      ),
                      productDetailsBody(productDetailsController.productDetails)
                      ],
                    ),
                  ),
                ),
                priceAndAddToCartSection
              ],
            ),
          );
        }
      ),
    );
  }

  Padding productDetailsBody(ProductDetailsData productDetails) {
    return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              productDetails.product?.title ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                            ),
                            ),
                          ),
                          incrementDecrementButton,
                        ],
                      ),
                      const SizedBox(height: 8,),
                      reviewAndRatingRow(productDetails.product?.star ?? 0),
                      const SizedBox(height: 16,),
                      const Text("Color", style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),),
                      ColorSelector(colors: productDetails.color
                      ?.split(',')
                      .map((e) => getColorFromString(e))
                      .toList() ?? [],
                      onChange: (selectedColor){
                        _selectedColor = selectedColor;
                        print(_selectedColor);
                      }),
                      const SizedBox(height: 16,),
                      const Text("Size", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),),
                      const SizedBox(height: 8,),
                      SizeSelector(sizes: productDetails.size?.split(',') ?? [], onChange: (s){
                        _selectedSize= s;
                      }),
                      const SizedBox(height: 16,),
                      const Text("Description", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),),
                      const SizedBox(height: 8,),
                      const Text(
                        '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.''',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12
                        ),
                      )
                    ],
                  ),
                );
  }

  ValueListenableBuilder<int> get incrementDecrementButton {
    return ValueListenableBuilder(
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
                                },
                              );
                            }
                        );
  }

  Row reviewAndRatingRow(int rating){
    return Row(
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(Icons.star, color: Colors.amber,size: 18,),
                            const SizedBox(width: 4,),
                            Text(
                              rating.toStringAsPrecision(2),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black45
                            ),)
                          ],
                        ),
                        const SizedBox(width: 8,),
                        InkWell(
                          onTap: (){

                          },
                          child: const Text("Reviews", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor
                          ),),
                        ),
                        const SizedBox(width: 8,),
                        Card(
                          color: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.favorite_outline_rounded, size: 12,color: Colors.white,),
                          ),
                        )
                      ],
                    );
  }

  Container get priceAndAddToCartSection {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
              Text(
                "\$120",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
            ],
          ),
          SizedBox(
            width: 110,
            child: GetBuilder<AddToCartController>(
              builder: (addToCartController) {
                return Visibility(
                  visible: addToCartController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () async {
                      if(_selectedColor != null && _selectedSize != null){
                        if(Get.find<AuthController>().isTokenNotNull){
                          final stringColor = colorToString(_selectedColor!);
                        final response = await addToCartController.getAddToCart(
                            widget.productId, stringColor, _selectedSize!, noOfItems.value);
                        if(response){
                            Get.showSnackbar(const GetSnackBar(
                              title: 'Success',
                              message: 'This product has been added to cart',
                              duration: Duration(seconds: 2),
                              isDismissible: true,
                            ));
                          }else{
                            Get.showSnackbar(GetSnackBar(
                              title: 'Add to Cart failed',
                              message: addToCartController.errorMessage,
                              duration: const Duration(seconds: 2),
                              isDismissible: true,
                            ));
                          }
                        }else{
                          Get.to(()=> const VerifyEmailScreen());
                        }
                      }else{
                        Get.showSnackbar(const GetSnackBar(
                          title: 'Add to Cart failed',
                          message: 'Something went wrong',
                          duration: Duration(seconds: 2),
                          isDismissible: true,
                        ));
                      }
                    },
                    child: const Text("Add to Cart"),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
  Color getColorFromString(String color) {
    color = color.toLowerCase();
    if (color == 'red') {
      return Colors.red;
    } else if (color == 'white') {
      return Colors.white;
    } else if (color == 'green') {
      return Colors.green;
    }
    return Colors.grey;
  }

  String colorToString(Color color) {
    if (color == Colors.red) {
      return 'Red';
    } else if (color == Colors.white) {
      return 'White';
    } else if (color == Colors.green) {
      return 'Green';
    }
    return 'Grey';
  }

//
  // Color getColorFromString(String colorCode){
  //   String code = colorCode.replaceAll('#', '');
  //   String hexCode = 'FF$code';
  //   return Color(int.parse('0x$hexCode'));
  // }
  //
  // String colorToHashColorCode(String colorCode){
  //   return colorCode.toString()
  //       .replaceAll('0xff', '#')
  //       .replaceAll('Color(', '')
  //       .replaceAll(')', '');
  // }
}


















