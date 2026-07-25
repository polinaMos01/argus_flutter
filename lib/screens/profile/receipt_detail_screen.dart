import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/app_toast.dart';

class ReceiptDetailScreen extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final String status;
  final bool isSuccess;

  const ReceiptDetailScreen({
    super.key,
    this.title = 'Продление подписки Premium',
    this.date = '15 мая 2025 г., 14:30',
    this.amount = '299 ₽',
    this.status = 'Успешно',
    this.isSuccess = true,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    final statusColor = isSuccess ? const Color(0xFF6EAF91) : const Color(0xFFFF4B4B);

    return Scaffold(
      backgroundColor: const Color(0xFF060E11),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 126 * s), // MainLayout header offset

              // Receipt Glass Card (Matching Argus Cyber Theme)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24 * s),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.03),
                  borderRadius: BorderRadius.circular(24 * s),
                  border: Border.all(color: statusColor.withOpacity(0.3), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withOpacity(0.1),
                      blurRadius: 20 * s,
                      offset: Offset(0, 4 * s),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Icon Circle
                    Container(
                      width: 64 * s,
                      height: 64 * s,
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: statusColor.withOpacity(0.4)),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/dollar-sign.svg',
                          width: 28 * s,
                          height: 28 * s,
                          colorFilter: ColorFilter.mode(statusColor, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    SizedBox(height: 16 * s),

                    // Amount Text
                    Text(
                      '- $amount',
                      style: TextStyle(
                        fontFamily: 'GoogleSans',
                        color: Colors.white,
                        fontSize: 32 * s,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6 * s),

                    // Status Badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 4 * s),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12 * s),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          color: statusColor,
                          fontSize: 12 * s,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 24 * s),
                    Divider(color: Colors.white.withOpacity(0.08), height: 1),
                    SizedBox(height: 20 * s),

                    // Detail Lines
                    _buildReceiptRow(s, label: 'Услуга', value: title),
                    SizedBox(height: 12 * s),
                    _buildReceiptRow(s, label: 'Дата и время', value: date),
                    SizedBox(height: 12 * s),
                    _buildReceiptRow(s, label: 'Способ оплаты', value: 'МИР •••• 4589'),
                    SizedBox(height: 12 * s),
                    _buildReceiptRow(s, label: 'Номер транзакции', value: 'TXN-984201857'),
                    SizedBox(height: 12 * s),
                    _buildReceiptRow(s, label: 'Получатель', value: 'ООО "АРГУС КИБЕР"'),
                    SizedBox(height: 12 * s),
                    _buildReceiptRow(s, label: 'Сумма без НДС', value: amount),

                    SizedBox(height: 20 * s),
                    Divider(color: Colors.white.withOpacity(0.08), height: 1),
                    SizedBox(height: 16 * s),

                    _buildReceiptRow(
                      s,
                      label: 'Итого к оплате',
                      value: amount,
                      isBold: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28 * s),

              // Action Buttons Row
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showAppToast(context, 'PDF чек скачан на устройство');
                      },
                      child: Container(
                        height: 50 * s,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6EAF91),
                          borderRadius: BorderRadius.circular(25 * s),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6EAF91).withOpacity(0.3),
                              blurRadius: 12 * s,
                              offset: Offset(0, 4 * s),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.file_download_outlined, color: const Color(0xFF060E11), size: 20 * s),
                            SizedBox(width: 8 * s),
                            Text(
                              'Скачать PDF',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: const Color(0xFF060E11),
                                fontSize: 15 * s,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12 * s),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showAppToast(context, 'Чек отправлен на email');
                      },
                      child: Container(
                        height: 50 * s,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(25 * s),
                          border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email_outlined, color: Colors.white, size: 20 * s),
                            SizedBox(width: 8 * s),
                            Text(
                              'На Email',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Colors.white,
                                fontSize: 15 * s,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(
    double s, {
    required String label,
    required String value,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: const Color(0xFFACACAC),
            fontSize: 13 * s,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            color: Colors.white,
            fontSize: isBold ? 16 * s : 13 * s,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
