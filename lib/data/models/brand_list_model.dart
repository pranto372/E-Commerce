import 'package:crafty_bay/data/models/brand_list_item.dart';

class BrandListModel {
  String? msg;
  List<BrandListItem>? brandListItem;

  BrandListModel({this.msg, this.brandListItem});

  BrandListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      brandListItem = <BrandListItem>[];
      json['data'].forEach((v) {
        brandListItem!.add(BrandListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (brandListItem != null) {
      data['data'] = brandListItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

