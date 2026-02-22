import 'package:matger_core_logic/utls/bloc/base_bloc.dart';
import 'package:matger_core_logic/utls/bloc/remote_base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageBloc {
  static final StorageBloc _singleton = StorageBloc._internal();
  factory StorageBloc() => _singleton;
  StorageBloc._internal();

  final DataSourceBloc<Map<String, dynamic>> storageDataBloc =
      DataSourceBloc<Map<String, dynamic>>();

  Future<void> loadStorageData() async {
    storageDataBloc.loadingState();
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      final Map<String, dynamic> data = {};
      for (String key in keys) {
        data[key] = prefs.get(key);
      }
      if (data.isEmpty) {
        data["INFO"] = "Storage is currently empty. Login to save data.";
      }
      storageDataBloc.successState(data);
    } catch (e) {
      storageDataBloc.failedState(
        ErrorStateModel(message: e.toString()),
        () => loadStorageData(),
      );
    }
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await loadStorageData();
  }
}
