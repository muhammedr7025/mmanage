import 'package:flutter/material.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../components/categorySelectHeader.dart';
import '../constFiles/colors.dart';
import '../constFiles/strings.dart';
import '../controller/reportController.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);
  static ReportController? reportController;

  @override
  Widget build(BuildContext context) {
    reportController = Provider.of<ReportController>(context);

    return Column(
      children: [
        //category selector
        const CategorySelectHeader(),

        //pie chart, if not full report
        if (reportController!.reportMethod != fullReport)
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: PieChart(
              colorList: [
                Colors.red,
                Colors.green,
                Colors.yellow,
                Colors.blue,
                Colors.pink,
                Colors.purple,
                Colors.orange,
                Color.fromARGB(255, 125, 117, 185),
                Color.fromARGB(255, 139, 118, 118),
              ],
              dataMap: {
                health: chartValue(reportController!.healthExpenseAmount),
                family: chartValue(reportController!.familyExpenseAmount),
                shopping: chartValue(reportController!.shoppingExpenseAmount),
                food: chartValue(reportController!.foodExpenseAmount),
                vehicle: chartValue(reportController!.vehicleExpenseAmount),
                salon: chartValue(reportController!.salonExpenseAmount),
                devices: chartValue(reportController!.deviceExpenseAmount),
                office: chartValue(reportController!.officeExpenseAmount),
                others: chartValue(reportController!.othersExpenseAmount),
              },
              animationDuration: const Duration(seconds: 1),
              ringStrokeWidth: 40,
              chartType: ChartType.ring,
              legendOptions: const LegendOptions(showLegends: true),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: true,
              ),
            ),
          ),

        //balance container, if full report
        // if (reportController!.reportMethod == fullReport)
        //   Container(
        //     decoration: BoxDecoration(
        //         color: primaryColor.withOpacity(0.85),
        //         borderRadius: BorderRadius.all(Radius.circular(20.0))),
        //     padding: EdgeInsets.all(10.0),
        //     width: double.infinity,
        //     child: Column(
        //       children: [
        //         Text("Balance: ${reportController!.total.toStringAsFixed(1)}",
        //             style: TextStyle(
        //                 fontSize: 20.0,
        //                 fontWeight: FontWeight.bold,
        //                 color: whiteColor)),
        //         SizedBox(height: 10.0),
        //         Row(
        //           children: [
        //             Expanded(
        //               child: Text(
        //                   "Income:\n${reportController!.totalIncome.toStringAsFixed(1)}",
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(fontSize: 20.0, color: whiteColor)),
        //             ),
        //             SizedBox(width: 10),
        //             Expanded(
        //               child: Text(
        //                   "Expense:\n${reportController!.totalExpense.toStringAsFixed(1)}",
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(fontSize: 20.0, color: whiteColor)),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),

        //category list
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              tile(
                title: "Health",
                // svgName: healthSvg,
                // incomeAmount: reportController!.healthIncomeAmount,
                expenseAmount: reportController!.healthExpenseAmount,
              ),
              tile(
                title: "Entertainment",
                // svgName: familySvg,
                // incomeAmount: reportController!.familyIncomeAmount,
                expenseAmount: reportController!.familyExpenseAmount,
              ),
              tile(
                title: "Shopping",
                // svgName: shoppingSvg,
                // incomeAmount: reportController!.shoppingIncomeAmount,
                expenseAmount: reportController!.shoppingExpenseAmount,
              ),
              tile(
                title: "Food",
                // svgName: foodSvg,
                // incomeAmount: reportController!.foodIncomeAmount,
                expenseAmount: reportController!.foodExpenseAmount,
              ),
              tile(
                title: "Travel",
                // svgName: vehicleSvg,
                // incomeAmount: reportController!.vehicleIncomeAmount,
                expenseAmount: reportController!.vehicleExpenseAmount,
              ),
              tile(
                title: "Education",
                // svgName: salonSvg,
                // incomeAmount: reportController!.salonIncomeAmount,
                expenseAmount: reportController!.salonExpenseAmount,
              ),
              tile(
                title: "Bills",
                // svgName: devicesSvg,
                // incomeAmount: reportController!.deviceIncomeAmount,
                expenseAmount: reportController!.deviceExpenseAmount,
              ),
              tile(
                title: "Rent",
                // svgName: officeSvg,
                // incomeAmount: reportController!.officeIncomeAmount,
                expenseAmount: reportController!.officeExpenseAmount,
              ),
              tile(
                title: "Others",
                // svgName: othersSvg,
                // incomeAmount: reportController!.othersIncomeAmount,
                expenseAmount: reportController!.othersExpenseAmount,
              ),
            ],
          ),
        ),
      ],
    );
  }

  ListTile tile({
    required String title,
    // required String svgName,
    // required double incomeAmount,
    required double expenseAmount,
  }) {
    double percentage = 0;
    String trailingAmount = "0.0";
    if (reportController!.reportMethod == income) {
      // percentage = incomeAmount / reportController!.totalIncome * 100;
      // if (incomeAmount != 0) {
      //   trailingAmount = "+${incomeAmount.toStringAsFixed(1)}";
      // }
      percentage = expenseAmount / reportController!.totalExpense * 100;
      if (expenseAmount != 0) {
        trailingAmount = "-${expenseAmount.toStringAsFixed(1)}";
      }
    }

    if (reportController!.reportMethod == expense) {
      percentage = expenseAmount / reportController!.totalExpense * 100;
      if (expenseAmount != 0) {
        trailingAmount = "-${expenseAmount.toStringAsFixed(1)}";
      }
    }

    // if (reportController!.reportMethod == fullReport) {
    //   trailingAmount = (incomeAmount - expenseAmount).toStringAsFixed(1);
    // }

    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(title),
      ),
      contentPadding: const EdgeInsets.all(10.0),
      // leading: Container(
      //   height: 50.0,
      //   width: 50.0,
      //   padding: EdgeInsets.all(10.0),
      //   decoration: BoxDecoration(
      //       color: whiteColor,
      //       boxShadow: [BoxShadow(color: blackColor)],
      //       borderRadius: BorderRadius.all(Radius.circular(10.0))),
      //   child: SvgPicture.asset(
      //     svgPath(svgName),
      //     height: 35.0,
      //     color: svgColor,
      //   ),
      // ),
      subtitle:
          //  reportController!.reportMethod == fullReport
          //     ? Padding(
          //         padding: const EdgeInsets.only(left: 15.0),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             // Text("$income: ${incomeAmount.toStringAsFixed(1)}",
          //             //     style: const TextStyle(color: incomeGreen)),
          //             Text("$expense: ${expenseAmount.toStringAsFixed(1)}",
          //                 style: const TextStyle(color: expenseRed)),
          //           ],
          //         ),
          //       )
          //     :
          Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
            "Percentage : ${percentage > 0 ? percentage.toStringAsFixed(1) : 0}%"),
      ),
      trailing: Text(trailingAmount,
          style: TextStyle(fontWeight: FontWeight.bold, color: expenseRed
              // reportController!.reportMethod == income
              //     ? incomeGreen
              //     : reportController!.reportMethod == expense
              //         ? expenseRed
              //         : blackColor
              )),
    );
  }

  double chartValue(double expenseAmount) {
    // if (reportController!.reportMethod == income) return incomeAmount;
    if (reportController!.reportMethod == expense) return expenseAmount;
    return expenseAmount;
  }
}
