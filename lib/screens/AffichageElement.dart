// ignore: file_names
import 'package:flutter/material.dart';
import 'package:liste_elements/models/liste_element.dart';
import 'package:liste_elements/screens/AjouterElement.dart';
import 'package:liste_elements/screens/ModifierElement.dart';
import 'package:liste_elements/services/sqlDataBase.dart';

class AffichageElement extends StatefulWidget {
  const AffichageElement({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AffichageElementState createState() => _AffichageElementState();
}

class _AffichageElementState extends State<AffichageElement> {
  late Future<List<ListeElement>> _future;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _future = CruddataBase().getListeElement();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des Elements"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 243, 33, 215),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: FutureBuilder<List<ListeElement>>(
        future: _future,
        builder: (context, AsyncSnapshot<List<ListeElement>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erreur de connexion"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Aucun element trouvé'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final element = snapshot.data![index];
                return ListTile(
                  title: Text(element.nom),
                  subtitle: Text(element.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ModifierElement(elementId: element.id),
                            ),
                          );
                          if (result != null && result is bool && result) {
                            _refreshData();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          if (element.id != null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirmation"),
                                  content: const Text(
                                      "Voulez-vous vraiment supprimer cet Element ?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); 
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await CruddataBase()
                                            .deleteElement(element.id!);
                                        _refreshData();
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context)
                                            .pop(); 
                                      },
                                      child: const Text("Supprimer"),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AjouterElement(),
            ),
          );
          if (result != null && result is bool && result) {
            _refreshData();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
