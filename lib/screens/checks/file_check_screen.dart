import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/main_layout.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/check_loading_view.dart';
import 'package:file_picker/file_picker.dart';

enum CheckState { idle, loading, completed }

class FileCheckScreen extends StatefulWidget {
  const FileCheckScreen({super.key});

  @override
  State<FileCheckScreen> createState() => _FileCheckScreenState();
}

class _FileCheckScreenState extends State<FileCheckScreen> {
  String? _selectedFileName;
  CheckState _checkState = CheckState.idle;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;
    
    return Scaffold(
      backgroundColor: const Color(0xFF060E11),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 96 * s),
            if (_checkState == CheckState.loading)
              Expanded(
                child: CheckLoadingView(
                  label: 'Проверка файла...',
                  onComplete: () {
                    if (mounted) {
                      context.push('/file-check-result', extra: _selectedFileName ?? 'file.pdf');
                      setState(() {
                        _checkState = CheckState.idle;
                        _selectedFileName = null;
                      });
                    }
                  },
                ),
              )
            else
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16 * s),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 32 * s),
                    Container(
                      width: double.infinity,
                      height: 240 * s,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B1416),
                        borderRadius: BorderRadius.circular(16 * s),
                        border: Border.all(color: const Color(0xFF1E2C30)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.download, color: const Color(0xFF6EAF91), size: 48 * s),
                          SizedBox(height: 16 * s),
                          Text(
                            'Нажмите для выбора файла',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: 16 * s,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8 * s),
                          Text(
                            'PDF, DOC, EXE, APK, ZIP и другие',
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 14 * s,
                            ),
                          ),
                          SizedBox(height: 16 * s),
                          GestureDetector(
                            onTap: () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles();
                              if (result != null) {
                                setState(() {
                                  _selectedFileName = result.files.single.name;
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24 * s, vertical: 12 * s),
                              decoration: BoxDecoration(
                                color: const Color(0xFF386851).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20 * s),
                                border: Border.all(color: const Color(0xFF386851)),
                              ),
                              child: Text(
                                'Выбрать файл',
                                style: TextStyle(color: const Color(0xFF6EAF91), fontSize: 14 * s),
                              ),
                            ),
                          ),
                          if (_selectedFileName != null) ...[
                            SizedBox(height: 16 * s),
                            Text(
                              'Выбранный файл: $_selectedFileName',
                              style: TextStyle(color: Colors.white, fontSize: 14 * s),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 48 * s),
                    GestureDetector(
                      onTap: () {
                        if (_selectedFileName != null) {
                           setState(() {
                             _checkState = CheckState.loading;
                           });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 18 * s),
                        decoration: BoxDecoration(
                          color: _selectedFileName != null ? const Color(0xFF6EAF91) : const Color(0xFF1C382A),
                          borderRadius: BorderRadius.circular(30 * s),
                          border: Border.all(color: const Color(0xFF2E5B3F).withOpacity(0.5), width: 1.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Проверить',
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: _selectedFileName != null ? Colors.white : Colors.white.withOpacity(0.5),
                                fontSize: 16 * s,
                              ),
                            ),
                            SizedBox(width: 8 * s),
                            Icon(Icons.chevron_right, color: _selectedFileName != null ? Colors.white : Colors.white.withOpacity(0.5), size: 20 * s),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
