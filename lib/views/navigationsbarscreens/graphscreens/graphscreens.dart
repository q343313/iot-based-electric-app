//
// import 'dart:async';
// import 'dart:math';
//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:iot/allpaths.dart';
// import 'package:iot/data/appnotifications/appnotifications.dart';
//
//
// class Graphscreens extends StatefulWidget {
//   const Graphscreens({super.key});
//
//   @override
//   State<Graphscreens> createState() => _GraphscreensState();
// }
//
// class _GraphscreensState extends State<Graphscreens> with TickerProviderStateMixin{
//   late AnimationController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(vsync: this, duration: Duration(seconds: 3))..repeat();
//     _listenToFirebase(); // start listening to updates
//   }
//
//   void _listenToFirebase() {
//     refe.onValue.listen((event) {
//       if (event.snapshot.value != null) {
//         Map<dynamic, dynamic> map = event.snapshot.value as dynamic;
//         List<dynamic> list = map.values.toList();
//
//         if (list.isNotEmpty) {
//           final roomdata = list[0];
//
//           setState(() {
//             _time++;
//             double voltage = double.tryParse("${roomdata["voltage"]}") ?? 0;
//             double current = double.tryParse("${roomdata["current"]}") ?? 0;
//             double power = double.tryParse("${roomdata["power"]}") ?? 0;
//
//             voltageSpots.add(FlSpot(_time.toDouble(), voltage));
//             currentSpots.add(FlSpot(_time.toDouble(), current));
//             powerSpots.add(FlSpot(_time.toDouble(), power / 50));
//
//             // Optional: keep max 50 points
//             if (voltageSpots.length > 50) {
//               voltageSpots.removeAt(0);
//               currentSpots.removeAt(0);
//               powerSpots.removeAt(0);
//             }
//           });
//         }
//       }
//     });
//   }
//
//   final refe = FirebaseDatabase.instance.ref("iotdata");
//   double voltage = 0;
//
//   List<FlSpot> voltageSpots = [];
//   List<FlSpot> currentSpots = [];
//   List<FlSpot> powerSpots = [];
//
//   Timer? _timer;
//   int _time = 0;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawerscreens(),
//       appBar: AppBar(
//         title: Text("GraphScreens"),
//         centerTitle: true,
//         actions: [
//           IconButton(onPressed: (){
//            // AuthenticationImplementations().addiotdatainflutter();
//            AuthenticationImplementations().addiotdatainflutter();
//             BlocProvider.of<ThemeCubits>(context).toggletheme();
//           }, icon: Icon(Icons.dark_mode_outlined))
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 38.0),
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(height: 20,),
//                 StreamBuilder(stream:refe.onValue ,
//                     builder: (context,snapshot){
//                   if(snapshot.connectionState == ConnectionState.waiting){
//                     return Center(
//                       child: SpinKitFadingCircle(
//                         controller: controller,
//                         color: Colors.white,
//                       ),
//                     );
//                   }
//                   else if(!snapshot.hasData){
//                     return Text("No Data Found");
//                   }
//                   else{
//                     final data  = snapshot.data;
//                     Map<dynamic,dynamic>map = data!.snapshot.value as dynamic;
//                     List<dynamic>list = [];
//                     list.clear();
//                     list = map.values.toList();
//                     final roomdata = list[0];
//
//                     return Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             CustomCardWidget(iconData: Icons.stay_current_portrait_rounded,
//                                 data: "${roomdata["current"]}A", name:"Current"),
//                             CustomCardWidget(iconData: Icons.electric_bolt,
//                                 data: "${roomdata["voltage"]}V", name:"Voltage")
//                           ],
//                         ),
//
//                         SizedBox(height: 15.h,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             CustomCardWidget(iconData: Icons.power,
//                                 data: "${roomdata["power"]}V", name:"Power"),
//                             CustomCardWidget(iconData: Icons.vaccines,
//                                 data: "${roomdata["state"]}", name:"State")
//                           ],
//                         ),
//
//                       ],
//                     );
//                   }
//                     }),
//
//                 SizedBox(height: 40,),
//                 Card(
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Consumption Trends Over Time', // खपत रुझान
//                           style: Theme.of(context).textTheme.headlineSmall,
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           height: 300,
//                           child: LineChart(
//                             LineChartData(
//                               gridData: FlGridData(
//                                 show: true,
//                                 drawVerticalLine: true,
//                                 getDrawingHorizontalLine: (value) {
//                                   return FlLine(
//                                     color: Colors.grey[300]!, // Lighter grid lines
//                                     strokeWidth: 0.8,
//                                   );
//                                 },
//                                 getDrawingVerticalLine: (value) {
//                                   return FlLine(
//                                     color: Colors.grey[300]!,
//                                     strokeWidth: 0.8,
//                                   );
//                                 },
//                               ),
//                               titlesData: FlTitlesData(
//                                 show: true,
//                                 rightTitles: const AxisTitles(
//                                   sideTitles: SideTitles(showTitles: false),
//                                 ),
//                                 topTitles: const AxisTitles(
//                                   sideTitles: SideTitles(showTitles: false),
//                                 ),
//                                 bottomTitles: AxisTitles(
//                                   axisNameWidget: const Text('Time (seconds)', style: TextStyle(color: Colors.black, fontSize: 12)),
//                                   axisNameSize: 20,
//                                   sideTitles: SideTitles(
//                                     showTitles: true,
//                                     reservedSize: 30,
//                                     interval: 10,
//                                     getTitlesWidget: (value, meta) {
//                                       return SideTitleWidget(
//                                         meta: meta,
//                                         space: 8.0,
//                                         child: Text('${value.toInt()}s', style: const TextStyle(fontSize: 10, color: Colors.black54)),
//                                       );
//                                     },
//                                   ),
//                                 ),
//
//
//                                 leftTitles: AxisTitles(
//                                   axisNameWidget: const Text('Value', style: TextStyle(color: Colors.black, fontSize: 12)),
//                                   axisNameSize: 20,
//                                   sideTitles: SideTitles(
//                                     showTitles: true,
//                                     reservedSize: 40,
//                                     interval: 50, // Interval for Y-axis labels
//                                     getTitlesWidget: (value, meta) {
//                                       return Text(value.toInt().toString(), style: const TextStyle(fontSize: 10, color: Colors.black54));
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               borderData: FlBorderData(
//                                 show: true,
//                                 border: Border.all(color: Colors.grey[400]!, width: 1), // Lighter border
//                               ),
//
//                               minX: voltageSpots.isNotEmpty ? voltageSpots.first.x : 0,
//                               maxX: voltageSpots.isNotEmpty ? voltageSpots.last.x : (_time > 0 ? _time.toDouble() : 20),
//                               minY: 0,
//                               maxY: 250,
//                               lineBarsData: [
//
//                                 LineChartBarData(
//                                   spots: voltageSpots,
//                                   isCurved: true,
//                                   color: Colors.blueAccent,
//                                   barWidth: 4,
//                                   isStrokeCapRound: true,
//                                   dotData: FlDotData(show: true),
//                                   belowBarData: BarAreaData(
//                                     show: true,
//                                     gradient: LinearGradient(
//                                       colors: [Colors.cyanAccent.withOpacity(0.4), Colors.transparent],
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                     ),
//                                   ),
//                                 ),
//
//                                 // Current Line (विद्युत धारा रेखा)
//                                 LineChartBarData(
//                                   spots: powerSpots,
//                                   isCurved: true,
//                                   color: Colors.lightGreenAccent,
//                                   barWidth: 4,
//                                   isStrokeCapRound: true,
//                                   dotData: FlDotData(show: true),
//                                   belowBarData: BarAreaData(
//                                     show: true,
//                                     gradient: LinearGradient(
//                                       colors: [Colors.cyanAccent.withOpacity(0.4), Colors.transparent],
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                     ),
//                                   ),
//                                 ),
//
//                                 // Power Line (शक्ति रेखा)
//                                 LineChartBarData(
//                                   spots: currentSpots,
//                                   isCurved: true,
//                                   color: Colors.cyanAccent,
//                                   barWidth: 4,
//                                   isStrokeCapRound: true,
//                                   dotData: FlDotData(show: true),
//                                   belowBarData: BarAreaData(
//                                     show: true,
//                                     gradient: LinearGradient(
//                                       colors: [Colors.cyanAccent.withOpacity(0.4), Colors.transparent],
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                     ),
//                                   ),
//                                 ),
//
//                               ],
//                               lineTouchData: const LineTouchData(enabled: true),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         // Graph Legend (ग्राफ लेजेंड)
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _buildLegendItem(Colors.blueAccent, 'Voltage (V)'),
//                             _buildLegendItem(Colors.greenAccent, 'Current (A)'),
//                             _buildLegendItem(Colors.redAccent, 'Power (W / 50)'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLegendItem(Color color, String text) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 14,
//           height: 14,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(5),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Flexible( // Use Flexible to prevent overflow
//           child: Text(
//             text,
//             style: TextStyle(fontFamily: "regular",color: color,fontSize: 10),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iot/allpaths.dart';


class Graphscreens extends StatefulWidget {
  const Graphscreens({super.key});

  @override
  State<Graphscreens> createState() => _GraphscreensState();
}

class _GraphscreensState extends State<Graphscreens>with TickerProviderStateMixin{
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 3))..repeat();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawerscreens(),
      appBar: AppBar(
        title: const Text("USAGE"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              AuthenticationImplementations().addiotdatainflutter();
              BlocProvider.of<ThemeCubits>(context).toggletheme();
            },
            icon: const Icon(Icons.dark_mode_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              LiveCardData(controller: controller,),
              const SizedBox(height: 40),
              const LiveGraphWidget(), // ✅ efficient isolated graph
            ],
          ),
        ),
      ),
    );
  }
}



class LiveGraphWidget extends StatefulWidget {
  const LiveGraphWidget({super.key});

  @override
  State<LiveGraphWidget> createState() => _LiveGraphWidgetState();
}

class _LiveGraphWidgetState extends State<LiveGraphWidget> {
  final DatabaseReference refe = FirebaseDatabase.instance.ref("iotdata");
  List<FlSpot> voltageSpots = [];
  List<FlSpot> currentSpots = [];
  List<FlSpot> powerSpots = [];

  int _time = 0;

  @override
  void initState() {
    super.initState();
    refe.onValue.listen((event) {
      if (event.snapshot.value == null) return;

      final map = event.snapshot.value as Map<dynamic, dynamic>;
      final list = map.values.toList();
      if (list.isEmpty) return;

      final roomdata = list[0];
      final voltage = double.tryParse("${roomdata["voltage"]}") ?? 0;
      final current = double.tryParse("${roomdata["current"]}") ?? 0;
      final power = double.tryParse("${roomdata["power"]}") ?? 0;

      _time++;

      voltageSpots.add(FlSpot(_time.toDouble(), voltage));
      currentSpots.add(FlSpot(_time.toDouble(), current));
      powerSpots.add(FlSpot(_time.toDouble(), power / 50));

      if (voltageSpots.length > 50) {
        voltageSpots.removeAt(0);
        currentSpots.removeAt(0);
        powerSpots.removeAt(0);
      }

      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Live Energy Graph',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: LineChart(
                  LineChartData(
                    minX: voltageSpots.isEmpty ? 0 : voltageSpots.first.x,
                    maxX: voltageSpots.isEmpty ? 10 : voltageSpots.last.x,
                    minY: 0,
                    maxY: 250,
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        axisNameWidget: const Text("Time (s)", style: TextStyle(fontSize: 12)),
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) =>
                              Text('${value.toInt()}s', style: const TextStyle(fontSize: 10)),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        axisNameWidget: const Text("Value", style: TextStyle(fontSize: 12)),
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) =>
                              Text('${value.toInt()}', style: const TextStyle(fontSize: 10)),
                        ),
                      ),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: voltageSpots,
                        isCurved: true,
                        color: Colors.blueAccent,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.withOpacity(0.2),
                        ),
                      ),
                      LineChartBarData(
                        spots: currentSpots,
                        isCurved: true,
                        color: Colors.greenAccent,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.green.withOpacity(0.2),
                        ),
                      ),
                      LineChartBarData(
                        spots: powerSpots,
                        isCurved: true,
                        color: Colors.redAccent,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.red.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                children: [
                  _legend(Colors.blueAccent, "Voltage"),
                  _legend(Colors.greenAccent, "Current"),
                  _legend(Colors.redAccent, "Power / 50"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _legend(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }
}



class LiveCardData extends StatelessWidget {
  const LiveCardData({super.key,required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final refe = FirebaseDatabase.instance.ref("iotdata");
    return StreamBuilder(
      stream: refe.onValue,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return SpinKitFadingCircle(
            controller: controller,
            color: Colors.white,
          );
        }
        if (!snapshot.hasData) {
          return const Text("Waiting for data...");
        }

        final map = snapshot.data!.snapshot.value as Map;
        final list = map.values.toList();
        final roomdata = list[0];

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCardWidget(iconData: Icons.stay_current_portrait, data: "${roomdata["current"]}A", name: "Current"),
                CustomCardWidget(iconData: Icons.electric_bolt, data: "${roomdata["voltage"]}V", name: "Voltage"),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCardWidget(iconData: Icons.power, data: "${roomdata["power"]}W", name: "Power"),
                CustomCardWidget(iconData: Icons.vaccines, data: "${roomdata["state"]}", name: "State"),
              ],
            ),
          ],
        );
      },
    );
  }
}



class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({super.key,required this.iconData,required this.data,required this.name,this.color});

  final data;
  final String name;
  final IconData iconData;
  final Color?color;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 150,
      height: 120,
      child: Card(
        elevation: 10,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white12
            : AppColors.textfielddarkmode,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(iconData,color: Colors.white,),
                  SizedBox(width: 5.w,),
                  Text(name,style: TextStyle(fontSize: 20,fontFamily: "bold",color: Colors.white),)
                ],
              ),

              Text(data,style: TextStyle(
                  fontFamily: "bold",fontSize: 20,color: color??Colors.white
              ),
              )


            ],
          ),
        ),
      ),
    );
  }
}



