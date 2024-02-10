import 'package:crafty_bay/presentation/state_holders/create_invoice_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/payment_web_view_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CreateInvoiceController>().getCreateInvoice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check out"),
      ),
      body: GetBuilder<CreateInvoiceController>(
        builder: (createInvoiceController) {
          if(createInvoiceController.inProgress){
            return const CenterCircularProgressIndicator();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                  "Payable: ${createInvoiceController.paymentMethodListModel.data!.first.payable}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                    ),
                ),
                Text(
                  "Vat: ${createInvoiceController.paymentMethodListModel.data!.first.vat}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
                Text(
                  "Total: ${createInvoiceController.paymentMethodListModel.data!.first.total}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
                ListView.separated(
                    primary: false,
                      shrinkWrap: true,
                    itemCount: createInvoiceController.paymentMethodListModel
                            .data!.first.paymentMethodList?.length ?? 0,
                    itemBuilder: (context, index){
                    return ListTile(
                      onTap: (){
                        Get.to(() =>
                            PaymentWebViewScreen(url: createInvoiceController
                                .paymentMethodListModel.data!.first
                                .paymentMethodList![index]
                                .redirectGatewayURL ?? ''));
                      },
                        leading: Image.network(createInvoiceController
                                .paymentMethodListModel
                                .data!
                                .first
                                .paymentMethodList![index]
                                .logo ??
                            ''),
                        title: Text(createInvoiceController
                            .paymentMethodListModel
                            .data!
                            .first
                            .paymentMethodList![index]
                            .name ?? ''),
                      trailing: const Icon(Icons.arrow_circle_right_outlined),
                    );
                  }, separatorBuilder: (_, __)=> const Divider())
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
