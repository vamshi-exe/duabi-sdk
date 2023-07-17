class PromoList {
  String? promoId;
  String? promoType;
  int? netAmt;

  PromoList({this.promoId, this.promoType, this.netAmt});

  PromoList.fromJson(Map<String, dynamic> json) {
    promoId = json['promoId'];
    promoType = json['promoType'];
    netAmt = json['netAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promoId'] = this.promoId;
    data['promoType'] = this.promoType;
    data['netAmt'] = this.netAmt;
    return data;
  }
}
