import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:uda_qlsv/controllers/welcome_controller.dart';
import 'package:uda_qlsv/theme/color.dart';
import 'package:uda_qlsv/views/welcome_view.dart';

import '../../theme/input.dart';

class RePassword extends StatelessWidget {
  RePassword({Key? key}) : super(key: key);

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
                              c.newpw.value = text;
                            } ,

                            style: TextStyle(
                              // fontWeight: FontWeight.w500
                                color: Colors.black.withOpacity(0.8)),
                            decoration: kPrimaryInput.copyWith(
                                hintText: 'Nhập mật khẩu mới của bạn',
                                prefixIcon: Icon(Ionicons.at_outline,
                                    color: Colors.black.withOpacity(0.5)))),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: TextField(
                            cursorColor: kPrimaryColor,
                            onChanged: (String text) {
                              c.token.value = text;
                            } ,

                            style: TextStyle(
                              // fontWeight: FontWeight.w500
                                color: Colors.black.withOpacity(0.8)),
                            decoration: kPrimaryInput.copyWith(
                                hintText: 'Nhập dãy token đã gửi vào Email',
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
                                await c.rePassword();
                                await Get.to(WelcomeView());
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
                                    child: Text('Đổi Mật Khẩu'.toUpperCase(),
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
