import 'package:budget/firestore.dart';
// import 'package:budget/main.dart';
import 'package:budget/pages/pages.dart';
import 'package:budget/widgets/segmentgraph.dart';
import 'package:budget/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:telephony/telephony.dart';

import '../models/transactionmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String parseAmount(double amount) {
    return NumberFormat.decimalPatternDigits(
      locale: "en_IN",
      decimalDigits: 2,
    ).format(amount);
  }

  // Telephony telephony = Telephony.instance;

  // @override
  // void initState() {
  //   telephony.listenIncomingSms(
  //     onNewMessage: (SmsMessage message) {
  //       if (message.address!.contains('BW-SBIUPI')) {
  //         final regexp = RegExp(
  //             r'Dear UPI user A\/C x9786 debited by (\d.*\.\d.*) on date (\d{2}\w{3}\d{2}) trf to (\w.*) Refno (\d.*). if not u\? call 1800111109. -SBI');
  //         final match = regexp.firstMatch(message.body.toString());
  //         if (match!.groupCount != 0) {
  //           print(match.group(0).toString());
  //           print(match.group(1).toString());
  //           print(match.group(2).toString());
  //           print(match.group(3).toString());
  //           Firestore.createDummyTransaction(
  //             TransactionModel(
  //               name: "Dummy",
  //               amount: match.group(1).toString(),
  //               type: "Dummy",
  //               category: "Dummy",
  //               date: match.group(2).toString(),
  //               notes: match.group(3).toString(),
  //             ),
  //           );
  //         }
  //       } else {
  //         const SnackBar(content: Text("error"));
  //       }
  //     },
  //     listenInBackgceil: true,
  //     onBackgceilMessage: backgrounMessageHandler,
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double totalExpense = 0;
    double totalIncome = 0;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(
                          balance: parseAmount(totalIncome - totalExpense),
                          totalExpense: parseAmount(totalExpense),
                          totalSaving: parseAmount(totalIncome)),
                    ));
              },
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://lh3.googleusercontent.com/pw/ADCreHe8oEOTBw-mMSesqMf4csTFZDE4NaJRTj3nMvWghoqhVKcB8zjDf7DS7h5wYzMvufG0JEFfqgymmFaJHxYp_w6FRyUdZ06s6oew0LRBcEIbyk11RwS3djRn4Oa32ys_jKoUuKU_yeBZbSKMSOxHX81BIhgbY_6uUbQDQewX6brqJz-i_r7R2lj9B5mv2ljdXdxoDWOh1_-rOqCpAh2SMf1d-nL_KdS-FS-wW8aVhDfR9j97bG6MXG-kyzknUr1jrn63UuMhdWxQeOfY7c-lXAR6zlvnWlEwIHtBRrQ2Du_j0_C6oGRNBROSo2Z1JSC3360Pj9U9EhiHG5z5r7JSxoU_FIvxxac-5uJpeY7LGdTv0vmDT-59nACXN04W3qLktjUg3LvGxZA5R-7_77U1w_p0vXf2XQ4ESsjjmvVJW0Bci60kiJlKyPybgNkESxmdtfvXc_KnjnaSHXS51cxr7ZHsdIOK798-gNiJKWyPqwqM6Jieoq5ajIWk_7bSm8RdBA9wlAHQMMvHM_NxNvPMYg8vTLs8kj4cWagXi5ZIKdPQnAkULRsA3tRbETbAR_KZn8QiecfnWFme-JYjp-6WOvIsF-namJnztf5FECF1nxYAGzrsKciUX__XTbkPyKDyMW7DYJgbteC5C4a7WAdFh8otZFh0X9zTZmVdIJHjFUO3EcLyhIQaLaqL-Qvi66f0dcDU5DLyGyM3feS0NJEnX5gRzcOtTfl9EPn_cqQm2Np22G-0E4w9q57n5MNrc7f5-fazuO4lhKrACus_qvPWy0owxBjveA7HZL2KOXAp1tAED9VrwHUh1Qz41XioMeRo5D6xzIipWennSXQZypb2uLbsVZiRm3gJaaMfiXlLu3HR1U64knT-AkXpzUy7AV5nbgZVYiq7SyxbCHFeR8jcBQA=w1365-h910-s-no?authuser=0"),
              ),
            ),
          )
        ],
        title: const Text("Expenses"),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder<List<TransactionModel>>(
              stream: Firestore.readTransactions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Some error occured"),
                  );
                }
                if (snapshot.hasData) {
                  totalExpense = 0;
                  totalIncome = 0;
                  double totalFood = 0;
                  double totalTravel = 0;
                  double totalGroceries = 0;
                  double totalRent = 0;
                  double totalPersonal = 0;
                  final transactionData = snapshot.data;
                  if (transactionData!.isEmpty) {
                    return const Expanded(
                      child: Column(
                        children: [
                          TopCard(
                            balance: "0.00",
                            totalExpense: "0.00",
                            totalIncome: "0.00",
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "No Transactions",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  for (var transaction in transactionData) {
                    if (transaction.type == "Expense") {
                      totalExpense += double.parse(transaction.amount);
                    } else if (transaction.type == "Income") {
                      totalIncome += double.parse(transaction.amount);
                    }
                    if (transaction.category == "Food" &&
                        transaction.type == "Expense") {
                      totalFood += double.parse(transaction.amount);
                    } else if (transaction.category == "Travel" &&
                        transaction.type == "Expense") {
                      totalTravel += double.parse(transaction.amount);
                    } else if (transaction.category == "Groceries" &&
                        transaction.type == "Expense") {
                      totalGroceries += double.parse(transaction.amount);
                    } else if (transaction.category == "Rent" &&
                        transaction.type == "Expense") {
                      totalRent += double.parse(transaction.amount);
                    } else if (transaction.category == "Personal" &&
                        transaction.type == "Expense") {
                      totalPersonal += double.parse(transaction.amount);
                    }
                  }
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopCard(
                          balance: parseAmount(totalIncome - totalExpense),
                          totalExpense: parseAmount(totalExpense),
                          totalIncome: parseAmount(totalIncome),
                        ),
                        SegmentGraph(
                          rentWidth: ((totalRent / totalExpense) *
                                      MediaQuery.of(context).size.width +
                                  40)
                              .ceil(),
                          groceriesWidth: ((totalGroceries / totalExpense) *
                                      MediaQuery.of(context).size.width +
                                  40)
                              .ceil(),
                          travelWidth: ((totalTravel / totalExpense) *
                                      MediaQuery.of(context).size.width +
                                  40)
                              .ceil(),
                          foodWidth: ((totalFood / totalExpense) *
                                      MediaQuery.of(context).size.width +
                                  40)
                              .ceil(),
                          personalWidth: ((totalPersonal / totalExpense) *
                                      MediaQuery.of(context).size.width +
                                  40)
                              .ceil(),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  final transaction = transactionData[index];
                                  return TransactionTile(
                                    id: transaction.id.toString(),
                                    name: transaction.name,
                                    amount: transaction.amount,
                                    category: transaction.category,
                                    type: transaction.type,
                                    // date: transaction.date,
                                    notes: transaction.notes,
                                    timestamp: transaction.timestamp,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: transactionData.length,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: AddButton(
                text: "Add New Transaction",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
