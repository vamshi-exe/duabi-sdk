//import 'package:plugin_ccavenue/plugin_ccavenue.dart';
import 'dart:convert';
import 'dart:io';

import 'package:dubai_sdk_kotlin/page/payment_status.dart';
import 'package:flutter/services.dart';
import 'package:dubai_sdk_kotlin/custom_widgets/app_text_field_home.dart';
import 'package:dubai_sdk_kotlin/models/customer_data.dart';
import 'package:dubai_sdk_kotlin/models/payment_data.dart';
import 'package:dubai_sdk_kotlin/pattern/common_pattern.dart';
import 'package:dubai_sdk_kotlin/resources/strings/app_strings.dart';
import 'package:dubai_sdk_kotlin/style/app_colors.dart';
import 'package:dubai_sdk_kotlin/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../custom_widgets/app_text_field_home.dart';
import '../../resources/strings/app_strings.dart';
import '../../style/app_colors.dart';
import '../../style/spacing.dart';
import 'dart:math';

import '../custom_widgets/app_radio_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with RouteAware {
  final _accessCodeController =
      TextEditingController(text: AppStrings.accessCode_stg);
  final _merchantIdController =
      TextEditingController(text: AppStrings.merchantId_stg);
  final _currencyController = TextEditingController(text: "AED");
  final _orderIdController = TextEditingController(text: "1234");
  final _amountController = TextEditingController(text: "2000.00");
  final _promoCodeController = TextEditingController();
  final _redirectController =
      TextEditingController(text: AppStrings.redirectUrl_stg);
  final _cancelController =
      TextEditingController(text: AppStrings.cancelUrl_stg);
  final _rsaController = TextEditingController(text: AppStrings.rsaUrl_stg);
  final _customerIdController =
      TextEditingController(text: AppStrings.customerIdentityfier_stg);
  final _merchantP1Controller = TextEditingController(text: "test1");
  final _merchantP2Controller = TextEditingController(text: "test2");
  final _merchantP3Controller = TextEditingController(text: "test3");
  final _merchantP4Controller = TextEditingController(text: "test4");
  final _merchantP5Controller = TextEditingController(text: "test5");

  final _billingName = TextEditingController(text: "Charli");
  final _billingAddress =
      TextEditingController(text: "Room no-101, Near station road");
  final _billingCity = TextEditingController(text: "Mumbai");
  final _billingCountry = TextEditingController(text: "India");
  final _billingState = TextEditingController(text: "Maharastra");
  final _billingPhone = TextEditingController(text: "9762123123");
  final _billingEmail = TextEditingController(text: "test@avenues.info");

  final _shippingName = TextEditingController(text: "Charli Alpha");
  final _shippingAddress =
      TextEditingController(text: "Room no-102, Near station road");
  final _shippingCity = TextEditingController(text: "Mumbai");
  final _shippingCountry = TextEditingController(text: "India");
  final _shippingState = TextEditingController(text: "Maharastra");
  final _shippingPhone = TextEditingController(text: "9762123122");
  final _shippingEmail = TextEditingController(text: "charli@avenues.info");
  List<String> _currencyList = ["INR", "AED"];

  bool _showAddress = true;
  Random random = new Random();
  String _selectedEnvironment = AppStrings.QA;

  int _siType = 3;
  int _siSetUp = 1;
  int _siFreq = 1;
  final _siRefNoController = TextEditingController();
  final _siStartDateController = TextEditingController();
  final _siFeqController = TextEditingController();
  final _siBillCycleController = TextEditingController();
  final _siAmountController = TextEditingController();

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  void initState() {
    _orderIdController.text = (random.nextInt(9999999) + 1000000).toString();
    super.initState();

    _setEnvironment(_selectedEnvironment);
  }

  showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  String getsiType() {
    if (Platform.isAndroid) {
      return _siType == 1
          ? "FIXED"
          : _siType == 2
              ? "ONDEMAND"
              : "";
    } else {
      return _siType == 1
          ? "FIXED"
          : _siType == 2
              ? "ONDEMAND"
              : "";
    }
  }

  String getSetUpAmount() {
    return _siSetUp == 1 ? "Y" : "N";
  }

  String getFreqType() {
    if (Platform.isAndroid) {
      return _siFreq == 1
          ? "days"
          : _siFreq == 2
              ? "month"
              : "year";
    } else {
      return _siFreq == 1
          ? "days"
          : _siFreq == 2
              ? "month"
              : "year";
    }
  }

  _validate() async {
    if (_merchantIdController.text.isEmpty) {
      showSnackBar(context, "Please Enter Merchant id");
    } else if (_amountController.text.isEmpty) {
      showSnackBar(context, "Please enter Amount");
    } else if (double.parse(_amountController.text.toString()) <= 0) {
      showSnackBar(context, "Please enter Amount greater then 0");
    } else if (_accessCodeController.text.isEmpty) {
      showSnackBar(context, "Please enter Access Code");
    } else if (_orderIdController.text.isEmpty) {
      showSnackBar(context, "Please enter Order Id");
    } else if (_currencyController.text.isEmpty) {
      showSnackBar(context, "Please enter Currency");
    } else if (_redirectController.text.isEmpty) {
      showSnackBar(context, "Please enter Redirect Url");
    } else if (_cancelController.text.isEmpty) {
      showSnackBar(context, "Please enter Cancel Url");
    } else if (_rsaController.text.isEmpty) {
      showSnackBar(context, "Please enter RSA Key Url");
    } else {
      if (_siType != 3) {
        if (_siStartDateController.text.isEmpty) {
          showSnackBar(context, "Please enter si Start Date");
          return;
        } else if (_siFeqController.text.isEmpty && _siType == 1) {
          showSnackBar(context, "Please enter si Freq");
          return;
        } else if (_siAmountController.text.isEmpty && _siType == 1) {
          showSnackBar(context, "Please enter si Amount");
          return;
        } else if (_siBillCycleController.text.isEmpty && _siType == 1) {
          showSnackBar(context, "Please enter si bill cycle");
          return;
        }
      }
      final data = PaymentData(
        merchantCode: _merchantIdController.text,
        amount: _amountController.text,
        currency: _currencyController.text,
        showAddress: _showAddress,
        orderId: _orderIdController.text,
        acessCode: _accessCodeController.text,
        rsaUrl: _rsaController.text,
        redirectUrl: _redirectController.text,
        cancelUrl: _cancelController.text,
        // baseUrl: _setBaseUrl(_selectedEnvironment),
        customerId: _customerIdController.text,
        merchantParam1: _merchantP1Controller.text,
        merchantParam2: _merchantP2Controller.text,
        merchantParam3: _merchantP3Controller.text,
        merchantParam4: _merchantP4Controller.text,
        merchantParam5: _merchantP5Controller.text,
        appliedCoupon: "",
        appliedPromo: _promoCodeController.text,
        envType: getEnvTypePlatform(),
        billingAddress: getBillingData(),
        shippingAddress: getShippingData(),
        siType: getsiType(),
        siRefNo: _siRefNoController.text,
        siSetupAmount: getSetUpAmount(),
        siAmount: _siAmountController.text,
        siStartDate: _siStartDateController.text,
        siFreqType: getFreqType(),
        siFreq: _siFeqController.text,
        siBillCycle: _siBillCycleController.text,
      );

      // TODO : call native code

      print("data is " + data.toJson().toString());

      //  PluginCcavenue.pay(data.toJson());
      final response = await pay(data.toJson());

      print("response is " + response.toString());
      final value = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PaymentStatus(
              resp: response,
            ),
          ));
      // if (value != null) {
      //   // print("error value is $value");
      //   if (value is bool) {
      //   } else {
      //     showSnackBar(context, value);
      //   }
      // }
    }
  }

  String getEnvTypePlatform() {
    if (Platform.isIOS) {
      if (_selectedEnvironment == AppStrings.QA) {
        return AppStrings.QA_IOS;
      }
      if (_selectedEnvironment == AppStrings.STATGING) {
        return AppStrings.STATGING_IOS;
      }
      if (_selectedEnvironment == AppStrings.PRODUCTION) {
        return AppStrings.PRODUCTION_IOS;
      }
    }
    return _selectedEnvironment;
  }

  Future<String> pay(Map<String, String> data) async {
    const MethodChannel _channel = MethodChannel('plugin_ccavenue');
    return await _channel.invokeMethod('payCCAvenue', data);
  }

  CustomerData getBillingData() {
    return CustomerData(
      name: _billingName.text,
      address: _billingAddress.text,
      city: _billingCity.text,
      state: _billingState.text,
      country: _billingCountry.text,
      mobileNo: _billingPhone.text,
      emailId: _billingEmail.text,
      isBilling: true,
    );
  }

  CustomerData getShippingData() {
    return CustomerData(
      name: _shippingName.text,
      address: _shippingAddress.text,
      city: _shippingCity.text,
      state: _shippingState.text,
      country: _shippingCountry.text,
      mobileNo: _shippingPhone.text,
      emailId: _shippingEmail.text,
      isBilling: false,
    );
  }

  String _setBaseUrl(String value) {
    String baseUrl;
    if (value == AppStrings.QA) {
      baseUrl = Endpoints.testUrl;
    } else if (value == AppStrings.STATGING) {
      baseUrl = Endpoints.stgUrl;
    } else {
      baseUrl = Endpoints.baseUrl;
    }
    return baseUrl;
  }

  _setEnvironment(String value) {
    String merchantId, accessCode, customerId, rsaUrl, cancelUrl;
    if (value == AppStrings.QA) {
      merchantId = AppStrings.merchantId_test;
      accessCode = AppStrings.accessCode_test;
      customerId = AppStrings.customerIdentityfier_test;
      rsaUrl = AppStrings.rsaUrl_test;
      cancelUrl = AppStrings.cancelUrl_test;
    } else if (value == AppStrings.STATGING) {
      merchantId = AppStrings.merchantId_stg;
      accessCode = AppStrings.accessCode_stg;
      customerId = AppStrings.customerIdentityfier_stg;
      rsaUrl = AppStrings.rsaUrl_stg;
      cancelUrl = AppStrings.cancelUrl_stg;
    } else {
      merchantId = AppStrings.merchantId;
      accessCode = AppStrings.accessCode;
      customerId = AppStrings.customerIdentityfier;
      rsaUrl = AppStrings.rsaUrl;
      cancelUrl = AppStrings.cancelUrl;
    }

    setState(() {
      _merchantIdController.text = merchantId;
      _accessCodeController.text = accessCode;
      _rsaController.text = rsaUrl;
      _cancelController.text = cancelUrl;
      _redirectController.text = cancelUrl;
      _selectedEnvironment = value;
    });
  }

  _selectDate() async {
    DateTime? selectedDate;
    if (_siStartDateController.text.isNotEmpty) {
      selectedDate =
          DateFormat('dd-MM-yyyy').parse(_siStartDateController.text);
    }
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _siStartDateController.text =
            DateFormat('dd-MM-yyyy').format(selectedDate!);
      });
    }
  }

  // TODO: 3 api calls //
  // getEnc
  getEnc() async {
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://122.182.6.212:8080/MobPHPKit/dubai/mobileutility/decrypt.php'));
    request.bodyFields = {
      'enc_request':
          'a5f96d2e41aec79919271a8433f834a0adb5c2675a252ae1c76570cf4a72ad1420188dd73741d59b5d1835507df236e731d745c0abd7136076007d6d3027acd7224c2ac398c7b47ee207d91fdbc4959e0ade90edf42390ab9fb676c1c3cee4beb84c598fec2619276eec9565ba892ba9be705deceeef5e42ac10cd388551971addd61ce1826039d4b0a5cc72c74cebcc98308d062e4bc65b09c732e42b849908',
      'access_code': 'AVRP02BI23BU48PRUB'
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  ////
  ///trackid
  trackid() async {
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://securetest.ccavenue.ae/transaction/appV1.do?command=generateTrackingId'));
    request.body =
        '''{\n"access_code": "AVRP02BI23BU48PRUB",\n"encRequest": "113c762f9e62c3c0b6edc37c2a34c723de82f3087007f1628932fc0cb2f74239e71fc6c19afd10a71d232aac06481d23b6cbb8616ec0cb8edfa348abdf666ae5d93cf58700077c6c8e2e86b1de5f5ff6893064ace98dfbe377a37fab7812a8b9"\n}''';

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  /// decrypt
  decrypt() async {
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://122.182.6.212:8080/MobPHPKit/dubai/mobileutility/decrypt.php'));
    request.bodyFields = {
      'enc_request':
          'a5f96d2e41aec79919271a8433f834a0adb5c2675a252ae1c76570cf4a72ad1420188dd73741d59b5d1835507df236e731d745c0abd7136076007d6d3027acd7224c2ac398c7b47ee207d91fdbc4959e0ade90edf42390ab9fb676c1c3cee4beb84c598fec2619276eec9565ba892ba9be705deceeef5e42ac10cd388551971addd61ce1826039d4b0a5cc72c74cebcc98308d062e4bc65b09c732e42b849908',
      'access_code': 'AVRP02BI23BU48PRUB'
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Merchant Checkout"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey400, width: 1.0),
                    borderRadius: BorderRadius.circular(1.0)),
                margin: const EdgeInsets.all(Spacing.smallMargin),
                padding:
                    const EdgeInsets.symmetric(horizontal: Spacing.bigMargin),
                child: DropdownButton<String>(
                    underline: Container(),
                    value: _selectedEnvironment,
                    isExpanded: true,
                    hint: Text("Please Select Environment"),
                    //elevation: 5,
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                    items: [
                      AppStrings.QA,
                      AppStrings.STATGING,
                      AppStrings.PRODUCTION
                    ]
                        .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ))
                        .toList(),
                    onChanged: (String? value) {
                      _setEnvironment(value!);
                      // setState(() {
                      //   _selectedEnvironment = value;
                      // });
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey400, width: 1.0),
                    borderRadius: BorderRadius.circular(1.0)),
                margin: const EdgeInsets.all(Spacing.smallMargin),
                child: ExpansionTile(
                  title: Text(
                    "Merchant Details",
                    style: new TextStyle(
                        fontSize: 20, color: AppColors.blueAccent),
                  ),
                  childrenPadding: EdgeInsets.all(Spacing.mediumMargin),
                  children: [
                    SizedBox(height: 8),
                    AppTextFieldHome(
                      controller: _accessCodeController,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterMerchantAccessCode,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _merchantIdController,
                      textInputType: TextInputType.number,
                      hintText: AppStrings.enterMerchantId,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _currencyController,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterCurrency,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _orderIdController,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterOrderId,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _amountController,
                      textInputType: TextInputType.number,
                      hintText: AppStrings.enterAmount,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _promoCodeController,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterPrmo,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _redirectController,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterRedirectUrl,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _cancelController,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterCAncelUrl,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _rsaController,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterRSAUrl,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _customerIdController,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterCustomerId,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _merchantP1Controller,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterMerchantP1,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _merchantP2Controller,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterMerchantP2,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _merchantP3Controller,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterMerchantP3,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _merchantP4Controller,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterMerchantP4,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _merchantP5Controller,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterMerchantP5,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey400, width: 1.0),
                    borderRadius: BorderRadius.circular(1.0)),
                margin: const EdgeInsets.all(Spacing.smallMargin),
                child: ExpansionTile(
                  title: Text(
                    "Billing Address Details",
                    style: new TextStyle(
                        fontSize: 20, color: AppColors.blueAccent),
                  ),
                  childrenPadding: EdgeInsets.all(Spacing.mediumMargin),
                  children: [
                    SizedBox(height: 8),
                    AppTextFieldHome(
                      controller: _billingName,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterBillingName,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _billingAddress,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterBillingAddress,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _billingCity,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterBillingCity,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _billingState,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterBillingState,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _billingCountry,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterBillingCountry,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _billingPhone,
                      textInputType: TextInputType.number,
                      hintText: AppStrings.enterBillingPhone,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _billingEmail,
                      textInputType: TextInputType.emailAddress,
                      hintText: AppStrings.enterBillingEmail,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey400, width: 1.0),
                    borderRadius: BorderRadius.circular(1.0)),
                margin: const EdgeInsets.all(Spacing.smallMargin),
                child: ExpansionTile(
                  title: Text(
                    "Shipping Address Details",
                    style: new TextStyle(
                        fontSize: 20, color: AppColors.blueAccent),
                  ),
                  childrenPadding: EdgeInsets.all(Spacing.mediumMargin),
                  children: [
                    SizedBox(height: 8),
                    AppTextFieldHome(
                      controller: _shippingName,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterShippingName,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _shippingAddress,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterShippingAddress,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _shippingCity,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterShippingCity,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _shippingState,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterShippingState,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _shippingCountry,
                      textInputType: TextInputType.text,
                      hintText: AppStrings.enterShippingCountry,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                    SizedBox(height: 10),
                    AppTextFieldHome(
                      controller: _shippingPhone,
                      textInputType: TextInputType.number,
                      hintText: AppStrings.enterShippingPhone,
                      fillColor: AppColors.white,
                      borderSide: BorderSide(color: AppColors.grey400),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey400, width: 1.0),
                    borderRadius: BorderRadius.circular(1.0)),
                margin: const EdgeInsets.all(Spacing.smallMargin),
                child: ExpansionTile(
                  title: Text(
                    "Standard Instruction",
                    style: new TextStyle(
                        fontSize: 20, color: AppColors.blueAccent),
                  ),
                  childrenPadding: EdgeInsets.all(Spacing.mediumMargin),
                  children: [
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text("SI Type : "),
                        AppRadioButton(
                          value: 1,
                          groupValue: _siType,
                          title: "Fixed",
                          onChange: (int? value) {
                            setState(() {
                              _siType = value!;
                            });
                          },
                        ),
                        AppRadioButton(
                          value: 2,
                          groupValue: _siType,
                          title: "On Demand",
                          onChange: (int? value) {
                            setState(() {
                              _siType = value!;
                            });
                          },
                        ),
                        AppRadioButton(
                          value: 3,
                          groupValue: _siType,
                          title: "None",
                          onChange: (int? value) {
                            setState(() {
                              _siType = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Visibility(
                      visible: _siType != 3,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          AppTextFieldHome(
                            controller: _siRefNoController,
                            textInputType: TextInputType.text,
                            hintText: "Ref No. (Optional)",
                            fillColor: AppColors.white,
                            borderSide: BorderSide(color: AppColors.grey400),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text("Setup Amt (Y/N) : "),
                              AppRadioButton(
                                value: 1,
                                groupValue: _siSetUp,
                                title: "Yes",
                                onChange: (int? value) {
                                  setState(() {
                                    _siSetUp = value!;
                                  });
                                },
                              ),
                              AppRadioButton(
                                value: 2,
                                groupValue: _siSetUp,
                                title: "No",
                                onChange: (int? value) {
                                  setState(() {
                                    _siSetUp = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: _siType == 1,
                            child: Column(
                              children: [
                                AppTextFieldHome(
                                  controller: _siAmountController,
                                  textInputType: TextInputType.number,
                                  hintText: "Amount",
                                  fillColor: AppColors.white,
                                  borderSide:
                                      BorderSide(color: AppColors.grey400),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate();
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: AppTextFieldHome(
                                controller: _siStartDateController,
                                textInputType: TextInputType.text,
                                hintText: "Start Date ( DD-MM-YYYY)",
                                fillColor: AppColors.white,
                                borderSide:
                                    BorderSide(color: AppColors.grey400),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Visibility(
                            visible: _siType == 1,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Freq. Type : "),
                                    AppRadioButton(
                                      value: 1,
                                      groupValue: _siFreq,
                                      title: "Days",
                                      onChange: (int? value) {
                                        setState(() {
                                          _siFreq = value!;
                                        });
                                      },
                                    ),
                                    AppRadioButton(
                                      value: 2,
                                      groupValue: _siFreq,
                                      title: "Month",
                                      onChange: (int? value) {
                                        setState(() {
                                          _siFreq = value!;
                                        });
                                      },
                                    ),
                                    AppRadioButton(
                                      value: 3,
                                      groupValue: _siFreq,
                                      title: "Year",
                                      onChange: (int? value) {
                                        setState(() {
                                          _siFreq = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                AppTextFieldHome(
                                  controller: _siFeqController,
                                  textInputType: TextInputType.number,
                                  hintText: "Si Freq.",
                                  fillColor: AppColors.white,
                                  borderSide:
                                      BorderSide(color: AppColors.grey400),
                                ),
                                SizedBox(height: 10),
                                AppTextFieldHome(
                                  controller: _siBillCycleController,
                                  textInputType: TextInputType.number,
                                  hintText: "Si bill cycle",
                                  fillColor: AppColors.white,
                                  borderSide:
                                      BorderSide(color: AppColors.grey400),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CheckboxListTile(
                title: Text(AppStrings.showAddress),
                value: _showAddress,
                onChanged: (bool? value) {
                  setState(() {
                    if (value != null) {
                      _showAddress = value;
                    }
                    // _updateCheckBox(value!);
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 15),
              // ignore: deprecated_member_use
              ElevatedButton(
                onPressed: () {
                  _validate();
                },
                child: Text(AppStrings.launchScreen,
                    style: TextStyle(color: AppColors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  getEnc();
                },
                child: Text('enc', style: TextStyle(color: AppColors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  trackid();
                },
                child:
                    Text('trackid', style: TextStyle(color: AppColors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  decrypt();
                },
                child: Text('dec', style: TextStyle(color: AppColors.white)),
              ),
            ],
          ),
        ));
  }
}
