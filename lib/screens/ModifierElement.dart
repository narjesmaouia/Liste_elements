// ignore: file_names
import 'package:flutter/material.dart';
import 'package:liste_elements/models/liste_element.dart';
import 'package:liste_elements/services/sqlDataBase.dart';

class ModifierElement extends StatefulWidget {
  final int? elementId;
  const ModifierElement({super.key, this.elementId});

  @override
  State<ModifierElement> createState() => _ModifierElementState();
}
class _ModifierElementState extends State<ModifierElement> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadElementData();
  }
  Future<void> _loadElementData() async {
    if (widget.elementId != null) {
      final element = await CruddataBase().getElementWithId(widget.elementId!);
      if (element != null) {
        setState(() {
          nomController.text = element.nom;
          descriptionController.text = element.description;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier un Element'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
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
              decoration: const InputDecoration(labelText: "Nom de l'Element"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description de l'Element"),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                final nom = nomController.text;
                final description = descriptionController.text;
                if (nom.isNotEmpty && description.isNotEmpty) {
                  final element = ListeElement(id: widget.elementId, nom: nom, description: description);
                  await CruddataBase().updateElement(element);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Element mis à jour avec succès')));
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez remplir tous les champs !')));
                }
              },
              child: const Text("Mettre à jour l'Element"),
            )
          ],
        ),
      ),
    );
  }
}
