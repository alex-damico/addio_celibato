import 'package:addio_celibato/models/question.dart';
import 'package:addio_celibato/repositories/question_repository.dart';
import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../injection.dart';
import '../utils/logger.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final _log = AppLogger.get('QuestionsPage');

  List<QuestionDto> _questions = [];
  QuestionDto? _selectedQuestion;
  bool _isLoading = true;
  bool _isResolving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final questionsDto = await getIt<QuestionRepository>().getAll();
      setState(() {
        _questions = questionsDto.content;
        _isLoading = false;
      });
    } catch (e, stackTrace) {
      _log.severe("Errore durante il caricamento delle domande", e, stackTrace);
      setState(() {
        _errorMessage = "Errore durante il caricamento delle domande: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleQuestionStatus() async {
    if (_selectedQuestion == null) return;

    setState(() {
      _isResolving = true;
    });

    try {
      if (_selectedQuestion!.isResolved) {
        await getIt<QuestionRepository>().resetResolved(_selectedQuestion!.id);
      } else {
        await getIt<QuestionRepository>().setResolved(_selectedQuestion!.id);
      }
      await _loadQuestions();
      setState(() {
        _selectedQuestion = null;
      });
    } catch (e, stackTrace) {
      _log.severe("Errore durante l'aggiornamento della domanda", e, stackTrace);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Errore durante l'aggiornamento: $e")));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isResolving = false;
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
                    itemCount: _questions.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final question = _questions[index];
                      final isSelected = _selectedQuestion?.id == question.id;
                      return _buildQuestionItem(question, isSelected, themeData);
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
          const Icon(Icons.help_outline, color: AppColors.text),
          const SizedBox(width: 12),
          Text('DOMANDE DISPONIBILI', style: themeData.textTheme.displayLarge),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
          onPressed: () async {
            await Navigator.of(context).pushNamed('/admin/questions/create');
            _loadQuestions();
          },
        ),
        IconButton(
          icon: const Icon(Icons.refresh, color: AppColors.primary),
          onPressed: _loadQuestions,
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
                'SELEZIONA DOMANDA',
                style: themeData.textTheme.labelSmall?.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'DATASET_DOMANDE',
            style: themeData.textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionItem(QuestionDto question, bool isSelected, ThemeData themeData) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedQuestion = question;
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
              question.isResolved
                  ? Icons.check_circle
                  : (isSelected ? Icons.radio_button_checked : Icons.radio_button_off),
              color: question.isResolved
                  ? AppColors.tertiary
                  : (isSelected ? AppColors.primary : AppColors.outline),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DOMANDA ${question.position}',
                    style: themeData.textTheme.labelSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    question.content,
                    style: themeData.textTheme.bodyMedium?.copyWith(
                      color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.tertiary.withValues(alpha: 0.1),
                      border: Border.all(color: AppColors.tertiary.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      'RISPOSTA: ${question.correctAnswer}',
                      style: themeData.textTheme.labelSmall?.copyWith(
                        color: AppColors.tertiary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
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
    final bool isSelected = _selectedQuestion != null;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainer,
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected) ...[
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/admin/hints',
                    arguments: _selectedQuestion,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary, width: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'GESTISCI SUGGERIMENTI',
                      style: themeData.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.lightbulb_outline, size: 20, color: AppColors.primary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          SizedBox(
            width: double.infinity,
            height: 70,
            child: ElevatedButton(
              onPressed: (isSelected && !_isResolving) ? _toggleQuestionStatus : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedQuestion?.isResolved == true
                    ? AppColors.secondary
                    : AppColors.primary,
                foregroundColor: AppColors.onPrimaryFixed,
                disabledBackgroundColor: AppColors.outlineVariant,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                elevation: 0,
              ),
              child: _isResolving
                  ? const CircularProgressIndicator(color: AppColors.onPrimaryFixed)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _selectedQuestion?.isResolved == true
                              ? 'RESETTA STATO'
                              : 'RISOLVI DOMANDA',
                          style: themeData.textTheme.bodyMedium?.copyWith(
                            color: AppColors.onPrimaryFixed,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          _selectedQuestion?.isResolved == true
                              ? Icons.undo
                              : Icons.check,
                          size: 20,
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
