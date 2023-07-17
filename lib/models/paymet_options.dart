import 'dart:convert';

import 'package:dubai_sdk_kotlin/models/merchant_setting_data.dart';

class PaymentOptionsData {
  List<SavedCard>? savedCard;
  List<PayOptions>? payOptions;
  bool hasSaveCard = false;
  bool hasDebitCard = false;
  bool hasSamsungPay = false;
  bool hasUnionPay = false;
  PayOptions? debitCreditOption;
  PayOptions? samsungOption;
  PayOptions? unionPayOption;
  MerchantSetting? merchantSetting;

  PaymentOptionsData({this.savedCard, this.payOptions, this.merchantSetting});

  PaymentOptionsData.fromJson(Map<String, dynamic> jsonData) {
    try {
      savedCard = [];
      payOptions = [];
      if (jsonData['CustPayments'] != null) {
        final savedCardJson = json.decode(jsonData['CustPayments']);
        savedCardJson.forEach((v) {
          final saveCard = new SavedCard.fromJson(v);
          if (saveCard.payCardNo != null) {
            savedCard?.add(new SavedCard.fromJson(v));
          }
        });
      }
      if (savedCard!.isNotEmpty) {
        hasSaveCard = true;
      }
      if (jsonData['payOptions'] != null) {
        jsonData['payOptions'].forEach((v) {
          PayOptions options = new PayOptions.fromJson(v);
          print("options is ${options.payOpt}");
          if (!_checkDebitCreditCard(options)) {
            payOptions?.add(options);
          }
          if (options.payOpt == "OPTCRDC" || options.payOpt == "OPTDBCRD") {
            hasDebitCard = true;
            debitCreditOption = options;
          }
          if (options.payOpt == "OPTUNP") {
            print("inside union pay ${options.payOpt}");

            hasUnionPay = true;
            unionPayOption = options;
          }
          if (options.payOpt == "OPTSAMS") {
            hasSamsungPay = true;
            samsungOption = options;
          }
        });
      }
    } catch (e) {
      throw e;
    }
  }

  _checkDebitCreditCard(PayOptions options) {
    for (PayOptions data in payOptions!) {
      if (options.payOpt == "OPTCRDC" || options.payOpt == "OPTDBCRD") {
        print("payOptions indsid if ${data.payOpt}");
        return true;
      }
    }
    return false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.savedCard != null) {
      data['savedCard'] = this.savedCard!.map((v) => v.toJson()).toList();
    }
    if (this.payOptions != null) {
      data['payOptions'] = this.payOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SavedCard {
  int? payOptId;
  String? payOption;
  String? payCardType;
  String? payCardName;
  String? payCardNo;
  String? payCardExpiry;

  SavedCard(
      {this.payOptId,
      this.payOption,
      this.payCardType,
      this.payCardName,
      this.payCardNo,
      this.payCardExpiry});

  SavedCard.fromJson(Map<String, dynamic> json) {
    try {
      payOptId = json['payOptId'];
      payOption = json['payOption'];
      payCardType = json['payCardType'];
      payCardName = json['payCardName'];
      payCardNo = json['payCardNo'];
      payCardExpiry = json['payCardExpiry'];
    } catch (e) {
      throw e;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payOptId'] = this.payOptId;
    data['payOption'] = this.payOption;
    data['payCardType'] = this.payCardType;
    data['payCardName'] = this.payCardName;
    data['payCardNo'] = this.payCardNo;
    data['payCardExpiry'] = this.payCardExpiry;
    return data;
  }
}

class PayOptions {
  String? payOpt;
  String? payOptDesc;
  List<CardData>? cardsList;

  PayOptions({this.payOpt, this.payOptDesc, this.cardsList});

  PayOptions.fromJson(Map<String, dynamic> json) {
    payOpt = json['payOpt'];
    payOptDesc = json['payOptDesc'];
    if (json['cardsList'] != null) {
      final list = jsonDecode(json['cardsList']);
      cardsList = [];
      list.forEach((v) {
       // print("v is ${v.toString()}");
        cardsList!.add(new CardData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    try {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['payOpt'] = this.payOpt;
      data['payOptDesc'] = this.payOptDesc;
      if (this.cardsList != null) {
        data['cardsList'] = this.cardsList!.map((v) => v.toJson()).toList();
      }
      return data;
    } catch (e) {
      throw e;
    }
  }
}

class CardData {
  String? cardName;
  String? cardType;
  String? payOptType;
  String? payOptDesc;
  String? dataAcceptedAt;
  String? status;

  CardData(
      {this.cardName,
      this.cardType,
      this.payOptType,
      this.payOptDesc,
      this.dataAcceptedAt,
      this.status});

  CardData.fromJson(Map<String, dynamic> json) {
    cardName = json['cardName'];
    cardType = json['cardType'];
    payOptType = json['payOptType'];
    payOptDesc = json['payOptDesc'];
    dataAcceptedAt = json['dataAcceptedAt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardName'] = this.cardName;
    data['cardType'] = this.cardType;
    data['payOptType'] = this.payOptType;
    data['payOptDesc'] = this.payOptDesc;
    data['dataAcceptedAt'] = this.dataAcceptedAt;
    data['status '] = this.status;
    return data;
  }
}
