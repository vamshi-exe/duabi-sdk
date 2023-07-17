import 'package:dubai_sdk_kotlin/models/payment_data.dart';
import 'package:dubai_sdk_kotlin/page/home_page.dart';
import 'package:flutter/material.dart';

import '../../style/app_colors.dart';
import '../../style/spacing.dart';

class PaymentStatus extends StatefulWidget {
  final String resp;

  const PaymentStatus({Key? key, required this.resp}) : super(key: key);
  @override
  _PaymentStatusState createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  Future<bool> onWillPop() async {
    return await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false);
    ;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Payment Status"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  // Text(
                  //   "Order Status : " + widget.status,
                  //   style:
                  //       new TextStyle(fontSize: 20, color: AppColors.blueAccent),
                  // ),
                  SizedBox(height: 20),
                  Text(
                    widget.resp,
                    style: new TextStyle(
                        fontSize: 14, color: AppColors.blackLight),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
