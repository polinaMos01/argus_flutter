import '../models/threat_item.dart';
import '../models/user_profile.dart';
import '../models/security_score.dart';

class MockData {
  static final UserProfile user = UserProfile(
    username: 'ghost_user',
    email: 'g***@protonmail.com',
    phone: '+7 999 ***-**-67',
    plan: 'Premium',
    planExpiry: '15.06.2025',
  );

  static final SecurityScore score = SecurityScore(
    score: 78,
    maxScore: 100,
    level: 'Хороший уровень',
    leaksPercent: 62,
    leaksCount: 47,
  );

  static List<ThreatItem> threats = [
    ThreatItem(
      id: 'canva',
      serviceName: 'Canva',
      leakDate: '14 мая 2026',
      severity: 'Critical',
      isResolved: false,
      leakedData: ['Email', 'Пароль'],
      details: {
        'Email': 'g***@protonmail.com',
        'Пароль': 'AlexTomson2024!',
        'Тип утечки': 'База данных пользователей',
      },
      recommendations: [
        'Срочно смените пароль на Canva',
        'Включите двухфакторную аутентификацию (2FA) в настройках аккаунта',
        'Если вы использовали этот же пароль на других сайтах, измените его там тоже',
      ],
      websiteUrl: 'https://www.canva.com',
    ),
    ThreatItem(
      id: 'adobe',
      serviceName: 'Adobe Creative Cloud',
      leakDate: '23 марта 2026',
      severity: 'Critical',
      isResolved: false,
      leakedData: ['Email', 'Хэш пароля', 'ID пользователя'],
      details: {
        'Email': 'g***@protonmail.com',
        'Хэш пароля': r'sha256$87a8b9f1d2e3c4b5a6...',
        'ID пользователя': 'usr_983109310',
      },
      recommendations: [
        'Смените пароль в Adobe Account',
        'Установите менеджер паролей для генерации уникальных ключей',
        'Проверьте историю входов на предмет подозрительной активности',
      ],
      websiteUrl: 'https://account.adobe.com',
    ),
    ThreatItem(
      id: 'dropbox',
      serviceName: 'Dropbox',
      leakDate: '10 ноября 2025',
      severity: 'Warning',
      isResolved: true,
      leakedData: ['Email'],
      details: {
        'Email': 'g***@protonmail.com',
        'Leaked Fields': 'Email addresses only',
      },
      recommendations: [
        'Будьте бдительны к фишинговым письмам, маскирующимся под Dropbox',
        'Рекомендуется обновить пароль в целях профилактики',
      ],
      websiteUrl: 'https://www.dropbox.com',
    ),
    ThreatItem(
      id: 'kickstarter',
      serviceName: 'Kickstarter',
      leakDate: '18 июля 2024',
      severity: 'Warning',
      isResolved: true,
      leakedData: ['Email', 'Пароль (зашифрованный)'],
      details: {
        'Email': 'g***@protonmail.com',
        'Зашифрованный пароль': r'bcrypt$2a$10$xyz...',
      },
      recommendations: [
        'Пароль был зашифрован, но рекомендуется сменить его, если он не менялся с 2024 года',
      ],
      websiteUrl: 'https://www.kickstarter.com',
    ),
  ];
}
