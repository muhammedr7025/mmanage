import 'package:flutter/material.dart';

import '../constFiles/colors.dart';
import '../constFiles/dateConvert.dart';
import '../controller/transDetailController.dart';
import '../controller/transactionController.dart';
import '../model/transactionModel.dart';
import '../view/transaction_detail.dart';

class RecentTransList extends StatelessWidget {
  const RecentTransList({
    Key? key,
    required this.transController,
    required this.transDetailController,
  }) : super(key: key);

  final TransactionController transController;
  final TransDetailController transDetailController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transController.transactionList.isEmpty
          ? const Center(child: Text("No Records"))
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                if (transController.transactionList.length > index) {
                  TransactionModel? data =
                      transController.transactionList[index];

                  String amountSign = data!.isIncome == 1 ? "+" : "-";
                  Color amountColor =
                      data.isIncome == 1 ? incomeGreen : expenseRed;

                  return ListTile(
                    onTap: () {
                      transDetailController.toTransactionDetail(
                          isSaved: true,
                          id: data.id,
                          title: data.title,
                          description: data.description,
                          amount: data.amount,
                          department: data.category,
                          isIncome: data.isIncome == 1 ? true : false,
                          dateTime: data.dateTime);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TransactionDetail()),
                      );
                    },
                    title: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(data.title ?? ""),
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(dateConverter(DateTime.parse(
                          data.dateTime ?? "2000-01-1 00:00:00.000"))),
                    ),
                    trailing: Text(
                      "$amountSign${data.amount}",
                      style: TextStyle(color: amountColor),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
    );
  }
}
