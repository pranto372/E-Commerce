import 'package:crafty_bay/data/models/review_list_item.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/circle_icon_button.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({
    super.key, required this.reviewListItem,
  });

  final ReviewListItem reviewListItem;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleIconButton(
                    onTap: () {}, iconData: Icons.person),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${widget.reviewListItem.profile!.cusName}",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '${widget.reviewListItem.description}',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}