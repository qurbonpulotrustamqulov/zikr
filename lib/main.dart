
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/models/todo_repository.dart';
import 'package:untitled/services/constants/starings.dart';
import 'package:untitled/services/store_service/local_data_source.dart';

import 'app.dart';
import 'core/models/zikr_model.dart';
late final ZikrRepository zikrRepository;



void main() async{
  await ScreenUtil.ensureScreenSize();

  WidgetsFlutterBinding.ensureInitialized();

  final db = await LocalDataSourceImpl.init;

  /// data
  LocalDataSource dataSource = LocalDataSourceImpl(db: db);
  zikrRepository = ZikrRepositoryImpl(dataSource: dataSource);
  if(zikrRepository.readFirst().isEmpty){
    await zikrRepository.storeTodo(Zikr(id: 0, name: CustomStrings.tasbeh,succes: true));
    await zikrRepository.storeTodo(Zikr(id: 1, name: CustomStrings.hamd,succes: true));
    await zikrRepository.storeTodo(Zikr(id: 2, name: CustomStrings.takbir,succes: true));
    await zikrRepository.storeFirst(Zikr(id: 1111, name: "name"));
  }
  runApp(const Tasbeh());
}
