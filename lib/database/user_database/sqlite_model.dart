class SQLiteModel {
  int? id;
  String? productId;
  String? productName;
  String? amount;
  String? category;
  String? price;
  String? total;
  String? branchId;
  String? branchName;

  SQLiteModel(
      {this.id,
      this.productId,
      this.productName,
      this.amount,
      this.category,
      this.price,
      this.total,
      this.branchId,
      this.branchName});

  SQLiteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    productName = json['productName'];
    amount = json['amount'];
    category = json['category'];
    price = json['price'];
    total = json['total'];
    branchId = json['branchId'];
    branchName = json['branchName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['amount'] = this.amount;
    data['category'] = this.category;
    data['price'] = this.price;
    data['total'] = this.total;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    return data;
  }
}
