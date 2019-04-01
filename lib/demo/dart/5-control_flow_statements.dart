main() {
  var collection = [0, 1, 2];
  //forEach
  collection.forEach((item) => print('forEach: $item'));
  //for-in遍历元素
  for (var item in collection) {
    print('for-in: $item');
  }
}
