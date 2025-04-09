import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sleepwell/constants/app_translations.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic hist = Get.arguments;
    int age = int.tryParse(hist['age'].toString()) ?? 0;
    double sleepDuration =
        double.tryParse(hist['sleep_duration'].toString()) ?? 0;

    double normalSleep = age > 18 ? 7.0 : 9.0;
    double sleepPercentage = (sleepDuration / normalSleep) * 100;
    sleepPercentage = sleepPercentage > 100 ? 100 : sleepPercentage;
    double insomniaPercentage =
        double.tryParse(hist['insomnia_percentage'].toString()) ?? 0;

    String insomniaStatus = insomniaPercentage < 50 ? "Normal" : "High";
    Color insomniaColor =
        insomniaPercentage < 50 ? Colors.green : Colors.redAccent;
    Get.find<AppTranslations>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: Text(
          AppTranslations.translate(
            "details",args:[]
          ),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: AppColors.arrowColor),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Advice : ${hist['advice']}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 20),
              Text(
                "Insomnia Percentage: $insomniaPercentage% ($insomniaStatus)",
                style: TextStyle(
                  color: insomniaColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Books : ${hist['recommended_books']}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Music : ${hist['soothing_music']}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Healthy Food : ${hist['beneficial_foods']}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Medicine : ${hist['recommended_medication']}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                "Sleep Percentage: ${sleepPercentage.toStringAsFixed(1)}%",
                style: TextStyle(
                    color: sleepPercentage >= 100
                        ? Colors.green
                        : Colors.redAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text("Sleep Duration Chart",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    barGroups: [
                      BarChartGroupData(
                        x: age > 18 ? 1 : 0,
                        barRods: [
                          BarChartRodData(
                              toY: normalSleep,
                              color: Colors.green,
                              width: 20,
                              borderRadius: BorderRadius.circular(4)),
                        ],
                      ),
                      BarChartGroupData(
                        x: age > 18 ? 1 : 0,
                        barRods: [
                          BarChartRodData(
                              toY: sleepDuration,
                              color: sleepDuration >= normalSleep
                                  ? Colors.blue
                                  : Colors.redAccent,
                              width: 20,
                              borderRadius: BorderRadius.circular(4)),
                        ],
                      ),
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: true, reservedSize: 40),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(value == 1 ? "Adults" : "Children",
                                style: const TextStyle(color: Colors.white));
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: true),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Insomnia Percentage Pie Chart",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: insomniaPercentage,
                        title: "$insomniaPercentage%",
                        color: Colors.redAccent,
                        radius: 50,
                        titleStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      PieChartSectionData(
                        value: 100 - insomniaPercentage,
                        title: "Healthy Sleep",
                        color: Colors.green,
                        radius: 50,
                        titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                    sectionsSpace: 3,
                    centerSpaceRadius: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
