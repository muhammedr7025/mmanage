import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';

import '../constFiles/colors.dart';
import '../constFiles/strings.dart';
import '../controller/transactionController.dart';

class HomeReportContainer extends StatefulWidget {
  const HomeReportContainer({
    Key? key,
    required this.transactionController,
  }) : super(key: key);

  final TransactionController transactionController;

  @override
  State<HomeReportContainer> createState() => _HomeReportContainerState();
}

class _HomeReportContainerState extends State<HomeReportContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.85),
          borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Total Balance",
              style: TextStyle(
                  color: whiteColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("INR", style: TextStyle(color: textINRColor)),
              Expanded(
                child: AutoSizeText(
                    widget.transactionController.total.toStringAsFixed(1),
                    style: const TextStyle(
                        color: whiteColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                    textAlign: TextAlign.center),
              ),
            ],
          ),
          IncomeExpense(transactionController: widget.transactionController),
        ]
            .map((e) =>
                Padding(padding: const EdgeInsets.only(top: 15.0), child: e))
            .toList(),
      ),
    );
  }
}

class IncomeExpense extends StatelessWidget {
  const IncomeExpense({
    Key? key,
    required this.transactionController,
  }) : super(key: key);

  final TransactionController transactionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.arrow_downward, color: incomeGreen),
                    Text(income, style: const TextStyle(color: containerText)),
                  ],
                ),
                Center(
                  child: AutoSizeText(
                    transactionController.totalIncome.toStringAsFixed(1),
                    style: const TextStyle(color: whiteColor, fontSize: 20),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            color: containerText,
            width: 2,
            height: 50.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.arrow_upward, color: expenseRed),
                    Text(expense, style: const TextStyle(color: containerText)),
                  ],
                ),
                Center(
                  child: AutoSizeText(
                    transactionController.totalExpense.toStringAsFixed(1),
                    style: const TextStyle(color: whiteColor, fontSize: 20),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
