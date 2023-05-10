class Coupon {
  final String? id;
  final String? discountType;
  final int? value;

  Coupon({
    required this.id,
    required this.discountType,
    required this.value,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'] as String?,
      discountType: json['discountType'] as String?,
      value: json['value'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'discountType': discountType,
      'value': value,
    };
  }
}
