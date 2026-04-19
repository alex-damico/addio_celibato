import 'package:fe/main.dart';
import 'package:fe/models/task_create.dart';
import 'package:fe/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../app_colors.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final log = Logger('CreateTaskPage');
  final TextEditingController _contentController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    final content = _contentController.text.trim();
    if (content.isEmpty) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final create = TaskCreateDto(content: content);
      await getIt<TaskRepository>().save(create);
      log.info("Pegno creato con successo: $content");
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pegno creato con successo')),
        );
      }
    } catch (e, stackTrace) {
      log.severe("Errore durante il salvataggio del pegno", e, stackTrace);
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
          'CREA NUOVO PEGNO',
          style: themeData.textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DESCRIZIONE PEGNO',
              style: themeData.textTheme.labelSmall?.copyWith(
                color: AppColors.primary,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: 5,
              style: themeData.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Inserisci qui la descrizione...',
                filled: true,
                fillColor: AppColors.surfaceContainer,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.outlineVariant,
                    width: 2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimaryFixed,
                ),
                child: _isSaving
                    ? const CircularProgressIndicator(
                        color: AppColors.onPrimaryFixed,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.save),
                          const SizedBox(width: 12),
                          Text(
                            'SALVA PEGNO',
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
}
