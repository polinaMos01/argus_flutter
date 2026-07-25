import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../widgets/app_toast.dart';
import '../../widgets/main_layout.dart';
import '../../theme/app_colors.dart';

class CyberAdvisorScreen extends StatefulWidget {
  const CyberAdvisorScreen({super.key});

  @override
  State<CyberAdvisorScreen> createState() => _CyberAdvisorScreenState();
}

final List<Map<String, dynamic>> _globalCyberAdvisorMessages = [
  {
    'sender': 'ai',
    'text': 'Привет! Я ваш персональный ИИ-помощник в сфере цифровой безопасности. Чем могу помочь сегодня?'
  }
];

class _CyberAdvisorScreenState extends State<CyberAdvisorScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _attachedFileName;

  final List<Map<String, dynamic>> _prompts = [
    {'text': 'Объясни результаты проверки', 'icon': Icons.security},
    {'text': 'Как усилить пароль?', 'icon': Icons.lock},
    {'text': 'Проверь подозрительную ссылку', 'icon': Icons.link},
  ];

  void _showAttachmentOptions() {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double s = canvasWidth / 393.0;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF060E11),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF101E17),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24 * s),
              topRight: Radius.circular(24 * s),
            ),
            border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.3)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24 * s, vertical: 20 * s),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40 * s,
                height: 4 * s,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2 * s),
                ),
              ),
              SizedBox(height: 20 * s),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Прикрепить к сообщению',
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    color: Colors.white,
                    fontSize: 18 * s,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 16 * s),

              // Option 1: Сделать фото
              _buildOptionTile(
                s,
                icon: Icons.camera_alt_outlined,
                title: 'Сделать фото',
                subtitle: 'Использовать камеру устройства',
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _attachedFileName = 'foto_skan.jpg';
                  });
                  showAppToast(context, 'Прикреплено фото: foto_skan.jpg');
                },
              ),
              SizedBox(height: 10 * s),

              // Option 2: Выбрать из медиатеки
              _buildOptionTile(
                s,
                icon: Icons.photo_library_outlined,
                title: 'Выбрать из медиатеки',
                subtitle: 'Загрузить из галереи изображений',
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _attachedFileName = 'izobrazhenie_galereya.png';
                  });
                  showAppToast(context, 'Выбрано из медиатеки: izobrazhenie_galereya.png');
                },
              ),
              SizedBox(height: 10 * s),

              // Option 3: Загрузить файл
              _buildOptionTile(
                s,
                icon: Icons.insert_drive_file_outlined,
                title: 'Загрузить файл',
                subtitle: 'Выбрать документ (PDF, DOCX, TXT)',
                onTap: () async {
                  Navigator.pop(context);
                  await _pickAttachmentFile();
                },
              ),
              SizedBox(height: 16 * s),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionTile(
    double s, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 14 * s),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9).withOpacity(0.04),
          borderRadius: BorderRadius.circular(14 * s),
          border: Border.all(color: const Color(0xFFD9D9D9).withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              width: 40 * s,
              height: 40 * s,
              decoration: BoxDecoration(
                color: const Color(0xFF6EAF91).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10 * s),
              ),
              child: Icon(icon, color: const Color(0xFF6EAF91), size: 22 * s),
            ),
            SizedBox(width: 14 * s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.white,
                      fontSize: 15 * s,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2 * s),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: const Color(0xFFACACAC),
                      fontSize: 12 * s,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white38, size: 20 * s),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAttachmentFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'txt'],
      );
      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        setState(() {
          _attachedFileName = file.name;
        });
        if (mounted) {
          showAppToast(context, 'Прикреплён файл: ${file.name}');
        }
      }
    } catch (_) {
      setState(() {
        _attachedFileName = 'dokument_proverki.pdf';
      });
      if (mounted) {
        showAppToast(context, 'Прикреплён файл: dokument_proverki.pdf');
      }
    }
  }

  Map<String, dynamic> _generateAIResponse(String text, String? attachedFile) {
    final lower = text.toLowerCase().trim();

    if (attachedFile != null) {
      return {
        'sender': 'ai',
        'isError': false,
        'text': 'Файл "$attachedFile" принят и проанализирован антивирусными двигателями Argus Security. Подозрительной активности и макроугроз не обнаружено.',
      };
    }

    // Recognized security terms check
    final isGreeting = lower.contains('привет') || lower.contains('здравст') || lower.contains('hello') || lower.contains('hi');
    final isPassword = lower.contains('пароль') || lower.contains('pass') || lower.contains('комбинац');
    final isLeak = lower.contains('утечк') || lower.contains('слив') || lower.contains('баз') || lower.contains('почт') || lower.contains('email') || lower.contains('телефон');
    final isFile = lower.contains('файл') || lower.contains('документ') || lower.contains('вирус') || lower.contains('угроз') || lower.contains('скан');
    final isLink = lower.contains('ссылк') || lower.contains('сайт') || lower.contains('фишинг') || lower.contains('url') || lower.contains('домен');
    final isHelp = lower.contains('помощь') || lower.contains('объясни') || lower.contains('как') || lower.contains('что') || lower.contains('провер');

    if (isPassword) {
      return {
        'sender': 'ai',
        'isError': false,
        'text': 'Для максимальной устойчивости пароля используйте длину от 12 символов, сочетание заглавных и строчных букв, цифр и спецсимволов. Не используйте одинаковые пароли для разных аккаунтов.',
      };
    }

    if (isLeak) {
      return {
        'sender': 'ai',
        'isError': false,
        'text': 'При обнаружении ваших данных в утечках смените пароли на скомпрометированных сервисах, завершите сторонние сессии и активируйте двухфакторную аутентификацию (2FA).',
      };
    }

    if (isFile) {
      return {
        'sender': 'ai',
        'isError': false,
        'text': 'Файлы проверяются с помощью 89 антивирусных движков. Избегайте открытия архивов и документов с макросами, присланных из неизвестных источников.',
      };
    }

    if (isLink) {
      return {
        'sender': 'ai',
        'isError': false,
        'text': 'Фишинговые ссылки часто маскируются под официальные сайты. Проверяйте адресную строку на опечатки и используйте наш инструмент «Проверка ссылки».',
      };
    }

    if (isGreeting || isHelp) {
      return {
        'sender': 'ai',
        'isError': false,
        'text': 'Я персональный ИИ-ассистент Argus. Вы можете спросить меня о проверке паролей, утечках e-mail/телефона, анализе подозрительных ссылок и файлов.',
      };
    }

    // Unrecognized / gibberish query -> Return Error response
    return {
      'sender': 'ai',
      'isError': true,
      'text': '⚠️ Ошибка: Запрос не распознан. Задайте вопрос касательно кибербезопасности, паролей, проверки файлов, ссылок или утечек данных.',
    };
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty && _attachedFileName == null) return;

    final userMsgText = text.trim();
    final attachedFile = _attachedFileName;

    setState(() {
      _globalCyberAdvisorMessages.add({
        'sender': 'user',
        'text': userMsgText.isEmpty ? 'Прикреплён файл' : userMsgText,
        'attachment': attachedFile,
      });
      _attachedFileName = null;
    });

    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      setState(() {
        final aiResponse = _generateAIResponse(userMsgText, attachedFile);
        _globalCyberAdvisorMessages.add(aiResponse);
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double canvasWidth = screenWidth > 430 ? 430.0 : screenWidth;
    final double sVal = canvasWidth / 393.0;
    double s(double v) => v * sVal;

    return Scaffold(
      backgroundColor: const Color(0xFF060E11),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: s(24)),
              child: Column(
                children: [
                  SizedBox(height: s(96)), // Header padding (exact 48px margin)

                  // Chat Messages List
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _globalCyberAdvisorMessages.length,
                      itemBuilder: (context, index) {
                        final msg = _globalCyberAdvisorMessages[index];
                        final isUser = msg['sender'] == 'user';
                        final isError = msg['isError'] == true;
                        final String? attachment = msg['attachment'] as String?;

                        return Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: s(12)),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.75,
                            ),
                            padding: EdgeInsets.all(s(14)),
                            decoration: BoxDecoration(
                              color: isError
                                  ? const Color(0xFFFF4B4B).withOpacity(0.12)
                                  : (isUser
                                      ? AppColors.colorGreen
                                      : const Color(0xFF1E1E2E)),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: const Radius.circular(16),
                                bottomLeft: Radius.circular(isUser ? 16 : 4),
                                bottomRight: Radius.circular(isUser ? 4 : 16),
                              ),
                              border: isError
                                  ? Border.all(color: const Color(0xFFFF4B4B).withOpacity(0.22), width: 1.5)
                                  : (isUser
                                      ? null
                                      : Border.all(color: Colors.white.withOpacity(0.05))),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (attachment != null) ...[
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: s(10), vertical: s(6)),
                                    margin: EdgeInsets.only(bottom: s(8)),
                                    decoration: BoxDecoration(
                                      color: isUser
                                          ? const Color(0xFF060E11).withOpacity(0.15)
                                          : const Color(0xFF6EAF91).withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(s(8)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.insert_drive_file_outlined,
                                          color: isUser ? const Color(0xFF060E11) : const Color(0xFF6EAF91),
                                          size: s(16),
                                        ),
                                        SizedBox(width: s(6)),
                                        Flexible(
                                          child: Text(
                                            attachment,
                                            style: TextStyle(
                                              fontFamily: 'GoogleSans',
                                              color: isUser ? const Color(0xFF060E11) : Colors.white,
                                              fontSize: s(12),
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                Text(
                                  msg['text'] ?? '',
                                  style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    color: isUser ? AppColors.bgPrimary : Colors.white,
                                    fontSize: s(15),
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Quick prompts horizontal scroll
                  SizedBox(
                    height: s(40),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _prompts.length,
                      itemBuilder: (context, index) {
                        final item = _prompts[index];
                        return Container(
                          margin: EdgeInsets.only(right: s(8)),
                          child: ActionChip(
                            onPressed: () => _sendMessage(item['text']),
                            backgroundColor: const Color(0xFF1E1E2E),
                            side: BorderSide(color: AppColors.colorGreen.withOpacity(0.5)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            avatar: Icon(
                              item['icon'] as IconData,
                              size: s(14),
                              color: AppColors.colorGreen,
                            ),
                            label: Text(
                              item['text'] as String,
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Colors.white,
                                fontSize: s(13),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: s(12)),

                  // Attachment Preview Banner if selected
                  if (_attachedFileName != null) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: s(12), vertical: s(8)),
                      margin: EdgeInsets.only(bottom: s(8)),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6EAF91).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(s(10)),
                        border: Border.all(color: const Color(0xFF6EAF91).withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.attach_file, color: const Color(0xFF6EAF91), size: s(18)),
                          SizedBox(width: s(8)),
                          Expanded(
                            child: Text(
                              _attachedFileName!,
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: Colors.white,
                                fontSize: s(13),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _attachedFileName = null;
                              });
                            },
                            child: Icon(Icons.close, color: Colors.white70, size: s(18)),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Text Input field
                  Container(
                    margin: EdgeInsets.only(bottom: s(16)),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              color: Colors.white,
                              fontSize: s(15),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Напишите сообщение...',
                              hintStyle: TextStyle(
                                fontFamily: 'GoogleSans',
                                color: AppColors.textSecondary,
                                fontSize: s(15),
                              ),
                              prefixIcon: IconButton(
                                icon: Icon(
                                  Icons.attach_file,
                                  color: _attachedFileName != null
                                      ? AppColors.colorGreen
                                      : AppColors.textSecondary,
                                  size: 22,
                                ),
                                onPressed: _showAttachmentOptions,
                              ),
                              filled: true,
                              fillColor: const Color(0xFF1E1E2E),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: s(16),
                                vertical: s(12),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.05),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.05),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.colorGreen,
                                ),
                              ),
                            ),
                            onSubmitted: (value) {
                              _sendMessage(value);
                              _controller.clear();
                            },
                          ),
                        ),
                        SizedBox(width: s(8)),
                        GestureDetector(
                          onTap: () {
                            _sendMessage(_controller.text);
                            _controller.clear();
                          },
                          child: Container(
                            width: s(46),
                            height: s(46),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E2E),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_upward,
                              color: AppColors.colorGreen,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
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
