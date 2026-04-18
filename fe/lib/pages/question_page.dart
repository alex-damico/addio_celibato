import 'package:dio/dio.dart';
import 'package:fe/main.dart';
import 'package:fe/models/question.dart';
import 'package:fe/pages/complete_page.dart';
import 'package:fe/pages/task_page.dart';
import 'package:fe/repositories/hint_repository.dart';
import 'package:fe/repositories/question_repository.dart';
import 'package:fe/widgets/access_status_dialog.dart';
import 'package:fe/widgets/hint_dialog.dart';
import 'package:fe/service/admin_service.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../app_colors.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final log = Logger('QuestionPage');

  QuestionDto? _question;
  bool _isLoading = true;
  String? _errorMessage;
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadQuestion();
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _loadQuestion() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final question = await getIt<QuestionRepository>().getFirstPosition();
      setState(() {
        _question = question;
        _isLoading = false;
      });
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => CompletePage()),
          );
        }
      } else {
        setState(() {
          _errorMessage = "Errore di rete: ${e.message}";
          _isLoading = false;
        });
      }
    } catch (e, stackTrace) {
      log.severe("Errore durante il caricamento della domanda", e, stackTrace);
      setState(() {
        _errorMessage = "Errore inatteso: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _checkAnswer() async {
    if (_question == null) return;

    final userAnswer = _answerController.text.trim().toLowerCase();
    final correctAnswer = _question!.correctAnswer.trim().toLowerCase();

    if (userAnswer == correctAnswer) {
      try {
        await getIt<QuestionRepository>().setResolved(_question!.id);
        if (mounted) {
          _showAccessGrantedDialog();
        }
      } catch (e, stackTrace) {
        log.severe("Errore durante il salvataggio della risposta", e, stackTrace);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Errore durante il salvataggio: $e")),
          );
        }
      }
    } else {
      _showAccessDeniedDialog();
    }
  }

  void _showAccessGrantedDialog() {
    final bool isLast = _question?.isLast ?? false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AccessStatusDialog(
        accentColor: AppColors.tertiary,
        title: 'ACCESS GRANTED',
        subtitle: 'Codice Corretto!',
        message: isLast
            ? 'Missione completata. L\'obiettivo è al sicuro.'
            : 'Procedi al prossimo settore. Il segnale si sta rafforzando.',
        technicalCode: 'SEC-AUTH-0492',
        buttonText: isLast ? 'FINE MISSIONE' : 'PROSSIMO ENIGMA',
        icon: Icons.check_circle,
        onButtonPressed: () {
          Navigator.of(context).pop();
          if (isLast) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => CompletePage()),
            );
          } else {
            _answerController.clear();
            _loadQuestion();
          }
        },
      ),
    );
  }

  void _showAccessDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AccessStatusDialog(
        accentColor: AppColors.secondary,
        title: 'ACCESS DENIED',
        subtitle: 'Codice Errato',
        message: 'Ritenta, l\'obiettivo è ancora protetto.',
        buttonText: 'RIPROVA',
        icon: Icons.gpp_bad,
        isSuccess: false,
        onButtonPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _showIntelDialog() async {
    if (_question == null) return;

    try {
      final hint = await getIt<HintRepository>().getFirstHintByQuestionId(_question!.id);

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => HintDialog(
            hintId: hint.id,
            hint: hint.content,
            onReceived: () async {
              await getIt<HintRepository>().setHintUnlocked(hint.id);
              if (mounted) Navigator.of(context).pop();
            },
          ),
        );
      }
    } on DioException catch (e) {
      if (mounted) {
        String message = "Impossibile recuperare l'aiuto: $e";
        if (e.response?.statusCode == 404) {
          message = "Hai esaurito tutti gli aiuti disponibili per questo obiettivo.";
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e, stackTrace) {
      log.severe("Errore durante il recupero dell'aiuto", e, stackTrace);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Impossibile recuperare l'aiuto: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Text("Error: $_errorMessage", style: const TextStyle(color: Colors.red)),
        ),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(themeData),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(themeData),
                    const SizedBox(height: 24),
                    _buildVisualClue(themeData),
                    const SizedBox(height: 16),
                    _buildTextDescription(themeData),
                    const SizedBox(height: 32),
                    _buildTerminalInput(themeData),
                    const SizedBox(height: 32),
                    _buildActionButtons(themeData),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: getIt<AdminService>(),
        builder: (context, child) {
          return getIt<AdminService>().isAdmin
              ? _buildBottomNavBar(themeData)
              : const SizedBox.shrink();
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData themeData) {
    return AppBar(
      backgroundColor: AppColors.headerBackground,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.terminal, color: AppColors.text),
          const SizedBox(width: 12),
          Text(
            'MISSION: ESCAPE',
            style: themeData.textTheme.displayLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData themeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 48, height: 4, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              'CURRENT OBJECTIVE',
              style: themeData.textTheme.labelSmall?.copyWith(
                color: AppColors.primary,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'ENIGMA #${_question?.position ?? "?"}',
          style: themeData.textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontSize: 48,
          ),
        ),
      ],
    );
  }

  Widget _buildVisualClue(ThemeData themeData) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColors.primary, width: 4),
        ),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]),
                child: Opacity(
                  opacity: 0.6,
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuA4lLxrGpStKlG0cWYyDIPzZPdZj6QTCV9rKNjW-ju7CjKXWSdvuG6JOskf9s7lbpIwG-HXyxWAMZNThIC8QhRr0IXukaxu3YRZFraysLxtgrhjtPI8bssW326U2G0QlLLcd6hi3N8tpPFg7JBbH7GOePOd9_FqnFPFGi4-Rb_aYQqsaNayGj1jrJGzvYxEBm0mIO7oFb_-pesuvKzm07IjdweIiAUVGh40Qb9dTQa1KYPLPNZIw4FM1tP5dmWcqxM4pB6VunkzjBwp',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: ScanlinePainter(),
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: AppColors.surfaceContainerHighest,
                child: Text(
                  'FILE_ID: 9942-X',
                  style: themeData.textTheme.labelSmall?.copyWith(
                    color: AppColors.primaryFixedDim,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextDescription(ThemeData themeData) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainer,
        border: Border(
          bottom: BorderSide(color: AppColors.outlineVariant, width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INTRODUZIONE',
            style: themeData.textTheme.displayLarge?.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _question?.intro ?? 'Caricamento domanda...',
            style: themeData.textTheme.bodyMedium?.copyWith(
              color: AppColors.onSurfaceVariant,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'DOMANDA',
            style: themeData.textTheme.labelSmall?.copyWith(
              color: AppColors.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _question?.content ?? 'Caricamento domanda...',
            style: themeData.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerminalInput(ThemeData themeData) {
    return TextField(
      controller: _answerController,
      style: themeData.textTheme.displayLarge?.copyWith(
        color: AppColors.tertiary,
        fontSize: 24,
      ),
      cursorColor: AppColors.tertiary,
      decoration: InputDecoration(
        hintText: 'INSERISCI RISPOSTA...',
        hintStyle: themeData.textTheme.displayLarge?.copyWith(
          color: AppColors.outlineVariant,
          fontSize: 24,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.outlineVariant, width: 2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.tertiary, width: 2),
        ),
        suffixIcon: const Icon(
          Icons.keyboard_arrow_right,
          color: AppColors.outlineVariant,
        ),
      ),
    );
  }

  Widget _buildActionButtons(ThemeData themeData) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 70,
          child: ElevatedButton(
            onPressed: _checkAnswer,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimaryFixed,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CONFERMA RISPOSTA',
                  style: themeData.textTheme.bodyMedium?.copyWith(
                    color: AppColors.onPrimaryFixed,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.lock_open, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 70,
          child: OutlinedButton(
            onPressed: _showIntelDialog,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
              backgroundColor: AppColors.surfaceContainerHighest,
              foregroundColor: AppColors.primaryFixedDim,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lightbulb_outline, size: 20),
                const SizedBox(width: 8),
                Text(
                  'RICHIEDI AIUTO',
                  style: themeData.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryFixedDim,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(ThemeData themeData) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainer,
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        children: [
          _buildNavItem(Icons.description, 'PEGNI', false, themeData, () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const TaskPage()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, ThemeData themeData, VoidCallback onTap) {
    final activeColor = AppColors.background;
    final inactiveColor = AppColors.primary.withValues(alpha: 0.6);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: isActive ? AppColors.text : Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? activeColor : inactiveColor,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: themeData.textTheme.labelSmall?.copyWith(
                  color: isActive ? activeColor : inactiveColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.text.withValues(alpha:  0.05)
      ..strokeWidth = 2.0;

    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
