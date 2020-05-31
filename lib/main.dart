import 'package:coronavirus_rest_api_flutter_course/app/services/data_cache_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/repositories/data_repository.dart';
import 'app/services/api.dart';
import 'app/services/api_service.dart';
import 'app/ui/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'zh_Hant_HK';
  await initializeDateFormatting();
  // Call async method here
  final sharedPreferences = await SharedPreferences.getInstance();
  // And asign it to a parameter in constructor
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  // Pass the async result to a variable, avoid calling
  // the FutureBuilder
  const MyApp({Key key, @required this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(API.sandbox()),
        dataCacheService: DataCacheService(
          sharedPreferences: sharedPreferences,
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coronavirus Tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
