import 'package:crafty_bay/data/models/profile.dart';
import 'package:crafty_bay/data/models/review_list_item.dart';

class ReviewListModel {
  String? msg;
  List<ReviewListItem>? reviewListItem;

  ReviewListModel({this.msg, this.reviewListItem});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      reviewListItem = <ReviewListItem>[];
      json['data'].forEach((v) {
        reviewListItem!.add(ReviewListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (reviewListItem != null) {
      data['data'] = reviewListItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



