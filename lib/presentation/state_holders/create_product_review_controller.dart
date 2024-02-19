import 'package:crafty_bay/data/models/cart_item.dart';
import 'package:crafty_bay/data/models/product_wish_list_model.dart';
import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/data/models/review_list_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:get/get.dart';

class CreateProductReviewController extends GetxController{
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<bool> createProductReview() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final ResponseData response = await NetworkCaller().postRequest(Urls.createProductReview);
    _inProgress = false;
    if(response.isSuccess){
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}