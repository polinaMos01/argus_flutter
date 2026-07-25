import 'package:flutter/material.dart';
import '../../widgets/data_exposure_block.dart';

class DataExposureScreen extends StatelessWidget {
  const DataExposureScreen({super.key});

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
              SizedBox(height: 126 * s), // Spacing below MainLayout header

              const DataExposureBlock(
                showTopCard: true,
                customHeader: null,
              ),

              SizedBox(height: 120 * s),
            ],
          ),
        ),
      ),
    );
  }
}
