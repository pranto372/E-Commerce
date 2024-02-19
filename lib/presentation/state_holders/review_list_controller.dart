import 'package:crafty_bay/data/models/cart_item.dart';
import 'package:crafty_bay/data/models/product_wish_list_model.dart';
import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/data/models/review_list_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:get/get.dart';

class ReviewListController extends GetxController{
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  // CartListModel _cartListModel = CartListModel();
  //
  // CartListModel get cartListModel => _cartListModel;

  ReviewListModel _reviewListModel = ReviewListModel();

  ReviewListModel get reviewListModel => _reviewListModel;

  Future<bool> getReviewList(String productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(Urls.reviewList +"/"+ productId);
    _inProgress = false;
    if(response.isSuccess){
      _reviewListModel = ReviewListModel.fromJson(response.responseData);
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}