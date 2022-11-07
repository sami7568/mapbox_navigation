import 'package:eztransport/ui/screens/page5/page5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          Get.to(Page5());
        },
        child: Text("Agree"),
      )),
    );
  }
}
