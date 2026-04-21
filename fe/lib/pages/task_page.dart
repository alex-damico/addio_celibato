import 'package:addio_celibato/main.dart';
import 'package:addio_celibato/models/task.dart';
import 'package:addio_celibato/repositories/task_repository.dart';
import 'package:addio_celibato/widgets/access_status_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../app_colors.dart';
import '../injection.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final log = Logger('TaskPage');

  List<TaskDto> _tasks = [];
  TaskDto? _selectedTask;
  bool _isLoading = true;
  bool _isSending = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final tasksDto = await getIt<TaskRepository>().getAll();
      setState(() {
        _tasks = tasksDto.content;
        _isLoading = false;
      });
    } catch (e, stackTrace) {
      log.severe("Errore durante il caricamento dei pegni", e, stackTrace);
      setState(() {
        _errorMessage = "Errore durante il caricamento dei pegni: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _sendTask() async {
    if (_selectedTask == null) return;

    setState(() {
      _isSending = true;
    });

    try {
      await getIt<TaskRepository>().sendTask(_selectedTask!.id);
      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e, stackTrace) {
      log.severe("Errore durante l'invio del pegno", e, stackTrace);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Errore durante l'invio: $e")));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AccessStatusDialog(
        accentColor: AppColors.tertiary,
        title: 'TASK SENT',
        subtitle: 'Pegno Inviato',
        message: 'Il pegno è stato assegnato con successo.',
        technicalCode: 'TASK-AUTH-OK',
        buttonText: 'OK',
        icon: Icons.check_circle,
        onButtonPressed: () {
          Navigator.of(context).pop();
          setState(() {
            _selectedTask = null;
          });
        },
      ),
    );
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
                    itemCount: _tasks.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      final isSelected = _selectedTask?.id == task.id;
                      return _buildTaskItem(task, isSelected, themeData);
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
          const Icon(Icons.description, color: AppColors.text),
          const SizedBox(width: 12),
          Text('PEGNI DISPONIBILI', style: themeData.textTheme.displayLarge),
        ],
      ),
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
                'SELEZIONA PEGNO',
                style: themeData.textTheme.labelSmall?.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'DATASET_PEGNI',
            style: themeData.textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(TaskDto task, bool isSelected, ThemeData themeData) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTask = task;
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
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.outline,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                task.content,
                style: themeData.textTheme.bodyMedium?.copyWith(
                  color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction(ThemeData themeData) {
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
          onPressed: (_selectedTask == null || _isSending) ? null : _sendTask,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimaryFixed,
            disabledBackgroundColor: AppColors.outlineVariant,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            elevation: 0,
          ),
          child: _isSending
              ? const CircularProgressIndicator(color: AppColors.onPrimaryFixed)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'INVIA PEGNO',
                      style: themeData.textTheme.bodyMedium?.copyWith(
                        color: AppColors.onPrimaryFixed,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.send, size: 20),
                  ],
                ),
        ),
      ),
    );
  }
}
