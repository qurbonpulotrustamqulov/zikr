import 'dart:convert';

import 'package:untitled/core/models/zikr_model.dart';
import 'package:untitled/services/store_service/local_data_source.dart';


abstract class ZikrRepository {
  Future<bool> storeTodo(Zikr todo);
  Future<bool> storeFirst(Zikr todo);
  List<Zikr> readTodo();
  List<Zikr> readFirst();
  Future<bool> deleteTodo(int id);

}

class ZikrRepositoryImpl implements ZikrRepository {
  final LocalDataSource dataSource;
  const ZikrRepositoryImpl({required this.dataSource});

  @override
  Future<bool> deleteTodo(int id) {
    /// Object => json => String
    final list = readTodo();
    list.removeWhere((element) => element.id == id);
    final json = list.map((todo) => todo.toJson()).toList();
    final data = jsonEncode(json);
    return dataSource.store(StorageKey.todos, data);
  }

  @override
  List<Zikr> readTodo() {
    /// String => json => Object
    String data = dataSource.read(StorageKey.todos) ?? "[]";
    final json = jsonDecode(data) as List;
    return json.map((item) => Zikr.fromJson(item as Map<String, dynamic>)).toList();
  }

  @override
  Future<bool> storeTodo(Zikr todo) {
    /// Object => json => String
    final list = readTodo();
    list.add(todo);
    final json = list.map((todo) => todo.toJson()).toList();
    final data = jsonEncode(json);
    return dataSource.store(StorageKey.todos, data);
  }

  @override
  Future<bool> storeFirst(Zikr todo) {
    /// Object => json => String
    final list = readFirst();
    list.add(todo);
    final json = list.map((todo) => todo.toJson()).toList();
    final data = jsonEncode(json);
    return dataSource.store(StorageKey.isFirst, data);
  }

  @override
  List<Zikr> readFirst() {
    /// String => json => Object
    String data = dataSource.read(StorageKey.isFirst) ?? "[]";
    final json = jsonDecode(data) as List;
    return json.map((item) => Zikr.fromJson(item as Map<String, dynamic>)).toList();
  }


}