import 'package:fe/pages/question_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import '../app_colors.dart';
import '../service/admin_service.dart';

GetIt getIt = GetIt.instance;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final log = Logger('HomePage');

  @override
  Widget build(BuildContext context) {
    int secretCounter = 0;

    return Scaffold(
      appBar: _buildAppBar(Theme.of(context), secretCounter),
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

  PreferredSizeWidget _buildAppBar(ThemeData themaData, int secretCounter) {
    return AppBar(
      backgroundColor: AppColors.headerBackground,
      elevation: 0,
      title: Row(
        children: [
          const Icon(Icons.terminal, color: AppColors.text),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              secretCounter++;
              if (secretCounter == 5) {
                getIt<AdminService>().toggleAdmin();
                secretCounter = 0;
                log.info("Modalità Admin Attivata!");
              }
            },
            child: Text(
              'MISSION: ESCAPE',
              style: themaData.textTheme.displayLarge,
            ),
          ),
        ],
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
                Navigator.of(context ).push(
                  MaterialPageRoute(
                    builder: (context) => const QuestionPage(),
                  ),
                );
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
}
