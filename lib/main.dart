import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart'; // <--- THÊM IMPORT NÀY

import 'screens/home_screen.dart';
import 'providers/weather_provider.dart';
import 'services/weather_service.dart';
import 'services/location_service.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Khởi tạo dữ liệu định dạng cho tiếng Việt
  await initializeDateFormatting('vi', null); // <--- THÊM DÒNG NÀY

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => LocationService()),
        Provider(create: (_) => StorageService()),
        ProxyProvider0<WeatherService>(
          update: (_, __) =>
              WeatherService(apiKey: dotenv.env['OPENWEATHER_API_KEY'] ?? ''),
        ),
        ChangeNotifierProxyProvider3<
          WeatherService,
          LocationService,
          StorageService,
          WeatherProvider
        >(
          create: (context) => WeatherProvider(
            WeatherService(apiKey: ''),
            LocationService(),
            StorageService(),
          ),
          update:
              (
                context,
                weatherService,
                locationService,
                storageService,
                previous,
              ) => WeatherProvider(
                weatherService,
                locationService,
                storageService,
              ),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
