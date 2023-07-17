import 'package:dubai_sdk_kotlin/models/customer_data.dart';
import 'package:dubai_sdk_kotlin/models/merchant_setting_data.dart';

class PaymentData {
  String? merchantCode;
  String? amount;
  String? currency;
  bool? showAddress;
  String? payOptId;
  String? paymentMethod;
  CardDetails? cardDetails;
  String? orderId;
  String? acessCode;
  String? redirectUrl;
  String? cancelUrl;
  String? rsaUrl;
  String? customerId;
  bool? saveCard;
  String? baseUrl;
  String? merchantParam1;
  String? merchantParam2;
  String? merchantParam3;
  String? merchantParam4;
  String? merchantParam5;
  String? appliedCoupon = "";
  String? appliedPromo = "";
  String? envType;
  String? siType;
  String? siRefNo;
  String? siSetupAmount;
  String? siAmount;
  String? siStartDate;
  String? siFreqType;
  String? siFreq;
  String? siBillCycle;

  CustomerData? billingAddress;
  CustomerData? shippingAddress;

  PaymentData(
      {this.merchantCode,
      this.amount,
      this.currency,
      this.showAddress,
      this.cardDetails,
      this.acessCode,
      this.redirectUrl,
      this.cancelUrl,
      this.orderId,
      this.rsaUrl,
      this.customerId,
      this.baseUrl,
      this.billingAddress,
      this.shippingAddress,
      this.saveCard,
      this.siAmount,
      this.merchantParam1,
      this.merchantParam2,
      this.merchantParam3,
      this.merchantParam4,
      this.merchantParam5,
      this.appliedCoupon,
      this.envType,
      this.siType,
      this.siRefNo,
      this.siSetupAmount,
      this.siStartDate,
      this.siFreqType,
      this.siFreq,
      this.siBillCycle,
      this.appliedPromo});

  Map<String, String> toJson() {
    final Map<String, String> data = {};
    data["mId"] = merchantCode.toString();
    data['accessCode'] = acessCode!;
    data['currency'] = currency!;
    data['amount'] = amount!;
    data['redirect_url'] = redirectUrl!;
    data['cancel_url'] = cancelUrl!;
    data['rsa_url'] = rsaUrl!;
    data['order_id'] = orderId!;
    data['customer_id'] = customerId!;
    data['show_address'] = "";
    data['promo'] = appliedPromo!;
    data['billing_name'] = billingAddress!.name!;
    data['billing_address'] = billingAddress!.address!;
    data['billing_country'] = billingAddress!.country!;
    data['billing_state'] = billingAddress!.state!;
    data['billing_city'] = billingAddress!.city!;
    data['billing_telephone'] = billingAddress!.mobileNo!;
    data['billing_email'] = billingAddress!.emailId!;
    data['shipping_name'] = shippingAddress!.name!;
    data['shipping_address'] = shippingAddress!.address!;
    data['shipping_country'] = shippingAddress!.country!;
    data['shipping_state'] = shippingAddress!.state!;
    data['shipping_city'] = shippingAddress!.city!;
    data['shipping_telephone'] = shippingAddress!.mobileNo!;
    data['envType'] = envType!;
    data['merchantParam1'] = merchantParam1 ?? "";
    data['merchantParam2'] = merchantParam2 ?? "";
    data['merchantParam3'] = merchantParam3 ?? "";
    data['merchantParam4'] = merchantParam4 ?? "";
    data['merchantParam5'] = merchantParam5 ?? "";
    data['siType'] = siType ?? "";
    data['siRef'] = siRefNo ?? "";
    data['siSetupAmount'] = siSetupAmount ?? "";
    data['siAmount'] = siAmount ?? "";
    data['siStartDate'] = siStartDate ?? "";
    data['siFreqType'] = siFreqType ?? "";
    data['siFreq'] = siFreq ?? "";
    data['siBillCycle'] = siBillCycle ?? "";
    if (showAddress != null) {
      data['display_address'] = showAddress! ? "Y" : "N";
    }

    return data;
  }
}

class CardDetails {
  String? cardNo;
  String? expMonth;
  String? expYear;
  String? brand;
  String? cvv;
  String? payOption;
  String? payCardType;
  String? payCardName;

  CardDetails(
      {this.cardNo,
      this.expMonth,
      this.expYear,
      this.brand,
      this.cvv,
      this.payOption,
      this.payCardType,
      this.payCardName});
}
