import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PaymentTransaction {
  final String title;
  final String date;
  final String amount;
  final String status;
  final bool isSuccess;

  const PaymentTransaction({
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
    required this.isSuccess,
  });
}

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  static const List<PaymentTransaction> transactions = [
    PaymentTransaction(
      title: 'Продление подписки Premium',
      date: '15 мая 2025 г., 14:30',
      amount: '299 ₽',
      status: 'Успешно',
      isSuccess: true,
    ),
    PaymentTransaction(
      title: 'Продление подписки Premium',
      date: '15 апр. 2025 г., 14:30',
      amount: '299 ₽',
      status: 'Успешно',
      isSuccess: true,
    ),
    PaymentTransaction(
      title: 'Попытка списания (Ошибка)',
      date: '14 апр. 2025 г., 14:28',
      amount: '299 ₽',
      status: 'Отклонено',
      isSuccess: false,
    ),
    PaymentTransaction(
      title: 'Активация подписки Premium',
      date: '15 мар. 2025 г., 14:30',
      amount: '299 ₽',
      status: 'Успешно',
      isSuccess: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    return Scaffold(
      backgroundColor: const Color(0xFF060E11),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 96 * s), // MainLayout header offset

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                separatorBuilder: (ctx, idx) => SizedBox(height: 12 * s),
                itemBuilder: (ctx, idx) {
                  final txn = transactions[idx];
                  return _buildTransactionItem(context, s, txn);
                },
              ),

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, double s, PaymentTransaction txn) {
    final statusColor = txn.isSuccess ? const Color(0xFF6EAF91) : const Color(0xFFFF4B4B);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.push('/profile/payment-receipt', extra: txn);
      },
      child: Container(
        padding: EdgeInsets.all(16 * s),
        decoration: BoxDecoration(
          color: txn.isSuccess
              ? const Color(0xFFD9D9D9).withOpacity(0.03)
              : const Color(0xFFFF4B4B).withOpacity(0.04),
          borderRadius: BorderRadius.circular(16 * s),
          border: Border.all(
            color: txn.isSuccess
                ? const Color(0xFFD9D9D9).withOpacity(0.15)
                : const Color(0xFFFF4B4B).withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42 * s,
              height: 42 * s,
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12 * s),
                border: Border.all(color: statusColor.withOpacity(0.3)),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/dollar-sign.svg',
                  width: 20 * s,
                  height: 20 * s,
                  colorFilter: ColorFilter.mode(statusColor, BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(width: 14 * s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    txn.title,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: 15 * s,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4 * s),
                  Text(
                    txn.date,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: const Color(0xFFACACAC),
                      fontSize: 12 * s,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '- ${txn.amount}',
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontSize: 15 * s,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4 * s),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      txn.status,
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: statusColor,
                        fontSize: 12 * s,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4 * s),
                    Icon(Icons.chevron_right, color: Colors.white54, size: 14 * s),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
