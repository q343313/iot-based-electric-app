


// ac_control_screen_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AcControlScreenBody extends StatefulWidget {
  const AcControlScreenBody({super.key});

  @override
  State<AcControlScreenBody> createState() => _AcControlScreenBodyState();
}

class _AcControlScreenBodyState extends State<AcControlScreenBody> {
  double _currentTemperature = 20.0;
  String _currentMode = 'Cool'; // Default mode

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          // Brand Selector
          _buildBrandSelector(context),
          SizedBox(height: 30.h),

          // Circular AC Slider
          // CircularAcSlider(
          //   currentTemperature: _currentTemperature,
          //   onTemperatureChanged: (temp) {
          //     setState(() {
          //       _currentTemperature = temp;
          //     });
          //   },
          //   mode: _currentMode,
          // ),
          SizedBox(height: 30.h),

          // Mode Controls
          _buildModeControls(context),
          SizedBox(height: 30.h),

          // Timer Section
          _buildTimerSection(context),
          SizedBox(height: 30.h),

          // Power Off Button
          _buildPowerOffButton(context),
          SizedBox(height: 20.h), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildBrandSelector(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Samsung Air Purifier',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Icon(Icons.keyboard_arrow_down_rounded, size: 24.w),
        ],
      ),
    );
  }

  Widget _buildModeControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildModeButton(context, Icons.ac_unit_outlined, 'Cool', _currentMode == 'Cool'),
        _buildModeButton(context, Icons.wb_sunny_outlined, 'Heat', _currentMode == 'Heat'),
        _buildModeButton(context, Icons.mode_fan_off_outlined, 'Wind', _currentMode == 'Wind'),
        _buildModeButton(context, Icons.auto_mode_outlined, 'Auto', _currentMode == 'Auto'),
      ],
    );
  }

  Widget _buildModeButton(BuildContext context, IconData icon, String mode, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentMode = mode;
        });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
              shape: BoxShape.circle,
              boxShadow: [
                if (!isSelected)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: Offset(0, 3.h),
                  ),
              ],
            ),
            child: Icon(
              icon,
              size: 26.w,
              color: isSelected ? Colors.white : Theme.of(context).iconTheme.color,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            mode,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.labelMedium?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerSection(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Timer', style: Theme.of(context).textTheme.titleSmall),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimerPill(context, '5:20:58', true),
                _buildTimerPill(context, '3h 2m', false),
                _buildTimerPill(context, '8h 6m', false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerPill(BuildContext context, String time, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          width: 1.w,
        ),
      ),
      child: Text(
        time,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium?.color,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildPowerOffButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.power_settings_new_rounded, color: Colors.red.shade600, size: 24.w),
              ),
              SizedBox(width: 12.w),
              Text(
                'Slide to power off',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 20.w, color: Colors.grey.shade500),
        ],
      ),
    );
  }
}