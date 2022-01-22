import 'dart:math';

import 'package:advanced_widgets/ui/widgets/weather_widget.dart';
import 'package:flutter/material.dart';

import 'package:advanced_widgets/ui/widgets/app_color_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedThemeIndex = 0;
  late double weatherState = 0.8;
  late String weatherInfo;

  @override
  void initState() {
    super.initState();
    weatherState = Random().nextDouble();
    weatherInfo = getWeatherInfo();
  }

  String getWeatherInfo() {
    if (weatherState < 0.2) {
      return 'Солнечно,\n20 градусов';
    }
    if (weatherState > 0.2 && weatherState < 0.5) {
      return 'Облачно,\n12 градусов';
    }
    return 'Дождь,\n5 градусов';
  }

  @override
  Widget build(BuildContext context) {
    return AppColorTheme(
      theme: appThemes[selectedThemeIndex],
      child: Builder(builder: (innerContext) {
        AppTheme? appTheme = AppColorTheme.of(innerContext);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Погода',
              style: TextStyle(
                color: appTheme?.textColor,
              ),
            ),
            backgroundColor: appTheme?.headerColor,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: WeatherWidget(
                appTheme: appTheme,
                weatherState: weatherState,
                weatherInfo: weatherInfo,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: appTheme?.primaryColor,
            child: const Icon(Icons.color_lens),
            tooltip: 'Color',
            onPressed: _changeColor,
          ),
        );
      }),
    );
  }

  void _changeColor() {
    setState(() {
      if (selectedThemeIndex >= appThemes.length - 1) selectedThemeIndex = 0;
      selectedThemeIndex++;
    });
  }
}
