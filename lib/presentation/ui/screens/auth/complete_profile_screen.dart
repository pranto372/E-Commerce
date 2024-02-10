import 'package:crafty_bay/data/models/create_profile_params.dart';
import 'package:crafty_bay/presentation/state_holders/complete_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/verify_otp_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/home_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _cusNameTEController = TextEditingController();
  final TextEditingController _cusAddTEController = TextEditingController();
  final TextEditingController _cusCityTEController = TextEditingController();
  final TextEditingController _cusStateTEController = TextEditingController();
  final TextEditingController _cusPostCodeTEController = TextEditingController();
  final TextEditingController _cusCountryTEController = TextEditingController();
  final TextEditingController _cusPhoneTEController = TextEditingController();
  final TextEditingController _cusFaxTEController = TextEditingController();
  final TextEditingController _shipNameTEController = TextEditingController();
  final TextEditingController _shipAddTEController = TextEditingController();
  final TextEditingController _shipCityTEController = TextEditingController();
  final TextEditingController _shipStateTEController = TextEditingController();
  final TextEditingController _shipPostCodeTEController = TextEditingController();
  final TextEditingController _shipCountryTEController = TextEditingController();
  final TextEditingController _shipPhoneTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 48,
                ),
                const AppLogo(
                  height: 80,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Complete Profile",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 28
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Get started with us with your details",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusNameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Customer Name'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusAddTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Address'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusCityTEController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'City'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your City';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusStateTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'State'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your State';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusPostCodeTEController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(hintText: 'Post code'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your Post code';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusCountryTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Country'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your Country';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusPhoneTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Phone number'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cusFaxTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Fax'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your Fax';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipNameTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Ship_name'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your ship_name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipAddTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Ship_Address'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your Ship_address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipCityTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Ship_city'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your ship_city';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipStateTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Ship_State'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your ship_state';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipPostCodeTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Ship_Postcode'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your ship_postcode';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipCountryTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Ship_Country'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your ship_country';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _shipPhoneTEController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Ship_Phone'),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'Enter your ship_phone';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                    width: double.infinity,
                    child: GetBuilder<CompleteProfileController>(
                      builder: (completeProfileController) {
                        return Visibility(
                          visible: completeProfileController.inProgress == false,
                          replacement: const CenterCircularProgressIndicator(),
                          child: ElevatedButton(
                              onPressed: () async {
                                final createProfileParams = CreateProfileParams(
                                  _cusNameTEController.text.trim(),
                                  _cusAddTEController.text.trim(),
                                  _cusCityTEController.text.trim(),
                                  _cusStateTEController.text.trim(),
                                  _cusPostCodeTEController.text.trim(),
                                  _cusCountryTEController.text.trim(),
                                  _cusPhoneTEController.text.trim(),
                                  _cusFaxTEController.text.trim(),
                                  _shipNameTEController.text.trim(),
                                  _shipAddTEController.text.trim(),
                                  _shipCityTEController.text.trim(),
                                  _shipStateTEController.text.trim(),
                                  _shipPostCodeTEController.text.trim(),
                                  _shipCountryTEController.text.trim(),
                                  _shipPhoneTEController.text.trim()
                                );
                                if (_formKey.currentState!.validate()) {
                                  final bool result = await completeProfileController.createProfileData(
                                    Get.find<VerifyOtpController>().token,
                                    createProfileParams
                                  );
                                if (result) {
                                  Get.offAll(() => const MainBottomNavScreen());
                                } else {
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      title: 'Complete profile failed',
                                      message: completeProfileController.errorMessage,
                                      duration: const Duration(seconds: 2),
                                      isDismissible: true,
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text("Complete")),
                        );
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _cusNameTEController.dispose();
    _cusAddTEController.dispose();
    _cusCityTEController.dispose();
    _cusPostCodeTEController.dispose();
    _cusCountryTEController.dispose();
    _cusPhoneTEController.dispose();
    _cusFaxTEController.dispose();
    _shipNameTEController.dispose();
    _shipAddTEController.dispose();
    _shipCityTEController.dispose();
    _shipStateTEController.dispose();
    _shipPostCodeTEController.dispose();
    _shipCountryTEController.dispose();
    _shipPhoneTEController.dispose();
    super.dispose();
  }
}
