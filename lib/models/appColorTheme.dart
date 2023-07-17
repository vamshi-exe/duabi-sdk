import 'package:flutter/painting.dart';
import '../extensions.dart';

class AppColorTheme {
  String? bodyTxt;
  String? activeTabTxt;
  String? inactiveTabTxt;
  String? inactiveTabBkg;
  String? buttonBkg;
  String? buttonTxt;
  String? headerTopBkg;
  String? headerBottomBkg;
  String? headerTxt;
  String? headerDivider;

  Color? bodyTxtColor;
  Color? activeTabTextColor;
  Color? inactiveTabTextColor;
  Color? inactiveTabBackgroundColor;
  Color? buttonColor;
  Color? buttonTextColor;
  Color? headerTopBackColor;
  Color? headerBottomColor;
  Color? headerTextColor;
  Color? headerDividerColor;

  AppColorTheme(
      {this.bodyTxt,
      this.activeTabTxt,
      this.inactiveTabTxt,
      this.inactiveTabBkg,
      this.buttonBkg,
      this.buttonTxt,
      this.headerTopBkg,
      this.headerBottomBkg,
      this.headerTxt,
      this.headerDivider});

  AppColorTheme.fromJson(Map<String, dynamic> json) {
    bodyTxt = json['bodyTxt'];
    activeTabTxt = json['activeTabTxt'];
    inactiveTabTxt = json['inactiveTabTxt'];
    inactiveTabBkg = json['inactiveTabBkg'];
    buttonBkg = json['buttonBkg'];
    buttonTxt = json['buttonTxt'];
    headerTopBkg = json['headerTopBkg'];
    headerBottomBkg = json['headerBottomBkg'];
    headerTxt = json['headerTxt'];
    headerDivider = json['headerDivider'];

    // set color value
    bodyTxtColor = HexColor.fromHex(bodyTxt);
    activeTabTextColor = HexColor.fromHex(activeTabTxt);
    inactiveTabTextColor = HexColor.fromHex(inactiveTabTxt);
    inactiveTabBackgroundColor = HexColor.fromHex(inactiveTabBkg);
    buttonColor = HexColor.fromHex(buttonBkg);
    buttonTextColor = HexColor.fromHex(buttonTxt);
    headerTopBackColor = HexColor.fromHex(headerTopBkg);
    headerBottomColor = HexColor.fromHex(headerBottomBkg);
    headerTextColor = HexColor.fromHex(headerTxt);
    headerDividerColor = HexColor.fromHex(headerDivider);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bodyTxt'] = this.bodyTxt;
    data['activeTabTxt'] = this.activeTabTxt;
    data['inactiveTabTxt'] = this.inactiveTabTxt;
    data['inactiveTabBkg'] = this.inactiveTabBkg;
    data['buttonBkg'] = this.buttonBkg;
    data['buttonTxt'] = this.buttonTxt;
    data['headerTopBkg'] = this.headerTopBkg;
    data['headerBottomBkg'] = this.headerBottomBkg;
    data['headerTxt'] = this.headerTxt;
    data['headerDivider'] = this.headerDivider;
    return data;
  }
}
