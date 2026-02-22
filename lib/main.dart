import 'package:flutter/material.dart';
import 'package:matger_core_logic/config/paoject_config.dart';
import 'utls/test_widgets/test_widget.dart';

import 'package:matger_core_logic/utls/storage/storage_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  projectConfig().initConfigration();
  await StorageHelper.init();
  runApp(const LogicTesterApp());
}
