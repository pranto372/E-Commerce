import 'dart:async';

import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});
  final String email;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int seconds = 120;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (seconds == 0) {
          timer.cancel();
          // You can add code to execute when the timer reaches zero
        } else {
          setState(() {
            seconds--;
          });
        }
      },
    );
  }

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
                  height: 120,
                ),
                const AppLogo(
                  height: 80,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Enter OTP Code",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "A 4 digit OTP code has been sent",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                PinCodeTextField(
                  keyboardType: TextInputType.number,
                  controller: _otpTEController,
                  length: 6,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.transparent,
                      inactiveFillColor: Colors.transparent,
                      inactiveColor: AppColors.primaryColor,
                      selectedFillColor: Colors.transparent,
                      selectedColor: Colors.purple),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<VerifyOtpController>(
                    builder: (verifyOtpController) {
                      return Visibility(
                        visible: verifyOtpController.inProgress == false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () async {
                            if(_formKey.currentState!.validate()){
                              final bool response = await verifyOtpController.verifyOTP(widget.email, _otpTEController.text);
                              if(response){
                                if(verifyOtpController.shouldNavigateCompleteProfile) {
                                  Get.to(() => const CompleteProfileScreen());
                                }else{
                                  Get.offAll(()=> const MainBottomNavScreen());
                                }
                              }else{
                                Get.showSnackbar(GetSnackBar(
                                  title: 'OTP verification Failed',
                                  message: verifyOtpController.errorMessage,
                                  duration: const Duration(seconds: 2),
                                  isDismissible: true,
                                ));
                              }
                            }
                          },
                          child: const Text("Next"),
                        ),
                      );
                    }
                  ),
                ),
                const SizedBox(height: 24,),
                RichText(text: TextSpan(
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  children: [
                    const TextSpan(
                      text: 'This code will expire '
                    ),
                    TextSpan(
                      text: '$seconds' + 's',
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                    ),
                    ),
                  ]
                )),
                TextButton(onPressed: (){}, child: const Text('Resend Code',
                style: TextStyle(color: Colors.grey),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
