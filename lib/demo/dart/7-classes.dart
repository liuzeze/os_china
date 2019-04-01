import 'dart:math';

main() {
  //普通构造函数
  var p = new Point(1, 1); //new 可省略 var point = Point(1, 2);
  print(p);
//  Point p1;
//  print(p1.runtimeType); //可以使用Object类的runtimeType属性,获取对象的类型

  //命名构造函数
  p = Point.fromJson({'x': 2, 'y': 2});
  print(p);

  //重定向构造函数
  p = Point.alongXAxis(0);
  print(p);

  //调用超类构造函数
  var child = Child.fromJson(1, 2);
  var child1 = Child(3, 4);

  //常量构造函数
  var p2 = const Point2(4, 4);
  print(p2);
  var p21 = Point2(4, 4); //创建的是非 常量对象
  var p22 = const Point2(4, 4);
  print(identical(p2, p21));
  print(identical(p2, p22));

  //工厂方法构造函数
  var singleton1 = Singleton('dongnao');
  var singleton2 = Singleton('damon');
  print(identical(singleton1, singleton2));

  //工厂模式两种方式
  //创建顶级函数
  var footMassage = massageFactory('foot');
  footMassage.doMassage();

  //创建工厂构造函数
//  var footMassage = new Massage('foot');
//  footMassage.doMassage();
//  var bodyMassage = new Massage('body');
//  bodyMassage.doMassage();
//  var specialMassage = new Massage('%#@##@##');
//  specialMassage.doMassage();

  //set get
  var rect = new Rectangle(1, 1, 10, 10);
  print(rect.left);
  rect.right = 12;
  print(rect.left);

  //implement 一个普通类
  var jishi = Jishi();
  jishi.work();

  //可调用类
  var cf = new ClassFunction();
  var out = cf("dongnao","flutter,","damon");
  print('$out'); // Hi there, gang!
  print(cf.runtimeType); // WannabeFunction
  print(out.runtimeType); // String
  print(cf is Function); // true
  
  //重载操作符
  final v1 = Vector(2, 3);
  final v2 = Vector(2, 2);
  final r1 = v1 + v2;
  final r2 = v1 - v2;
  print([r1.x, r1.y]);
  print([r2.x, r2.y]);
}

class Point {
  num x;
  num y;
  var distanceFromOrigin;

  //普通构造函数
//  Point(num x, num y){
//    this.x = x;
//    this.y = y;
//  }

  //简化构造
//  Point(this.x, this.y);

  //命名构造函数
  Point.fromJson(Map json) {
    x = json['x'];
    y = json['y'];
  }

  //重定向构造函数 使用冒号调用其他构造函数
  Point.alongXAxis(num x) : this(x, 0);

  //初始化列表
  Point(this.x, this.y) : distanceFromOrigin = sqrt(x * x + y * y);

  @override
  String toString() {
    // TODO: implement toString
    return 'Point(x = $x, y = $y)';
  }
}

class Parent {
  int x;
  int y;

  //超类命名构造函数不会传递，如果希望使用超类中定义的命名构造函数创建子类，则必须在子类中实现该构造函数
  Parent.fromJson(x, y)
      : x = x,
        y = y {
    print('超类命名构造函数');
  }
}

class Child extends Parent {
  int x;
  int y;

  //如果超类没有默认构造函数， 则你需要手动的调用超类的其他构造函数
  Child(x, y) : super.fromJson(x, y) {
    //调用超类构造函数的参数无法访问 this
    print('子类构造函数');
  }

  //在构造函数的初始化列表中使用 super()，需要把它放到最后
  Child.fromJson(x, y)
      : x = x,
        y = y,
        super.fromJson(x, y) {
    print('子类命名构造函数');
  }
}

class Point2 {
  //定义const构造函数要确保所有实例变量都是final
  final num x;
  final num y;
  static final Point2 origin = const Point2(0, 0);

  //const关键字放在构造函数名称之前,不能有函数体
  const Point2(this.x, this.y);

  @override
  String toString() {
    return 'Point2(x = $x, y = $y)';
  }
}

class Singleton {
  String name;
  static Singleton _cache; //工厂构造函数无法访问 this。所以这里要静态的

  //工厂构造函数，关键字factory
  //工厂构造函数是一种构造函数,与普通构造函数不同,工厂函数不会自动生成实例,而是通过代码来决定返回的实例对象.
//  factory Singleton([String name = 'singleton']) {
////    if(Singleton._cache == null){
////      Singleton._cache=new Singleton._newObject(name);
////    }
////    return Singleton._cache;
//
//    return Singleton._cache ??= Singleton._newObject(name);
//  }
  factory Singleton([String name = 'singleton']) =>
      Singleton._cache ??= Singleton._newObject(name);

//定义一个命名构造函数用来生产实例
  Singleton._newObject(this.name);
}

//工厂函数
class Massage {
  void doMassage(){
    print('按摩');
  }
}
class FootMassage extends Massage {
  @override
  doMassage() {
    print('脚底按摩');
  }
}

class BodyMassage extends Massage {
  @override
  void doMassage() {
    print('全身按摩');
  }
}

class SpecialMassage extends Massage {
  @override
  void doMassage() {
    print('特殊按摩');
  }
}
Massage massageFactory(String type){
  switch (type) {
    case 'foot':
      return new FootMassage();
    case 'body':
      return new BodyMassage();
    default:
      return new SpecialMassage();
  }
}

//工厂模式
//abstract class Massage {
//  factory Massage(String type) {
//    switch (type) {
//      case 'foot':
//        return new FootMassage();
//      case 'body':
//        return new BodyMassage();
//      default:
//        return new SpecialMassage();
//    }
//  }
//
//  void doMassage();
//}
//
//class FootMassage implements Massage {
//  @override
//  doMassage() {
//    print('脚底按摩');
//  }
//}
//
//class BodyMassage implements Massage {
//  @override
//  void doMassage() {
//    print('全身按摩');
//  }
//}
//
//class SpecialMassage implements Massage {
//  @override
//  void doMassage() {
//    print('特殊按摩');
//  }
//}

//setter getter
//每个实例变量都隐含的具有一个 getter， 如果变量不是 final 的则还有一个 setter
//可以通过实行 getter 和 setter 来创建新的属性， 使用 get 和 set 关键字定义 getter 和 setter
class Rectangle {
  num left;
  num top;
  num width;
  num height;

  Rectangle(this.left, this.top, this.width, this.height);

  // getter 和 setter 的好处是，可以开始使用实例变量，后面可以把实例变量用函数包裹起来，而调用你代码的地方不需要修改。
  //获取right值
  num get right => left + width;
  //设置right值，同时left也发生变化
  set right(num value) => left = value - width;
  //获取bottom值
  num get bottom => top + height;
  //设置bottom值，同时top也发生变化
  set bottom(num value) => top = value - height;
}

//implement 一个普通类
class People {
  void work() {
    print('people work');
  }
}

class Jishi implements People {
  @override
  void work() {
    print('jishi work');
  }
}

//可调用类
class ClassFunction {
  call(String a, String b, String c) => '$a $b $c!';
}

//重载操作符
class Vector {
  final int x;
  final int y;

  const Vector(this.x, this.y);

  //重载+
  Vector operator +(Vector v) {
    return new Vector(x + v.x, y + v.y);
  }

  //重载-
  Vector operator -(Vector v) {
    return new Vector(x - v.x, y - v.y);
  }
}