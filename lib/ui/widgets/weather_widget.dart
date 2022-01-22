import 'package:advanced_widgets/ui/widgets/tint.dart';
import 'package:flutter/material.dart';

import 'package:advanced_widgets/ui/widgets/app_color_theme.dart';
import 'package:advanced_widgets/ui/widgets/weather_painter.dart';

class WeatherWidget extends StatefulWidget {
  final double weatherState;

  final String weatherInfo;

  const WeatherWidget({
    Key? key,
    required this.weatherState,
    required this.weatherInfo,
    required this.appTheme,
  }) : super(key: key);

  final AppTheme? appTheme;

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget>
    with TickerProviderStateMixin {
  late final AnimationController _alignmentController, _scaleController;
  late final Animation<AlignmentGeometry> _alignmentAnimtaion;

  bool isSelected = false;
  bool isTextInfoShown = false;

  void _weatherTap() {
    setState(() {
      isSelected = !isSelected;
      isSelected
          ? _scaleController.forward()
          : _scaleController.animateBack(0.25);

      isSelected
          ? _alignmentController.forward()
          : _alignmentController.animateBack(0);
    });
  }

  @override
  void initState() {
    super.initState();

    _alignmentController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _alignmentAnimtaion = Tween<AlignmentGeometry>(
      begin: Alignment.topRight,
      end: Alignment.center,
    ).animate(
      CurvedAnimation(
        parent: _alignmentController,
        curve: Curves.decelerate,
      ),
    );

    _scaleController = AnimationController(
      value: 0.25,
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => isTextInfoShown = true);
      }
      if (status == AnimationStatus.reverse) {
        setState(() => isTextInfoShown = false);
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _alignmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          weatherImage(),
          if (isTextInfoShown)
            Tint(
              blur: 5,
              color: const Color(0xFF477C70),
              offset: const Offset(5, 5),
              text: widget.weatherInfo,
              child: Text(
                widget.weatherInfo,
                style: TextStyle(
                  color: widget.appTheme?.textColor,
                  fontSize: 32,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget weatherImage() {
    return AnimatedBuilder(
      animation: _scaleController,
      builder: (BuildContext context, Widget? child) {
        return AlignTransition(
          alignment: _alignmentAnimtaion,
          child: Transform.scale(
            transformHitTests: true,
            scale: _scaleController.value * 4,
            child: GestureDetector(
              onTap: _weatherTap,
              child: InkWell(
                child: CustomPaint(
                  painter: WeatherPainter(state: widget.weatherState),
                  size: Size(
                    _scaleController.value * 400,
                    _scaleController.value * 320,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
