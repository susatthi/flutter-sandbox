void main() {
  Alice.instance.say(); // 'My name is Alice.'
  Bob.instance.say(); // 'My name is Bob.'

  // Singleton なので次のようには呼べない
  // Alice().say();
  // Bob().say();

  // abstract class はインスタンス化できない
  // Person('Carol').say();
}

abstract class Person {
  Person(this.name);
  final String name;

  void say() {
    print('My name is $name.');
  }
}

class Alice extends Person {
  Alice._() : super('Alice');
  static final instance = Alice._();
}

class Bob extends Person {
  Bob._() : super('Bob');
  static final instance = Bob._();
}
