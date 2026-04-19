import 'package:fe/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class CompletePage extends StatelessWidget {
  final log = Logger('CompletePage');

  CompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(painter: _ScanlinePainter()),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 40.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          _buildBadge(),

                          const SizedBox(height: 48),
                          _buildHeadlines(),

                          const SizedBox(height: 40),
                          _buildMessageCard(),

                          const SizedBox(height: 48),
                          _buildActionButton(context),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: AppColors.surfaceContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.terminal, color: Color(0xFFCCFF00)),
              const SizedBox(width: 16),
              const Text(
                'MISSION COMPLETE',
                style: TextStyle(
                  color: Color(0xFFCCFF00),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  fontFamily: 'Space Grotesk',
                ),
              ),
            ],
          ),
          const Icon(Icons.settings, color: Color(0xFF5A5E63)),
        ],
      ),
    );
  }

  Widget _buildBadge() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryFixedDim.withValues(alpha: 0.2),
              width: 4,
              style: BorderStyle.none,
            ),
          ),
        ),
        Transform.rotate(
          angle: 0.2,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              border: Border.all(color: AppColors.primaryContainer, width: 2),
            ),
            child: Transform.rotate(
              angle: -0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.verified_user,
                    color: AppColors.primary,
                    size: 64,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SECURED',
                    style: TextStyle(
                      color: AppColors.primaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeadlines() {
    return Column(
      children: [
        const Text(
          'MISSIONE\nCOMPIUTA',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primaryContainer,
            fontSize: 48,
            fontWeight: FontWeight.w900,
            height: 0.9,
            fontFamily: 'Space Grotesk',
            letterSpacing: -2,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          color: AppColors.primaryContainer,
          child: const Text(
            'SPOSO SALVATO // FUTURO ASSICURATO',
            style: TextStyle(
              color: AppColors.onPrimaryFixed,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        border: Border(
          left: BorderSide(color: AppColors.primaryFixedDim, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ottimo lavoro agenti. Avete superato ogni sfida e protetto l'obiettivo. Lo sposo è libero (per ora...). La missione sotterranea si conclude qui, ma la leggenda del vostro team rimarrà negli archivi.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.security,
                color: AppColors.primaryFixedDim.withValues(alpha: 0.6),
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(
                'DIGITAL ENCRYPTION VERIFIED // END OF LOG',
                style: TextStyle(
                  color: AppColors.primaryFixedDim.withValues(alpha: 0.6),
                  fontSize: 10,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Offset Shadow
          Positioned(
            bottom: -8,
            right: -8,
            child: Container(
              width: 250,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryFixedDim.withValues(alpha: 0.4),
                  width: 2,
                ),
              ),
            ),
          ),
          // Main Button
          Container(
            width: 250,
            height: 60,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Text(
              'TORNA ALLA HOME',
              style: TextStyle(
                color: AppColors.onPrimaryFixed,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCAFD00).withValues(alpha: 0.05)
      ..strokeWidth = 2;

    for (double i = 0; i < size.height; i += 4) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
