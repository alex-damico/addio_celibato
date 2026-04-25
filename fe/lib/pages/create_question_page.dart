import 'package:addio_celibato/models/question_create.dart';
import 'package:addio_celibato/repositories/question_repository.dart';
import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../injection.dart';
import '../utils/logger.dart';

class CreateQuestionPage extends StatefulWidget {
  const CreateQuestionPage({super.key});

  @override
  State<CreateQuestionPage> createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
  final _log = AppLogger.get('CreateQuestionPage');

  final TextEditingController _introController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _introController.dispose();
    _contentController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _saveQuestion() async {
    final intro = _introController.text.trim();
    final content = _contentController.text.trim();
    final answer = _answerController.text.trim();

    if (content.isEmpty || answer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Domanda e Risposta sono obbligatorie')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final create = QuestionCreateDto(
        intro: intro,
        content: content,
        correctAnswer: answer,
      );
      await getIt<QuestionRepository>().save(create);
      _log.info("Domanda creata con successo");
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Domanda creata con successo')),
        );
      }
    } catch (e, stackTrace) {
      _log.severe("Errore durante il salvataggio della domanda", e, stackTrace);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore durante il salvataggio: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.headerBackground,
        elevation: 0,
        title: Text(
          'CREA NUOVA TAPPA',
          style: themeData.textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(themeData, 'INTRODUZIONE (OPZIONALE)'),
            const SizedBox(height: 8),
            _buildTextField(_introController, 'Inserisci l\'intro...', 2, themeData),
            const SizedBox(height: 24),
            _buildLabel(themeData, 'DOMANDA / ENIGMA'),
            const SizedBox(height: 8),
            _buildTextField(_contentController, 'Inserisci il testo della domanda...', 4, themeData),
            const SizedBox(height: 24),
            _buildLabel(themeData, 'RISPOSTA CORRETTA'),
            const SizedBox(height: 8),
            _buildTextField(_answerController, 'Inserisci la risposta...', 1, themeData),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimaryFixed,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: _isSaving
                    ? const CircularProgressIndicator(color: AppColors.onPrimaryFixed)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.save),
                          const SizedBox(width: 12),
                          Text(
                            'SALVA TAPPA',
                            style: themeData.textTheme.bodyMedium?.copyWith(
                              color: AppColors.onPrimaryFixed,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(ThemeData themeData, String text) {
    return Text(
      text,
      style: themeData.textTheme.labelSmall?.copyWith(
        color: AppColors.primary,
        letterSpacing: 3,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, int maxLines, ThemeData themeData) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: themeData.textTheme.bodyMedium?.copyWith(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.surfaceContainer,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.outlineVariant, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}
