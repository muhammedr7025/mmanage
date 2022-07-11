import 'package:flutter/material.dart';
import 'package:money_management/view/transactionList.dart';
import 'package:provider/provider.dart';

import '../components/homeReportContainer.dart';
import '../components/recentTransList.dart';
import '../components/userProfileCard.dart';
import '../constFiles/colors.dart';
import '../controller/transDetailController.dart';
import '../controller/transactionController.dart';
import '../customWidgets/textButton.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransactionController transactionController =
        Provider.of<TransactionController>(context);
    TransDetailController transactionDetailController =
        Provider.of<TransDetailController>(context);

    return transactionController.fetching
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              //userData
              UserProfileCard(),
              //balance container
              HomeReportContainer(transactionController: transactionController),
              //recent transactions title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                      flex: 4,
                      child: Text("Recent transactions",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  Expanded(
                    child: CustomTextButton(
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const TransactionList())),
                      textStyle: const TextStyle(
                          color: selectedTextButton,
                          fontWeight: FontWeight.bold),
                      text: 'See All',
                    ),
                  )
                ],
              ),
              //transaction List View
              RecentTransList(
                  transController: transactionController,
                  transDetailController: transactionDetailController),
            ],
          );
  }
}
