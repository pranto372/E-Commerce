class CreateWishListModel {
  String? msg;
  Data? data;

  CreateWishListModel({this.msg, this.data});

  CreateWishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? productId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({this.userId, this.productId, this.updatedAt, this.createdAt, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    productId = json['product_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
