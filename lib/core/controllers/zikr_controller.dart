import 'package:flutter/material.dart';

import '../../main.dart';
import '../models/zikr_model.dart';

List<Zikr> allZikr = [];
int type = 33;
List<Zikr> products =
    allZikr.where((element) => element.succes == true).cast<Zikr>().toList();

class ZikrController with ChangeNotifier {
  Cart _cart = Cart(id: 1, items: []);

  bool _isChanged = true;
  int _hasSound = 1;
  bool _adZikr = true;
  bool _isRemove = true;
  bool _changeType = true;
  bool _showAll  = false;

  void showAllZikr(){
    _showAll = !_showAll;
    notifyListeners();
  }
  void addToCard({required Zikr product, required int quantity}) {
    final isExist = _cart.items.any((element) => element.id == product.id);
    if (isExist) {
      final item =
          _cart.items.firstWhere((element) => element.id == product.id);
      if (quantity == 1) {
        item.quantity++;
      }
    } else if (quantity == 1) {
      final cartItem = ZikrItem(id: product.id, zikr: product);
      _cart.items.add(cartItem);
    }
    _cart = _cart.copyWith(items: _cart.items);
    notifyListeners();
  }
  void addToZikr({required String zikr})async{
    await zikrRepository.storeTodo(Zikr(id: allZikr.length, name: zikr,succes: true));
    allZikr.add(Zikr(id: allZikr.length, name: zikr,succes: true));
    products = allZikr
        .where((element) => element.succes == true)
        .cast<Zikr>()
        .toList();
    _adZikr = !_adZikr;
    notifyListeners();
  }
  void addFirst({required String zikr})async{
    await zikrRepository.storeFirst(Zikr(id: 99999, name: zikr,succes: true));
    _adZikr = !_adZikr;
    notifyListeners();
  }
  void removeZikr({required int id})async{
    allZikr.removeWhere((element) => element.id == id);
    products.removeWhere((element) => element.id == id);
    final result = await zikrRepository.deleteTodo(id);
    if(result) {
      allZikr = zikrRepository.readTodo();
    }
    _isRemove = !_isRemove;
    notifyListeners();
  }
  void changeType({required int typeCount}){
    _changeType = !_changeType;
    type = typeCount;
    notifyListeners();
  }
  void selected({required Zikr selection}) {
    final index = allZikr.indexWhere((zikr) => zikr.id == selection.id);
    allZikr[index] = Zikr(
      id: selection.id,
      name: selection.name,
      succes: !selection.succes,
    );
    products = allZikr
        .where((element) => element.succes == true)
        .cast<Zikr>()
        .toList();

    notifyListeners();
  }

  void changed() {
    _isChanged = !_isChanged;
    notifyListeners();
  }

  void sound() {
    if (_hasSound == 1) {
      _hasSound = 2;
    } else if (_hasSound == 2) {
      _hasSound = 3;
    } else {
      _hasSound = 1;
    }
    notifyListeners();
  }


  Cart get cart => _cart;

  int get hasSound => _hasSound;

  bool get isChanged => _isChanged;


  bool get adZikr => _adZikr;
  bool get isRemove => _isRemove;
  bool get changeTypeCount=> _changeType;
  bool get showAll=> _showAll;
}
