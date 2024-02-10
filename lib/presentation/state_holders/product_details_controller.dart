import 'package:crafty_bay/data/models/product_details_data.dart';
import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController{
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  // ProductDetailsData _productDetailsData = ProductDetailsData();
  //
  // ProductDetailsData get productDetails => _productDetailsData;

  ProductDetailsModel _productDetailsModel = ProductDetailsModel();

  ProductDetailsData get productDetails => _productDetailsModel.productDetailsDataList?.first ?? ProductDetailsData();

  Future<bool> getProductDetails(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(Urls.productDetails(productId));
    _inProgress = false;
    if(response.isSuccess){
      _productDetailsModel = ProductDetailsModel.fromJson(response.responseData);
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }
    update();
    return isSuccess;
  }
}