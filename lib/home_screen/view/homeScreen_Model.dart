class HomeScreenModel {
  String? tabId;
  int? productId;
  int? column1;
  String? productName;

  HomeScreenModel({this.tabId, this.productId, this.column1, this.productName});

  HomeScreenModel.fromJson(Map<String, dynamic> json) {
    tabId = json['tab_id'];
    productId = json['product_id'];
    column1 = json['Column1'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tab_id'] = this.tabId;
    data['product_id'] = this.productId;
    data['Column1'] = this.column1;
    data['product_name'] = this.productName;
    return data;
  }
}
