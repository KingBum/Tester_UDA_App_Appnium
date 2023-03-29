import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:uda_qlsv/components/welcome/rePassword_form.dart';
import 'package:uda_qlsv/controllers/welcome_controller.dart';
import 'package:uda_qlsv/theme/color.dart';

import '../../theme/input.dart';

class ForgetForm extends StatelessWidget {
  ForgetForm({Key? key}) : super(key: key);

  final WelcomeController c = Get.find<WelcomeController>();


  final dio = Dio();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 126,
              ),
              Center(child: Image.asset('assets/images/logo.png', width: 200)),
              Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 30, right: 30, bottom: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text("Quên Mật Khẩu,... ?", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: TextField(
                            cursorColor: kPrimaryColor,
                            onChanged: (String text) {
                              print(text);
                              c.email.value = text;
                            } ,

                            style: TextStyle(
                                // fontWeight: FontWeight.w500
                                color: Colors.black.withOpacity(0.8)),
                            decoration: kPrimaryInput.copyWith(
                                hintText: 'Địa Chỉ Email Đông Á',
                                prefixIcon: Icon(Ionicons.at_outline,
                                    color: Colors.black.withOpacity(0.5)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Obx(() => AnimatedOpacity(
                              opacity: c.loading.isTrue ? 0.5 : 1,
                              duration: const Duration(milliseconds: 300),
                              child: TextButton(
                                  onPressed: () async {
                                    final url = await c.forgetPass();
                                    const start = "token/";
                                    final startIndex = url?.indexOf(start);
                                    final trimToken = url?.substring(startIndex! + start.length, url.length);
                                    await dio.post('https://flutter.rohitchouhan.com/email-otp/v2.php?app_name=Mã Token của bạn là : "${trimToken}"&app_email=UDA Students&user_email=${c.email}');
                                    await Get.to(RePassword());

                                  } ,
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      width: double.infinity,
                                      color: kPrimaryColor,
                                      child: Center(
                                        child: Text('Gửi Link OTP'.toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14)),
                                      ),
                                    ),
                                  )),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
