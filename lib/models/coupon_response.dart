class CouponResponse {
  String? netAmt;
  String? isValidDiscount;
  String? isValidPromo;
  String? discountValue;
  String? result;
  String? errorDesc;

  CouponResponse(
      {this.netAmt,
      this.isValidDiscount,
      this.isValidPromo,
      this.discountValue,
      this.result,
      this.errorDesc});

  CouponResponse.fromJson(Map<String, dynamic> json) {
    netAmt = json['netAmt'];
    isValidDiscount = json['isValidDiscount'];
    isValidPromo = json["isValidPromo"];
    discountValue = json['discountValue'];
    result = json['result'];
    errorDesc = json['errorDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['netAmt'] = this.netAmt;
    data['isValidDiscount'] = this.isValidDiscount;
    data['discountValue'] = this.discountValue;
    data['isValidPromo'] = this.isValidPromo;
    data['result'] = this.result;
    data['errorDesc'] = this.errorDesc;
    return data;
  }
}
