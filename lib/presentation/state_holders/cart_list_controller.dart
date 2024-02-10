import 'package:crafty_bay/data/models/cart_item.dart';
import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:get/get.dart';

class CartListController extends GetxController{
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  CartListModel _cartListModel = CartListModel();

  CartListModel get cartListModel => _cartListModel;

  final RxDouble _totalPrice = 0.0.obs;

  RxDouble get totalPrice  => _totalPrice;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(Urls.cartList);
    _inProgress = false;
    if(response.isSuccess){
      _cartListModel = CartListModel.fromJson(response.responseData);
      _totalPrice.value = _calculateTotalPrice;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }

  void updateQuantity(int id, int quantity) {
    _cartListModel.cartItemList?.firstWhere((element) => element.id == id)
        .quantity = quantity;
    _totalPrice.value = _calculateTotalPrice;
  }

  double get _calculateTotalPrice {
    double total = 0;
    for(CartItem item in _cartListModel.cartItemList ?? []){
      total += (double.tryParse(item.product?.price ?? '0') ?? 0) * item.quantity;
    }
    return total;
  }

  Future<bool> deleteCart(int id) async{
    _inProgress = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(Urls.deleteCart(id));
    _inProgress = false;
    if(response.isSuccess){
      //_cartListModel = CartListModel.fromJson(response.responseData);
      _cartListModel.cartItemList?.removeWhere((element) => element.productId == id);
      _calculateTotalPrice;
      update();
      return true;
    }else{
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}