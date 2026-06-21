import 'package:addio_celibato/utils/logger.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../injection.dart';
import '../service/admin_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _log = AppLogger.get('HomePage');
  int _secretCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(Theme.of(context)),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                _buildStatusTag(Theme.of(context)),
                const SizedBox(height: 32),
                _buildTitle(Theme.of(context)),
                const SizedBox(height: 40),
                _buildDescriptionBox(Theme.of(context)),
                const SizedBox(height: 48),
                _buildActionButtons(Theme.of(context)),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildFooter(Theme.of(context)),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData themaData) {
    return AppBar(
      backgroundColor: AppColors.headerBackground,
      elevation: 0,
      title: ListenableBuilder(
        listenable: getIt<AdminService>(),
        builder: (context, child) {
          final isAdmin = getIt<AdminService>().isAdmin;
          return Row(
            children: [
              Icon(
                Icons.terminal,
                color: isAdmin ? AppColors.secondary : AppColors.text,
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  _secretCounter++;
                  if (_secretCounter == 5) {
                    _secretCounter = 0;
                    if (isAdmin) {
                      getIt<AdminService>().toggleAdmin();
                      _log.info("Modalità Admin Disattivata!");
                    } else {
                      _showAdminPasswordDialog(context);
                    }
                  }
                },
                child: Text(
                  'MISSION: ESCAPE',
                  style: themaData.textTheme.displayLarge?.copyWith(
                    color: isAdmin ? AppColors.secondary : AppColors.text,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      actions: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(right: 24),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(
                color: themaData.colorScheme.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              'AUTH: VERIFIED',
              style: themaData.textTheme.labelSmall,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusTag(ThemeData themaData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: themaData.colorScheme.secondary.withValues(alpha: 0.1),
        border: Border.all(
          color: themaData.colorScheme.secondary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        'STATUS: CLASSIFICATO',
        style: themaData.textTheme.labelMedium?.copyWith(
          color: themaData.colorScheme.secondary,
        ),
      ),
    );
  }

  Widget _buildTitle(ThemeData themaData) {
    return Column(
      children: [
        Text(
          'MISSION:\n SPOSO! 😂',
          textAlign: TextAlign.center,
          style: themaData.textTheme.labelLarge?.copyWith(
            color: themaData.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Container(width: 80, height: 4, color: themaData.colorScheme.primary),
      ],
    );
  }

  Widget _buildDescriptionBox(ThemeData themaData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: themaData.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
              children: [
                const TextSpan(text: "Missione compromessa. "),
                TextSpan(
                  text: "Sposo abbandonato a se stesso. \n\n",
                  style: themaData.textTheme.bodyMedium?.copyWith(
                    color: themaData.colorScheme.primary,
                  ),
                ),
                const TextSpan(
                  text:
                      "Un consiglio: gli alleati sono come le ombre, possono illuminarvi il cammino o trascinarvi nel buio.",
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.location_on, size: 14, color: Colors.white70),
              Text(
                " BUNKER X-09  ",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.priority_high, size: 14, color: Colors.white70),
              Text(
                " PRIORITÀ ALFA",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData themaData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 70,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/question');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: themaData.colorScheme.primaryContainer,
                foregroundColor: themaData.colorScheme.onPrimary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'INIZIA MISSIONE',
                    style: themaData.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.keyboard_double_arrow_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(ThemeData themaData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        border: const Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'GRID: 45.4642° N, 9.1900° E',
            style: TextStyle(fontSize: 9, letterSpacing: 2),
          ),
        ],
      ),
    );
  }

  void _showAdminPasswordDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text(
            'ACCESSO AUTORIZZATO',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: controller,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'PASSWORD DI SISTEMA',
              border: OutlineInputBorder(),
            ),
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            const SizedBox(width: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'ANNULLA',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.outlineVariant,
                    ),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                if (controller.text == 'sposo2026') {
                  getIt<AdminService>().toggleAdmin();
                  _log.info("Modalità Admin Attivata!");
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('ACCESSO NEGATO: Password Errata'),
                    ),
                  );
                }
              },
              child: Text(
                'LOG IN',
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: AppColors.background),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
