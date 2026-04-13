import 'dart:ui';
import 'package:flutter/material.dart';
import '../app_colors.dart';

class HudDialog extends StatelessWidget {
  final Color accentColor;
  final String title;
  final String subtitle;
  final String message;
  final String? technicalCode;
  final String buttonText;
  final IconData icon;
  final VoidCallback onButtonPressed;
  final bool isSuccess;

  const HudDialog({
    super.key,
    required this.accentColor,
    required this.title,
    required this.subtitle,
    required this.message,
    this.technicalCode,
    required this.buttonText,
    required this.icon,
    required this.onButtonPressed,
    this.isSuccess = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: AppColors.background.withValues(alpha: 0.8)),
            ),
          ),
          Center(
            child: Container(
              width: 340,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                border: isSuccess 
                  ? Border(top: BorderSide(color: accentColor, width: 4))
                  : Border.all(color: accentColor.withValues(alpha: 0.3), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(alpha: isSuccess ? 0.15 : 0.3),
                    blurRadius: isSuccess ? 50 : 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isSuccess) _buildErrorHeader(),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        _buildIconArea(),
                        const SizedBox(height: 24),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: AppColors.hudTitle.copyWith(color: accentColor),
                        ),
                        if (isSuccess) ...[
                          const SizedBox(height: 8),
                          Container(
                            width: 48,
                            height: 4,
                            color: accentColor.withValues(alpha: 0.3),
                          ),
                        ],
                        const SizedBox(height: 24),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildActionButton(),
                        if (technicalCode != null) _buildFooter(),
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

  Widget _buildErrorHeader() {
    return Container(
      color: accentColor,
      padding: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning, color: Colors.black, size: 20),
          const SizedBox(width: 12),
          Text(title, style: AppColors.hudLabel.copyWith(color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildIconArea() {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.1),
      ),
      child: Center(
        child: Icon(icon, size: 64, color: accentColor),
      ),
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onButtonPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: isSuccess ? Colors.black : Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(buttonText, style: AppColors.hudLabel.copyWith(
              color: isSuccess ? Colors.black : Colors.white
            )),
            if (isSuccess) ...[
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 16),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            technicalCode!,
            style: const TextStyle(
              color: Colors.white24,
              fontSize: 8,
              letterSpacing: 2,
            ),
          ),
          Row(
            children: [
              Container(width: 4, height: 4, color: accentColor),
              const SizedBox(width: 4),
              Container(width: 4, height: 4, color: accentColor),
              const SizedBox(width: 4),
              Container(width: 16, height: 4, color: accentColor),
            ],
          ),
        ],
      ),
    );
  }
}
