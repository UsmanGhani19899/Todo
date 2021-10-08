import 'package:get_it/get_it.dart';
import 'package:todo/core/ViewModel/viewmodel.dart';
import 'package:todo/core/service/api.dart';

final getit = GetIt.instance;

void showLocator() {
  getit.registerSingleton<Api>(Api("Path"));
  getit.registerSingleton<CrudModel>(CrudModel());
}
