class ProductModel {
  String? productName, productImage, productId,productDesc;
  int? productPrice, productQuantity;
  List<dynamic>? productUnit;

  ProductModel(
      {this.productId,
      this.productName,
      this.productImage,
      this.productPrice,
      this.productQuantity,
      this.productUnit,
      this.productDesc});
}
