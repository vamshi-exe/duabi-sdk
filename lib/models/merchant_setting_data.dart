class MerchantSetting {
  String? vaultCardSaved;
  String? settingBillingInformation;
  String? settingShippingInformation;
  String? settingFeeCharged;
  String? allowRetry;
  String? settingPromotion;
  String? settingDiscountCoupon;

  MerchantSetting(
      {this.vaultCardSaved,
      this.settingBillingInformation,
      this.settingShippingInformation,
      this.settingFeeCharged,
      this.allowRetry,
      this.settingPromotion,
      this.settingDiscountCoupon});

  MerchantSetting.fromJson(Map<String, dynamic> json) {
    vaultCardSaved = json['vaultCardSaved'];
    settingBillingInformation = json['settingBillingInformation'];
    settingShippingInformation = json['settingShippingInformation'];
    settingFeeCharged = json['settingFeeCharged'];
    allowRetry = json['allowRetry'];
    settingPromotion = json['settingPromotion'];
    settingDiscountCoupon = json['settingDiscountCoupon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vaultCardSaved'] = this.vaultCardSaved;
    data['settingBillingInformation'] = this.settingBillingInformation;
    data['settingShippingInformation'] = this.settingShippingInformation;
    data['settingFeeCharged'] = this.settingFeeCharged;
    data['allowRetry'] = this.allowRetry;
    data['settingPromotion'] = this.settingPromotion;
    data['settingDiscountCoupon'] = this.settingDiscountCoupon;
    return data;
  }
}
