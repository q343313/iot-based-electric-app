

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot/allpaths.dart';
import 'package:iot/data/appnotifications/appnotifications.dart';
import 'package:lucide_icons/lucide_icons.dart';


class Hubscreens extends StatefulWidget {
  const Hubscreens({super.key});

  @override
  State<Hubscreens> createState() => _HubscreensState();
}

class _HubscreensState extends State<Hubscreens> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool valuec = false;
  double voltage = 12.0;
  double current = 1.0;
  Timer? _timer;

  void startSimulation() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        voltage += Random().nextDouble() * 2; // increase slightly
        current += Random().nextDouble() * 0.5;
      });

      if (voltage >= 200) {
        shownotifications(
          title: "Iot Electric App",
          body: "⚠️ Please reduce your load. Voltage exceeds safe limit (200V).",
        );
      }

      AuthenticationImplementations().updateddata(
        voltage: double.parse(voltage.toStringAsFixed(2)),
        currnet: double.parse(current.toStringAsFixed(2)),
        power: double.parse((voltage * current).toStringAsFixed(2)),
      );
    });
  }



  void stopSimulation() {
    _timer?.cancel();
    setState(() {
      voltage = 0;
      current = 0;
    });
    AuthenticationImplementations().addiotdatainflutter(); // Reset Firebase
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bad Room"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30,),
        
               CustomNewCardWidget(valuec: valuec, name: "Light", icondata: FaIcon(FontAwesomeIcons.lightbulb)),
                CustomNewCardWidget(valuec: valuec, name: "Fan", icondata: FaIcon(FontAwesomeIcons.fan,),valotage: "45.0",current: "5.0",),
                CustomNewCardWidget(valuec: valuec, name: "AC", icondata: Icon(Icons.splitscreen_rounded),valotage: "60.0",current: "6.0",),
        
        
               InkWell(
                 onTap: (){
                   if(valuec == false){
                     valuec  = true;
                   }else {
                     valuec = false;
                   }
                   setState(() {

                   });
        
                   if (valuec) {
                     startSimulation();
                   } else {
                     stopSimulation();
                   }
                   setState(() {

                   });
                 },
                 child: Card(
                   color: Theme.of(context).brightness == Brightness.light
                   ? Colors.white12
                   : AppColors.textfielddarkmode,
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                            // FloatingActionButton(onPressed: (){},child: FaIcon(FontAwesomeIcons.lightbulb),),
                         SizedBox(width: 8,),
                         Column(
                           children: [
                           Text("Load",style: TextStyle(fontSize: 19,fontFamily: "semibold",color: Colors.white),),
                             Text(valuec == true ? "on" : "off",style: TextStyle(color: valuec ==true?Colors.blue:Colors.red),)
                           ],
                         ),
                         SizedBox(width: 110,),
                         Switch(value: valuec, onChanged: (value){
                           if(valuec == false){
                             valuec  = true;
                           }else {
                             valuec = false;
                           }
                           setState(() {

                           });

                           if (valuec) {
                             startSimulation();
                           } else {
                             stopSimulation();
                           }
                           setState(() {

                           });
                         })
                       ],
                     ),
                   ),
                 ),
               ),
                SizedBox(height: 30,),
                OptimizationCard(),
                SizedBox(height: 10,),
                IotOptimizationCard()
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class IotOptimizationCard extends StatelessWidget {
  const IotOptimizationCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Fake current values (this month)
    final double currentVoltage = 220;
    final double currentAmps = 4.5;
    final double currentPower = currentVoltage * currentAmps;

    // Fake last month values
    final double lastVoltage = 210;
    final double lastAmps = 5.0;
    final double lastPower = lastVoltage * lastAmps;

    // Calculate improvements
    final voltageImprovement = ((currentVoltage - lastVoltage) / lastVoltage) * 100;
    final currentImprovement = ((lastAmps - currentAmps) / lastAmps) * 100;
    final powerImprovement = ((lastPower - currentPower) / lastPower) * 100;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // margin: const EdgeInsets.all(16),
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [AppColors.scaffoldlightmode, Color(0xFF5C6BC0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "IoT Optimization Summary",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            _buildMetricRow("Voltage", "$currentVoltage V", voltageImprovement),
            const SizedBox(height: 8),
            _buildMetricRow("Current", "$currentAmps A", currentImprovement),
            const SizedBox(height: 8),
            _buildMetricRow("Power", "${currentPower.toStringAsFixed(2)} W", powerImprovement),
            const SizedBox(height: 20),
            const Text(
              "Compared to Last Month",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String title, String value, double improvement) {
    IconData icon = improvement >= 0 ? Icons.arrow_upward : Icons.arrow_downward;
    Color color = improvement >= 0 ? Colors.greenAccent : Colors.redAccent;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title: $value",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 4),
            Text(
              "${improvement.abs().toStringAsFixed(1)}%",
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}




class OptimizationCard extends StatelessWidget {
  const OptimizationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [AppColors.scaffoldlightmode, Color(0xFF5C6BC0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(
              LucideIcons.trendingUp,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Optimization Improved",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Electricity usage improved by 30% compared to last month.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "+30%",
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}



class CustomNewCardWidget extends StatelessWidget {
  const CustomNewCardWidget({super.key,required this.valuec,required this.name,required this.icondata,this.current = "4.0",this.valotage ="30."});

  final bool valuec;
  final String name;
  final Widget icondata;
  final String valotage;
  final String current;
  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white12
          : AppColors.textfielddarkmode,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(onPressed: (){},child: icondata,),
            SizedBox(width: 8,),
            Column(
              children: [
                Text(name,style: TextStyle(fontSize: 19,fontFamily: "semibold",color: Colors.white),),
                Text(valuec == true ? "on" : "off",style: TextStyle(color: valuec ==true?Colors.blue:Colors.red),)
              ],
            ),
            SizedBox(width: 60,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Current :3.0A",style: TextStyle(color: Colors.white),),
                Text("Voltage :30.0V",style: TextStyle(color: Colors.white),),

              ],
            )
          ],
        ),
      ),
    );
  }
}

