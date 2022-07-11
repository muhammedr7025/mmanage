import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constFiles/colors.dart';
import '../constFiles/strings.dart';
import '../controller/reportController.dart';
import 'categorySelector.dart';

class CategorySelectHeader extends StatelessWidget {
  const CategorySelectHeader({Key? key}) : super(key: key);

  static ReportController? reportController;

  @override
  Widget build(BuildContext context) {
    reportController = Provider.of<ReportController>(context);
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
          color: tabContainer,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Row(
        children: [
          // CategorySelector(
          //     reportController: reportController!,
          //     text: fullReport,
          //     containerColor: containerColor(fullReport),
          //     textColor: categoryTextColor(fullReport),
          //     onPress: () => reportController!.cartButton(fullReport)),
          // CategorySelector(
          //     reportController: reportController!,
          //     text: income,
          //     containerColor: containerColor(income),
          //     textColor: categoryTextColor(income),
          //     onPress: () => reportController!.cartButton(income)),
          CategorySelector(
              reportController: reportController!,
              text: expense,
              containerColor: containerColor(expense),
              textColor: categoryTextColor(expense),
              onPress: () => reportController!.cartButton(expense)),
          IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                DateTimeRange? picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2015),
                    lastDate: DateTime(DateTime.now().year + 10));
                if (picked != null) {
                  reportController!.fetchTransaction(
                      customFromDate: picked.start, customToDate: picked.end);
                }
              })
        ],
      ),
    );
  }

  Color containerColor(String method) =>
      reportController!.reportMethod == method
          ? primaryColor
          : Colors.transparent;

  Color categoryTextColor(String method) =>
      reportController!.reportMethod == method ? whiteColor : categoryText;
}
