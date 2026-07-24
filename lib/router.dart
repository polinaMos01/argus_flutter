import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/threat_item.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/restore_screen.dart';
import 'screens/auth/email_confirm_screen.dart';
import 'widgets/main_layout.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/checks/all_checks_screen.dart';
import 'screens/checks/email_check_screen.dart';
import 'screens/checks/email_check_result_screen.dart';
import 'screens/checks/phone_check_screen.dart';
import 'screens/checks/phone_check_result_screen.dart';
import 'screens/checks/file_check_screen.dart';
import 'screens/checks/file_check_result_screen.dart';
import 'screens/checks/link_check_screen.dart';
import 'screens/checks/link_check_result_screen.dart';
import 'screens/profile/profile_settings_screen.dart';
import 'screens/profile/edit_profile_screen.dart';
import 'screens/profile/app_settings_screen.dart';
import 'screens/profile/devices_screen.dart';
import 'screens/profile/change_password_screen.dart';
import 'screens/profile/backup_codes_screen.dart';
import 'screens/profile/payment_methods_screen.dart';
import 'screens/profile/add_card_screen.dart';
import 'screens/profile/payment_history_screen.dart';
import 'screens/profile/receipt_detail_screen.dart';
import 'screens/profile/support_screen.dart';
import 'screens/profile/about_app_screen.dart';
import 'screens/tools/data_exposure_screen.dart';
import 'screens/tools/password_strength_screen.dart';
import 'screens/tools/password_check_screen.dart';
import 'screens/threats/threats_list_screen.dart';
import 'screens/threats/threat_detail_screen.dart';
import 'screens/tools/cyber_advisor_screen.dart';
import 'screens/tools/password_center_screen.dart';
import 'screens/tools/weekly_report_screen.dart';
import 'screens/premium/tariffs_screen.dart';
import 'screens/notifications/all_notifications_screen.dart';
import 'screens/notifications/notifications_screen.dart';
import 'screens/security/security_score_screen.dart';
import 'screens/profile/security_screen.dart';

CustomTransitionPage<T> _buildPageTransition<T>(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 180),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
        child: child,
      );
    },
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => _buildPageTransition(context, state, const SplashScreen()),
    ),
    GoRoute(
      path: '/welcome',
      pageBuilder: (context, state) => _buildPageTransition(context, state, const WelcomeScreen()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => _buildPageTransition(context, state, const LoginScreen()),
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) => _buildPageTransition(context, state, const RegisterScreen()),
    ),
    GoRoute(
      path: '/restore',
      pageBuilder: (context, state) => _buildPageTransition(context, state, const RestoreScreen()),
    ),
    GoRoute(
      path: '/email-confirm',
      pageBuilder: (context, state) {
        final email = state.extra as String? ?? '';
        return _buildPageTransition(context, state, EmailConfirmScreen(email: email));
      },
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(
          currentPath: state.uri.path,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const DashboardScreen()),
        ),
        GoRoute(
          path: '/checks',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const AllChecksScreen()),
        ),
        GoRoute(
          path: '/email-check',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const EmailCheckScreen()),
        ),
        GoRoute(
          path: '/email-check-result',
          pageBuilder: (context, state) {
            final email = state.extra as String? ?? 'alex@example.com';
            return _buildPageTransition(context, state, EmailCheckResultScreen(email: email));
          },
        ),
        GoRoute(
          path: '/phone-check',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const PhoneCheckScreen()),
        ),
        GoRoute(
          path: '/phone-check-result',
          pageBuilder: (context, state) {
            final phone = state.extra as String? ?? '+7 999 123-45-67';
            return _buildPageTransition(context, state, PhoneCheckResultScreen(phone: phone));
          },
        ),
        GoRoute(
          path: '/file-check',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const FileCheckScreen()),
        ),
        GoRoute(
          path: '/file-check-result',
          pageBuilder: (context, state) {
            final fileName = state.extra as String? ?? 'file.pdf';
            return _buildPageTransition(context, state, FileCheckResultScreen(fileName: fileName));
          },
        ),
        GoRoute(
          path: '/link-check',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const LinkCheckScreen()),
        ),
        GoRoute(
          path: '/link-check-result',
          pageBuilder: (context, state) {
            final link = state.extra as String? ?? 'https://example.com';
            return _buildPageTransition(context, state, LinkCheckResultScreen(link: link));
          },
        ),
        GoRoute(
          path: '/password-check',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const PasswordCheckScreen()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const ProfileSettingsScreen()),
        ),
        GoRoute(
          path: '/profile/edit',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const EditProfileScreen()),
        ),
        GoRoute(
          path: '/profile/app-settings',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const AppSettingsScreen()),
        ),
        GoRoute(
          path: '/profile/active-sessions',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const DevicesScreen()),
        ),
        GoRoute(
          path: '/profile/change-password',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const ChangePasswordScreen()),
        ),
        GoRoute(
          path: '/profile/backup-codes',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const BackupCodesScreen()),
        ),
        GoRoute(
          path: '/profile/payment-methods',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const PaymentMethodsScreen()),
        ),
        GoRoute(
          path: '/profile/add-card',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const AddCardScreen()),
        ),
        GoRoute(
          path: '/profile/payment-history',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const PaymentHistoryScreen()),
        ),
        GoRoute(
          path: '/profile/payment-receipt',
          pageBuilder: (context, state) {
            final txn = state.extra as PaymentTransaction?;
            return _buildPageTransition(
              context,
              state,
              ReceiptDetailScreen(
                title: txn?.title ?? 'Продление подписки Premium',
                date: txn?.date ?? '15 мая 2025 г., 14:30',
                amount: txn?.amount ?? '299 ₽',
                status: txn?.status ?? 'Успешно',
                isSuccess: txn?.isSuccess ?? true,
              ),
            );
          },
        ),
        GoRoute(
          path: '/profile/support',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const SupportScreen()),
        ),
        GoRoute(
          path: '/profile/about',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const AboutAppScreen()),
        ),
        GoRoute(
          path: '/monitoring',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const DataExposureScreen()),
        ),
        GoRoute(
          path: '/threats',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const ThreatsListScreen()),
        ),
        GoRoute(
          path: '/threat-detail',
          pageBuilder: (context, state) {
            final String? titleParam = state.uri.queryParameters['title'] ?? (state.extra is String ? state.extra as String : null);
            final ThreatItem? threat = state.extra is ThreatItem ? state.extra as ThreatItem : null;
            return _buildPageTransition(
              context,
              state,
              ThreatDetailScreen(threat: threat, titleParam: titleParam),
            );
          },
        ),
        GoRoute(
          path: '/advisor',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const CyberAdvisorScreen()),
        ),
        GoRoute(
          path: '/password-center',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const PasswordCenterScreen()),
        ),
        GoRoute(
          path: '/password-strength',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const PasswordStrengthScreen()),
        ),
        GoRoute(
          path: '/password-check',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const PasswordCheckScreen()),
        ),
        GoRoute(
          path: '/weekly-report',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const WeeklyReportScreen()),
        ),
        GoRoute(
          path: '/tariffs',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const TariffsScreen()),
        ),
        GoRoute(
          path: '/notifications',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const AllNotificationsScreen()),
        ),
        GoRoute(
          path: '/notifications/settings',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const NotificationsScreen()),
        ),
        GoRoute(
          path: '/security-score',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const SecurityScoreScreen()),
        ),
        GoRoute(
          path: '/profile/security',
          pageBuilder: (context, state) => _buildPageTransition(context, state, const SecurityScreen()),
        ),
      ],
    ),
  ],
);
