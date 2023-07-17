class Promotion {
  String? promoName;
  String? promoType;
  String? promoPayOptType;
  String? promoCardName;
  String? promotionDesc;
  String? promoTerms;
  String? promoId;
  String? promoTandC;
  String? promoPayOptTypeDesc;
  double? netAmt;
  double? discountValue;

  Promotion(
      {this.promoName,
      this.promoType,
      this.promoPayOptType,
      this.promoCardName,
      this.promotionDesc,
      this.promoTerms,
      this.promoId,
      this.promoTandC,
      this.promoPayOptTypeDesc,
      this.netAmt,
      this.discountValue});

  Promotion.fromJson(Map<String, dynamic> json) {
    try {
      promoName = json['promoName'];
      promoType = json['promoType'];
      promoPayOptType = json['promoPayOptType'];
      promoCardName = json['promoCardName'];
      promotionDesc = json['promotionDesc'];
      promoTerms = json['promoTerms'];
      promoId = json['promoId'];
      promoTandC = json['promoTandC'];
      promoPayOptTypeDesc = json['promoPayOptTypeDesc'];
      netAmt = json['netAmt'];
      discountValue = json['discountValue'];
    } catch (e) {
      print(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promoName'] = this.promoName;
    data['promoType'] = this.promoType;
    data['promoPayOptType'] = this.promoPayOptType;
    data['promoCardName'] = this.promoCardName;
    data['promotionDesc'] = this.promotionDesc;
    data['promoTerms'] = this.promoTerms;
    data['promoId'] = this.promoId;
    data['promoTandC'] = this.promoTandC;
    data['promoPayOptTypeDesc'] = this.promoPayOptTypeDesc;
    data['netAmt'] = this.netAmt;
    data['discountValue'] = this.discountValue;
    return data;
  }
}
