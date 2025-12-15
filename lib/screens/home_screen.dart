import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../models/forecast_model.dart';
import 'search_screen.dart';

import '../widgets/current_weather_card.dart';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/error_widget.dart';
import '../widgets/weather_detail_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchWeatherByLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Để hình nền tràn lên cả thanh trạng thái
      appBar: AppBar(
        title: const Text(
          "Dự Báo Thời Tiết",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent, // Trong suốt
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => context.read<WeatherProvider>().refreshWeather(),
          ),
        ],
      ),
      // Container chứa Gradient nền
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A90E2), Color(0xFF87CEEB)], // Màu xanh da trời
          ),
        ),
        child: Consumer<WeatherProvider>(
          builder: (context, provider, child) {
            if (provider.state == WeatherState.loading) {
              return const LoadingShimmer();
            }

            if (provider.state == WeatherState.error) {
              return ErrorWidgetCustom(
                message: provider.errorMessage,
                onRetry: () => provider.fetchWeatherByLocation(),
              );
            }

            if (provider.currentWeather == null) {
              return const Center(
                child: Text(
                  'Chưa có dữ liệu',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final weather = provider.currentWeather!;
            final fullForecast = provider.forecast;

            // Logic lọc dữ liệu 1 ngày 1 lần
            final List<ForecastModel> dailyForecast = [];
            final Set<int> addedDays = {};
            for (var item in fullForecast) {
              final day = item.dateTime.day;
              if (!addedDays.contains(day)) {
                addedDays.add(day);
                dailyForecast.add(item);
              }
            }

            return RefreshIndicator(
              color: Colors.white,
              backgroundColor: Colors.blueAccent,
              onRefresh: () => provider.refreshWeather(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  16,
                  100,
                  16,
                  16,
                ), // Padding top lớn để tránh AppBar
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card thời tiết chính (Đã sửa lại cho trong suốt)
                    CurrentWeatherCard(weather: weather),

                    const SizedBox(height: 20),

                    // Chi tiết thêm (Gió, Độ ẩm...) - Hiệu ứng kính mờ
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2), // Nền mờ
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildDetailItem(
                            Icons.water_drop,
                            "Độ ẩm",
                            "${weather.humidity}%",
                          ),
                          _buildDetailItem(
                            Icons.air,
                            "Gió",
                            "${weather.windSpeed} m/s",
                          ),
                          _buildDetailItem(
                            Icons.visibility,
                            "Tầm nhìn",
                            "${(weather.visibility ?? 0) / 1000} km",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),
                    const Text(
                      "Dự báo theo giờ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    HourlyForecastList(forecasts: fullForecast),

                    const SizedBox(height: 25),
                    const Text(
                      "Dự báo 5 ngày",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dailyForecast.length,
                      itemBuilder: (context, index) {
                        return DailyForecastCard(
                          forecast: dailyForecast[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchScreen()),
          );
        },
        child: const Icon(Icons.search, color: Colors.blue),
      ),
    );
  }

  // Widget con để vẽ các icon chi tiết màu trắng
  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
