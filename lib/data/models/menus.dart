class Menus {
  List<Menu> foods;
  List<Menu> drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    List<dynamic> foods = json['foods'];
    List<dynamic> drinks = json['drinks'];
    this.foods = List.from(foods.map((food) => Menu.fromJson(food)));
    this.drinks = List.from(drinks.map((drink) => Menu.fromJson(drink)));
  }
}

class Menu {
  String name;
  Menu({this.name});

  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
