class MyLib{
  String name;
  static MyLib _cache; //工厂构造函数无法访问 this。所以这里要静态的

  factory MyLib([String name = 'singleton']) =>
      MyLib._cache ??= MyLib._newObject(name);

//定义一个命名构造函数用来生产实例
  MyLib._newObject(this.name);
}

class Test{
  void test() => print('Test');
}