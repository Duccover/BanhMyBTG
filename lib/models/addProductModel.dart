class AddProductModel{
  String? productName, productImage, productId,productDesc;
  int? productPrice, productQuantity;
  List<dynamic>? productUnit;

  AddProductModel(
      {this.productId,
        this.productName,
        this.productImage,
        this.productPrice,
        this.productQuantity,
        this.productUnit,
        this.productDesc});
  Map<String,dynamic> toJson() =>{
     'productId':productId,
      'productName':productName,
     'productImage':productImage,
     'productPrice':productPrice,
  };
}