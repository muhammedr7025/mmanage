import 'package:flutter/material.dart';

import 'package:money_management/view/transaction_detail.dart';
import 'package:provider/provider.dart';

import '../constFiles/colors.dart';
import '../constFiles/dateConvert.dart';
import '../controller/reportController.dart';
import '../controller/transDetailController.dart';
import '../controller/transactionController.dart';
import '../model/transactionModel.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionController transactionController =
        Provider.of<TransactionController>(context);
    TransDetailController transactionDetailController =
        Provider.of<TransDetailController>(context);
    ReportController reportController = Provider.of<ReportController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Day Manager", style: TextStyle(color: primaryColor)),
        centerTitle: true,
        backgroundColor: whiteColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: blackColor),
      ),
      body: transactionController.transactionList.isEmpty
          ? const Center(child: Text("No Records"))
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: transactionController.transactionList.length,
              itemBuilder: (BuildContext context, int index) {
                TransactionModel? data =
                    transactionController.transactionList[index];

                String amountSign = data!.isIncome == 1 ? "+" : "-";
                Color amountColor =
                    data.isIncome == 1 ? incomeGreen : expenseRed;

                return ListTile(
                  onTap: () {
                    transactionDetailController.toTransactionDetail(
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
                                TransactionDetail()));
                  },
                  title: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(data.title ?? ""),
                  ),
                  contentPadding: const EdgeInsets.all(5.0),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dateConverter(DateTime.parse(
                            data.dateTime ?? "2000-01-1 00:00:00.000"))),
                        Text(
                          "$amountSign${data.amount}",
                          style: TextStyle(color: amountColor),
                        )
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      transactionController.deleteTransaction(data.id ?? 0);
                      transactionController.fetchTransaction();
                      reportController.fetchTransaction();
                    },
                    icon: Icon(Icons.delete_outline, color: svgColor),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
    );
  }
}
