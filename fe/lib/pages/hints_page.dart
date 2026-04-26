import 'package:addio_celibato/models/hint.dart';
import 'package:addio_celibato/models/question.dart';
import 'package:addio_celibato/repositories/hint_repository.dart';
import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../injection.dart';
import '../utils/logger.dart';

class HintsPage extends StatefulWidget {
  const HintsPage({super.key});

  @override
  State<HintsPage> createState() => _HintsPageState();
}

class _HintsPageState extends State<HintsPage> {
  final _log = AppLogger.get('HintsPage');

  List<HintDto> _hints = [];
  HintDto? _selectedHint;
  bool _isLoading = true;
  bool _isUnlocking = false;
  String? _errorMessage;
  late QuestionDto _question;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is QuestionDto) {
        _question = args;
        _loadHints();
        _initialized = true;
      } else {
        setState(() {
          _errorMessage = "Errore: QuestionDto non fornito";
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadHints() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final hintsDto = await getIt<HintRepository>().getAllForQuestion(_question.id);
      setState(() {
        _hints = hintsDto.content;
        _isLoading = false;
      });
    } catch (e, stackTrace) {
      _log.severe("Errore durante il caricamento dei suggerimenti", e, stackTrace);
      setState(() {
        _errorMessage = "Errore durante il caricamento dei suggerimenti: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleHintStatus() async {
    if (_selectedHint == null) return;

    setState(() {
      _isUnlocking = true;
    });

    try {
      if (_selectedHint!.isUnlocked) {
        await getIt<HintRepository>().resetHintUnlocked(_selectedHint!.id);
      } else {
        await getIt<HintRepository>().setHintUnlocked(_selectedHint!.id);
      }
      await _loadHints();
      setState(() {
        _selectedHint = null;
      });
    } catch (e, stackTrace) {
      _log.severe("Errore durante l'aggiornamento del suggerimento", e, stackTrace);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Errore durante l'aggiornamento: $e")));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUnlocking = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(themeData),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : _errorMessage != null
          ? Center(
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            )
          : Column(
              children: [
                _buildHeader(themeData),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: _hints.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final hint = _hints[index];
                      final isSelected = _selectedHint?.id == hint.id;
                      return _buildHintItem(hint, isSelected, themeData);
                    },
                  ),
                ),
                _buildBottomAction(themeData),
              ],
            ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData themeData) {
    return AppBar(
      backgroundColor: AppColors.headerBackground,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lightbulb_outline, color: AppColors.text),
          const SizedBox(width: 12),
          Text('SUGGERIMENTI', style: themeData.textTheme.displayLarge),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
          onPressed: () async {
            final result = await Navigator.of(context).pushNamed(
              '/admin/hints/create',
              arguments: _question,
            );
            if (result == true) {
              _loadHints();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.refresh, color: AppColors.primary),
          onPressed: _loadHints,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildHeader(ThemeData themeData) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 48, height: 4, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'DOMANDA ${_initialized ? _question.position : "?"}',
                style: themeData.textTheme.labelSmall?.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'DATASET_HINTS',
            style: themeData.textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHintItem(HintDto hint, bool isSelected, ThemeData themeData) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedHint = hint;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.surfaceContainer,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outlineVariant,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              hint.isUnlocked ? Icons.lock : Icons.lock_open,
              color: hint.isUnlocked
                  ? AppColors.tertiary
                  : (isSelected ? AppColors.primary : AppColors.outline),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SUGGERIMENTO ${hint.position}',
                    style: themeData.textTheme.labelSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hint.content,
                    style: themeData.textTheme.bodyMedium?.copyWith(
                      color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction(ThemeData themeData) {
    final bool isSelected = _selectedHint != null;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainer,
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: ElevatedButton(
          onPressed: (isSelected && !_isUnlocking) ? _toggleHintStatus : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedHint?.isUnlocked == true
                ? AppColors.secondary
                : AppColors.primary,
            foregroundColor: AppColors.onPrimaryFixed,
            disabledBackgroundColor: AppColors.outlineVariant,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            elevation: 0,
          ),
          child: _isUnlocking
              ? const CircularProgressIndicator(color: AppColors.onPrimaryFixed)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _selectedHint?.isUnlocked == true
                          ? 'RESETTA STATO'
                          : 'SBLOCCA SUGGERIMENTO',
                      style: themeData.textTheme.bodyMedium?.copyWith(
                        color: AppColors.onPrimaryFixed,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      _selectedHint?.isUnlocked == true
                          ? Icons.undo
                          : Icons.lock_open,
                      size: 20,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
