
import 'package:crafty_bay/presentation/state_holders/review_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/create_review_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/circle_icon_button.dart';
import 'package:crafty_bay/presentation/ui/widgets/review/review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({
    super.key, required this.productId,
  });

  final String productId;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ReviewListController>().getReviewList(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: GetBuilder<ReviewListController>(
        builder: (reviewListController) {
          if(reviewListController.inProgress){
            return const CenterCircularProgressIndicator();
          }
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.separated(
                    itemCount: reviewListController.reviewListModel.reviewListItem?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ReviewCard(reviewListItem: reviewListController.reviewListModel.reviewListItem![index],);
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 20,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Reviews (1000)',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      FloatingActionButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        backgroundColor: AppColors.primaryColor,
                        onPressed: () {
                          Get.to(()=> CreateReviewScreen());
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

