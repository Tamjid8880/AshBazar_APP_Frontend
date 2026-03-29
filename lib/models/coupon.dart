class Coupon {
  String? sId;
  String? couponCode;
  String? discountType;
  double? discountAmount;
  double? minimumPurchaseAmount;
  String? endDate;
  String? status;
  String? applicableCategory;
  Null applicableSubCategory;
  Null applicableProduct;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Coupon(
      {this.sId,
      this.couponCode,
      this.discountType,
      this.discountAmount,
      this.minimumPurchaseAmount,
      this.endDate,
      this.status,
      this.applicableCategory,
      this.applicableSubCategory,
      this.applicableProduct,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Coupon.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    couponCode = json['couponCode'];
    discountType = json['discountType'];
    discountAmount = double.tryParse(json['discountAmount']?.toString() ?? '');
    minimumPurchaseAmount = double.tryParse(json['minimumPurchaseAmount']?.toString() ?? '');
    endDate = json['endDate'];
    status = json['status'];
    applicableCategory = json['applicableCategory'];
    applicableSubCategory = json['applicableSubCategory'];
    applicableProduct = json['applicableProduct'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = int.tryParse(json['__v']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['couponCode'] = couponCode;
    data['discountType'] = discountType;
    data['discountAmount'] = discountAmount;
    data['minimumPurchaseAmount'] = minimumPurchaseAmount;
    data['endDate'] = endDate;
    data['status'] = status;
    data['applicableCategory'] = applicableCategory;
    data['applicableSubCategory'] = applicableSubCategory;
    data['applicableProduct'] = applicableProduct;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
