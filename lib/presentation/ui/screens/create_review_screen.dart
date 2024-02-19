
import 'package:crafty_bay/presentation/state_holders/create_product_review_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});


  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {

  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _reviewTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<CreateProductReviewController>().createProductReview();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _firstNameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'First Name'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _lastNameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Last Name'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _reviewTEController,
                  maxLines: 10,
                  textInputAction: TextInputAction.none,
                  decoration: const InputDecoration(hintText: ' Write Review'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Review';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<CreateProductReviewController>(
                  builder: (createProductReviewController) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final bool result = await createProductReviewController.createProductReview();
                              if(result == true){
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    isDismissible: true,
                                    title: 'Submit',
                                    message: 'Review added',
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }else{
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    isDismissible: true,
                                    title: 'Failed',
                                    message: 'Something went wrong',
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          },
                          child: Visibility(
                              visible: createProductReviewController.inProgress == false,
                              replacement: const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              child: const Text('Submit'))),
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}