import 'package:crafty_bay/data/models/create_wish_list_model.dart';
import 'package:crafty_bay/data/models/product_list_model.dart';
import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CreateWishListController extends GetxController{
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  CreateWishListModel _createWishListModel = CreateWishListModel();

  CreateWishListModel get createWishListModel => _createWishListModel;

  // ProductListModel _productListModel = ProductListModel();
  //
  // ProductListModel get productListModel => _productListModel;

  Future<bool> createWishList(int id) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(Urls.createWishList(id));
    _inProgress = false;
    if(response.isSuccess){
      _createWishListModel = CreateWishListModel.fromJson(response.responseData);
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
















