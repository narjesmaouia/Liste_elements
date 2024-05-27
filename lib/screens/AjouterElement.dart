// ignore: file_names
import 'package:flutter/material.dart';
import 'package:liste_elements/models/liste_element.dart';
import 'package:liste_elements/services/sqlDataBase.dart';

class AjouterElement extends StatelessWidget {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController especeController = TextEditingController();
  AjouterElement({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un Element'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {},
          icon: const Icon(Icons.search)),
          IconButton(onPressed: () {},
          icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nomController,
              decoration: const InputDecoration(labelText: "Nom de l\'Element"),
            ),
            TextField(
              controller: especeController,
              decoration: const InputDecoration (labelText: "Description de l\'Element"),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(onPressed: () async {
              final nom = nomController.text;
              final description = especeController.text;
              if (nom.isNotEmpty && description.isNotEmpty) {
                final element = ListeElement(nom: nom, description: description);
                await CruddataBase().insertElement(element);
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Element ajouté avec succès')));
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez saisir les champs !')));
              }
            },
            child: const Text("Ajouter un Element"))
          ],
        ),
      ),
    );
  }
}