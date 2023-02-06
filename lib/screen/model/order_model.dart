// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    OrderModel({
        required this.orders,
    });

    List<Order> orders;

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    };
}

class Order {
    Order({
        required this.id,
        required this.billNo,
        required this.createdAt,
        required this.saleStatus,
        required this.total,
        required this.sippingStatus,
        required this.sippingName,
        required this.sippingPr,
        required this.sippingDr,
        required this.sippingVill,
        required this.user,
        required this.userPhone,
        required this.userImage,
        required this.paymentInfo,
        required this.orderDetails,
    });

    int id;
    int billNo;
    DateTime createdAt;
    int saleStatus;
    int? total;
    int sippingStatus;
    String sippingName;
    String sippingPr;
    String sippingDr;
    String sippingVill;
    String user;
    int userPhone;
    String userImage;
    String paymentInfo;
    List<OrderDetail> orderDetails;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        billNo: json["bill_no"],
        createdAt: DateTime.parse(json["created_at"]),
        saleStatus: json["sale_status"],
        total: json["total"],
        sippingStatus: json["sipping_status"],
        sippingName: json["sipping_name"],
        sippingPr: json["sipping_pr"],
        sippingDr: json["sipping_dr"],
        sippingVill: json["sipping_vill"],
        user: json["user"],
        userPhone: json["user_phone"],
        userImage: json["user_image"],
        paymentInfo: json["payment_info"],
        orderDetails: List<OrderDetail>.from(json["order_details"].map((x) => OrderDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bill_no": billNo,
        "created_at": createdAt.toIso8601String(),
        "sale_status": saleStatus,
        "total": total,
        "sipping_status": sippingStatus,
        "sipping_name": sippingName,
        "sipping_pr": sippingPr,
        "sipping_dr": sippingDr,
        "sipping_vill": sippingVill,
        "user": user,
        "user_phone": userPhone,
        "user_image": userImage,
        "payment_info": paymentInfo,
        "order_details": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
    };
}

class OrderDetail {
    OrderDetail({
         this.id,
         this.name,
         this.details,
         this.purchasePrice,
         this.sellingPrice,
         this.amount,
    });

    int? id;
    String? name;
    String? details;
    int? purchasePrice;
    int? sellingPrice;
    int? amount;

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        name: json["name"],
        details: json["details"],
        purchasePrice: json["purchase_price"],
        sellingPrice: json["selling_price"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "details": details,
        "purchase_price": purchasePrice,
        "selling_price": sellingPrice,
        "amount": amount,
    };
}
