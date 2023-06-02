// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactPage extends StatelessWidget {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  ContactPage({super.key});

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    // Afficher une notification ou un message pour informer l'utilisateur que le numéro a été copié dans le presse-papier.
    // Vous pouvez utiliser un package comme 'fluttertoast' pour cela.
  }

  void submitForm() {
    String subject = subjectController.text;
    String message = messageController.text;

    // Envoyer le sujet et le message à votre backend ou effectuer d'autres actions nécessaires.
    // Vous pouvez utiliser un package comme 'http' pour effectuer des appels API.

    // Réinitialiser les champs du formulaire après soumission.
    subjectController.clear();
    messageController.clear();

    // Afficher une notification ou un message pour informer l'utilisateur que sa réclamation a été soumise avec succès.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactez-nous'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Numéro de téléphone'),
              subtitle: const Text('+1234567890'),
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  copyToClipboard('+1234567890');
                },
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(
                labelText: 'Sujet',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: messageController,
              decoration: const InputDecoration(
                labelText: 'Message',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Soumettre la réclamation'),
              onPressed: () {
                submitForm();
              },
            ),
          ],
        ),
      ),
    );
  }
}
