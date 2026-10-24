import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class VoiceAssistantScreen extends StatefulWidget {
  const VoiceAssistantScreen({super.key});
  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> {
  bool _listening = false;
  String _lastCommand = '';

  final _suggestions = [
    'Turn on the living room light',
    "What's the temperature?",
    'Turn off all devices',
  ];

  void _toggleListening() {
    setState(() => _listening = !_listening);
    if (_listening) {
      // MOCK: after 3s, simulate a recognized command
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
        setState(() {
          _listening = false;
          _lastCommand = 'Turn on the living room light';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CC Assistant')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            GestureDetector(
              onTap: _toggleListening,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _listening
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.15),
                  boxShadow: _listening
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 30,
                            spreadRadius: 8,
                          ),
                        ]
                      : [],
                ),
                child: Icon(Icons.mic,
                    size: 90,
                    color: _listening ? Colors.white : AppColors.primary),
              ),
            ),
            const SizedBox(height: 24),
            Text(_listening ? 'Listening...' : 'Tap to Speak',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            if (_lastCommand.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('You said: "$_lastCommand"',
                    style: const TextStyle(
                        fontSize: 16, color: AppColors.primary)),
              ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('You can say:',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 8),
                  ..._suggestions.map((s) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.circle,
                                size: 6, color: AppColors.textSecondary),
                            const SizedBox(width: 8),
                            Expanded(
                              child:
                                  Text(s, style: const TextStyle(fontSize: 15)),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
