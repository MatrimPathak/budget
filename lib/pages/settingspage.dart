import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final String balance;
  final String totalSaving;
  final String totalExpense;
  const SettingsPage({
    super.key,
    required this.balance,
    required this.totalSaving,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/pw/ADCreHe8oEOTBw-mMSesqMf4csTFZDE4NaJRTj3nMvWghoqhVKcB8zjDf7DS7h5wYzMvufG0JEFfqgymmFaJHxYp_w6FRyUdZ06s6oew0LRBcEIbyk11RwS3djRn4Oa32ys_jKoUuKU_yeBZbSKMSOxHX81BIhgbY_6uUbQDQewX6brqJz-i_r7R2lj9B5mv2ljdXdxoDWOh1_-rOqCpAh2SMf1d-nL_KdS-FS-wW8aVhDfR9j97bG6MXG-kyzknUr1jrn63UuMhdWxQeOfY7c-lXAR6zlvnWlEwIHtBRrQ2Du_j0_C6oGRNBROSo2Z1JSC3360Pj9U9EhiHG5z5r7JSxoU_FIvxxac-5uJpeY7LGdTv0vmDT-59nACXN04W3qLktjUg3LvGxZA5R-7_77U1w_p0vXf2XQ4ESsjjmvVJW0Bci60kiJlKyPybgNkESxmdtfvXc_KnjnaSHXS51cxr7ZHsdIOK798-gNiJKWyPqwqM6Jieoq5ajIWk_7bSm8RdBA9wlAHQMMvHM_NxNvPMYg8vTLs8kj4cWagXi5ZIKdPQnAkULRsA3tRbETbAR_KZn8QiecfnWFme-JYjp-6WOvIsF-namJnztf5FECF1nxYAGzrsKciUX__XTbkPyKDyMW7DYJgbteC5C4a7WAdFh8otZFh0X9zTZmVdIJHjFUO3EcLyhIQaLaqL-Qvi66f0dcDU5DLyGyM3feS0NJEnX5gRzcOtTfl9EPn_cqQm2Np22G-0E4w9q57n5MNrc7f5-fazuO4lhKrACus_qvPWy0owxBjveA7HZL2KOXAp1tAED9VrwHUh1Qz41XioMeRo5D6xzIipWennSXQZypb2uLbsVZiRm3gJaaMfiXlLu3HR1U64knT-AkXpzUy7AV5nbgZVYiq7SyxbCHFeR8jcBQA=w1365-h910-s-no?authuser=0'),
            ),
            const SizedBox(height: 20),
            const Text(
              "Matrim Pathak",
              style: TextStyle(fontSize: 25),
            ),
            const Text(
              "Graduate Intern | RSA Netwitness",
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              "+91 XXXXXX4597",
              style: TextStyle(fontSize: 18),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  const Text(
                    "Available Balance",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "₹ $balance",
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          const Text(
                            "Total Saved",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "₹ $totalSaving",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          const Text(
                            "Total Spent",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "₹ $totalExpense",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Sign out",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
