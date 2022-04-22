/* Future<void> getProductLinkList(int category_id) async {
  Response response = await productFromCategoryRepo.getProductList(category_id);
  //print(response);

  print("Product link list status code " + response.statusCode.toString());

  if (response.statusCode == 200) {
    _productLinkList = [];

    //print("response : " + response.body.toString());

    List response_body = response.body;

    print("the length is " + response_body.length.toString());
    //print("the shop number is " + response_body.length.toString());

    for (var i = 0; i < response_body.length; i++) {
      _productLinkList.add(ProductListFromCategoryModel.fromJson(response_body[i]));
    }
    _isLoaded = true;

    //inspect(_productLinkList);

    update();
  } else {}
}
 */