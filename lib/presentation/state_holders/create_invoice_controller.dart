import 'package:crafty_bay/data/models/payment_method_list_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CreateInvoiceController extends GetxController{
  bool _inProgress = false;

  String _errorMessage = '';

  PaymentMethodListModel _paymentMethodListModel = PaymentMethodListModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  PaymentMethodListModel get paymentMethodListModel => _paymentMethodListModel;

  Future<bool> getCreateInvoice() async{
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.createInvoice);
    _inProgress = false;
    if(response.isSuccess){
      _paymentMethodListModel = PaymentMethodListModel.fromJson(response.responseData);
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}