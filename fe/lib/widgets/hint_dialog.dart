import 'dart:ui';
import 'package:flutter/material.dart';
import '../app_colors.dart';

class HintDialog extends StatelessWidget {
  final int hintId;
  final String hint;
  final VoidCallback onReceived;

  const HintDialog({
    super.key,
    required this.hintId,
    required this.hint,
    required this.onReceived,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: AppColors.background.withValues(alpha: 0.8),
              ),
            ),
          ),
          
          Center(
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 500),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 50,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  _buildContent(),
                  _buildFooterDecoration(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: Color(0x33F3FFCA),
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'RICHIESTA INTEL',
                style: AppColors.hudLabel.copyWith(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            color: AppColors.primary,
            child: Text(
              'ACTIVE',
              style: TextStyle(
                color: AppColors.background,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTacticalBox(),
          const SizedBox(height: 32),
          _buildMetadataSection(),
          const SizedBox(height: 32),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildTacticalBox() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Color(0xFF111417),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'DECRYPTED MESSAGE',
                    style: TextStyle(
                      color: AppColors.primaryFixedDim.withValues(alpha: 0.5),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '"$hint"',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        // Corner Accents
        _buildCorner(top: 0, left: 0),
        _buildCorner(top: 0, right: 0, rotation: 1),
        _buildCorner(bottom: 0, left: 0, rotation: 3),
        _buildCorner(bottom: 0, right: 0, rotation: 2),
      ],
    );
  }

  Widget _buildCorner({
    double? top,
    double? left,
    double? right,
    double? bottom,
    int rotation = 0,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: RotatedBox(
        quarterTurns: rotation,
        child: Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.primary, width: 2),
              left: BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.surfaceContainerHighest.withValues(alpha: 0.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.terminal,
            color: AppColors.tertiary,
            size: 20,
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'SUGGERIMENTO SBLOCCATO TRAMITE ACCESSO DI EMERGENZA. IL CONSUMO DI QUESTO INTEL NON INFLUISCE SUL PUNTEGGIO FINALE DELLA MISSIONE.',
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: onReceived,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.background,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'RICEVUTO',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontSize: 16,
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterDecoration() {
    return Container(
      height: 8,
      width: double.infinity,
      color: const Color(0xFF000000), // surface-container-lowest
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(color: AppColors.primary.withValues(alpha: 0.4)),
          ),
          Expanded(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
