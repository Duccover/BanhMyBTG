
class ReviewCartModel{
  String? cartID, cartImage,cartName;
  int? cartPrice, cartQuantity;
  var cartUnit;

  ReviewCartModel(
      {this.cartID,
      this.cartImage,
      this.cartName,
      required this.cartPrice,
      required this.cartQuantity,this.cartUnit});
  
}