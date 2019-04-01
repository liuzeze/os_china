import 'dart:core';

/// 三斜杠文档注释
///  返回类型void可以省略, 省略后返回值为null
void main() {
  /// ---------------------------------变量的声明--------------------------------
  //声明一个未初始化的变量，变量的类型可改变
  var data;
  data = 'dongnao';
  data = 123;

  dynamic data1;
  data1 = 'dongnao';
  data1 = 123;

  Object data2;
  data2 = 'dongnao';
  data2 = 123;

  print([data, data1, data2]);

  //var声明一个初始化的变量，变量的类型不能再改变
  var variable1 =
      'dongnao'; //变量是一个引用。名字为 name 的变量引用了 一个内容为 “dongnao” 的 String 对象。
//  variable1 = 123;//变量初始化后，name变量的类型被推断为String类型，其类型不能再改变

  //dynamic和Object声明的变量初始化后，变量的类型仍可改变
  dynamic variable2 = 'dongnao';
  variable2 = 123;
//  variable2.test();//调用不存在的test()方法，编译通过，运行报异常。编译阶段不检查类型
  Object variable3 = 'dongnao';
  variable3 = 123;
//  variable3.test();//调用不存在的test()方法，编译不通过。编译阶段检查类型

  //使用确定类型显示声明变量，变量的类型不能再改变
  String name3;
  name3 = 'dongnao';
//  name3 = 123;//变量的类型不能再改变

//var:如果没有初始值，可以变成任何类型
//dynamic:动态任意类型，编译阶段不检查类型
//Object:动态任意类型，编译阶段检查检查类型
//区别：
//唯一区别 var 如果有初始值，类型被锁定


  /// ---------------------------------默认值--------------------------------
  //没有初始化的变量默认值都是null。一切皆对象，对象的默认值是null
  bool isEmpty;
  assert(isEmpty == null);

  /// ---------------------------------final和const--------------------------------
  //1.  被final或者const修饰的变量，变量类型可以省略
  final fVariable1 = 'dongnao';
//  final String fVariable1 = 'dongnao';
  const cVariable1 = 'dongnao';
//  const String cVariable1 = 'dongnao';

  //2.  被 final 或 const 修饰的变量无法再去修改其值。
//   fVariable1 = 'damon';
//   cVariable1 = 'damon';

  //3.  final或const不能和var同时使用。
//  final var fVariable1 = 'dongnao';
//  const var fVariable1 = 'dongnao';

  //4.  如果是类级别常量，使用static const
  DateTime; //可参照DateTime static const int monday = 1;

  //5.  const可以使用其他 const常量的值来初始化其值
  const width = 100;
  const height = 100;
  const square = width * height;

  //6.  const赋值 申明可省略
  const List clist = [1, 2, 3];
//  const List clist = const [1, 2, 3];//dart 2之前，const赋值必须用const声明

  //7.  可以更改非final,非const变量的值，即使它曾经具有const值
  var varList = const [1, 2, 3];
  final finalList = const [1, 2, 3];
  const constList = [1, 2, 3];
  varList = [1];
//  constList = [1];
//  finalList = [1];

  //8.  const导致的不可变性是可传递的
  final List ls = [1, 2, 3];
  ls[1] = 4;
  print(ls);
  const List ls1 = [1, 2, 3];
//  ls1[1] = 4;

  //9. 相同的const常量不会在内存中重复创建
  final finalList1 = [1, 2];
  final finalList2 = [1, 2];
  print(identical(finalList1, finalList2)); //identical用于检查两个引用是否指向同一个对象

  const constList1 = [1, 2];
  const constList2 = [1, 2];
  print(identical(constList1, constList2)); //identical用于检查两个引用是否指向同一个对象

  //10. const 需要是编译时常量
  final DateTime finalDateTime = DateTime.now();
  //  const DateTime constDateTime = DateTime.now();//DateTime.now() 是运行期计算出来的值
  const sum = 1 + 2; //使用内置数据类型的字面量通过基本运算得到的值
  const aConstNum = 0;
  const aConstBool = true;
  const aConstString = 'a constant string';
  const aConstNull = null;
  const validConstString =
      '$aConstNum, $aConstBool, $aConstString, $aConstNull';
  print(validConstString); //使用计算结果为null或数字，字符串或布尔值的编译时常量的插值表达式

}
