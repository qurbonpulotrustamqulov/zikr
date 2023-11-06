class Zikr {
  final int id;
  final String name;
  bool succes;

  Zikr({required this.id, required this.name, this.succes = true});

  factory Zikr.fromJson(Map<String, Object?> json) => Zikr(
      id: json['id'] as int,
      name: json['name'] as String,
      succes: json['succes'] as bool);

  Map<String, Object?> toJson() => {"id": id, "name": name, "succes": succes};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Zikr &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          succes == other.succes;

  @override
  int get hashCode => Object.hash(id, name);

  @override
  String toString() {
    return "Zikr: {$name}; ";
  }
}

class ZikrItem {
  final int id;
  int quantity;
  final Zikr zikr;

  ZikrItem({
    required this.id,
    this.quantity = 1,
    required this.zikr,
  });

  factory ZikrItem.fromJson(Map<String, Object?> json) => ZikrItem(
      id: json["id"] as int,
      quantity: json["quantity"] as int,
      zikr: Zikr.fromJson(json["zikr"] as Map<String, Object?>));


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZikrItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          quantity == other.quantity &&
          zikr == other.zikr;

  @override
  int get hashCode => Object.hash(id, zikr);

  @override
  String toString() {
    return "ZikrItem{$zikr - $quantity}; ";
  }

  ZikrItem copyWith({
    int? id,
    int? quantity,
    Zikr? zikr,
  }) {
    return ZikrItem(
        id: id ?? this.id,
        zikr: zikr ?? this.zikr,
        quantity: quantity ?? this.quantity);
  }
}

class Cart {
  final int id;
  List<ZikrItem> items;
  int total;

  Cart({required this.id, required this.items})
      : total = items.fold<int>(
            0, (previousValue, element) => previousValue + element.quantity);

  Cart copyWith({int? id, List<ZikrItem>? items}) {
    return Cart(id: id ?? this.id, items: items ?? this.items);
  }

  @override
  String toString() {
    return "Cart{total: $total, items: $items}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cart &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          items == other.items &&
          total == other.total;

  @override
  int get hashCode => Object.hash(id, items, total);
}
