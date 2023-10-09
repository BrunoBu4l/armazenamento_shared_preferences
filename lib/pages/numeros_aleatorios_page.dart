import 'dart:math';
//usando shared_preferences
import 'package:flutter/material.dart';
import 'package:shared_storage/services/app_storage_service.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({Key? key}) : super(key: key);

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  int numeroGerado = 0;
  int quantidadeCliques = 0;
  AppStorageService storage = AppStorageService();

  @override
  void initState() {
    //initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    numeroGerado = await storage.getNumeroAleatorio();
    quantidadeCliques = await storage.getQuantidadeCliques();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gerador de números aleatórios"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numeroGerado == 0
                    ? "Nenhum número gerado"
                    : numeroGerado.toString(),
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                quantidadeCliques == 0
                    ? "Nenhum clique efetuado"
                    : quantidadeCliques.toString(),
                style: const TextStyle(fontSize: 22),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(1000);
              quantidadeCliques = quantidadeCliques + 1;
            });
            await storage.setNumeroAleatorio(numeroGerado);
            await storage.setQuantidadeCliques(quantidadeCliques);
          },
        ),
      ),
    );
  }
}
