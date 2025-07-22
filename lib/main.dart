import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/features/layout/main_layout_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MainLayoutView());
}
