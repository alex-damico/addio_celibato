import 'package:addio_celibato/models/hint_create.dart';
import 'package:addio_celibato/models/question.dart';
import 'package:addio_celibato/repositories/hint_repository.dart';
import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../injection.dart';
import '../utils/logger.dart';

class CreateHintPage extends StatefulWidget {
  const CreateHintPage({super.key});

  @override
  State<CreateHintPage> createState() => _CreateHintPageState();
}

class _CreateHintPageState extends State<CreateHintPage> {
  final _log = AppLogger.get('CreateHintPage');

  final TextEditingController _contentController = TextEditingController();
  bool _isSaving = false;
  late QuestionDto _question;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is QuestionDto) {
        _question = args;
        _initialized = true;
      } else {
        _log.severe("QuestionDto non fornito agli argomenti della pagina");
      }
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveHint() async {
    final content = _contentController.text.trim();

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Il testo del suggerimento è obbligatorio')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final create = HintCreateDto(
        content: content,
        questionId: _question.id,
      );
      await getIt<HintRepository>().save(create);
      _log.info("Suggerimento creato con successo");
      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Suggerimento creato con successo')),
        );
      }
    } catch (e, stackTrace) {
      _log.severe("Errore durante il salvataggio del suggerimento", e, stackTrace);
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

    if (!_initialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.headerBackground,
        elevation: 0,
        title: Text(
          'AGGIUNGI SUGGERIMENTO',
          style: themeData.textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 48, height: 4, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'DOMANDA ${_question.position}',
                  style: themeData.textTheme.labelSmall?.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildLabel(themeData, 'TESTO SUGGERIMENTO'),
            const SizedBox(height: 8),
            _buildTextField(_contentController, 'Inserisci il testo...', 4, themeData),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveHint,
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
                            'SALVA SUGGERIMENTO',
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
