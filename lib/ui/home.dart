import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_funcionario/root/pallet.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> funcionarios = [];
  int indice = 0;

  @override
  void initState() {
    super.initState();
    carregarMockupJSON();
  }

  Future<void> carregarMockupJSON() async {
    String dados =
        await rootBundle.loadString('assets/mockup/funcionarios.json');
    setState(() {
      funcionarios = json.decode(dados);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Funcionários")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.p1,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.p2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<dynamic>(
                isExpanded: true,
                underline: const SizedBox.shrink(),
                value: funcionarios.isNotEmpty ? funcionarios[indice] : null,
                items: funcionarios
                    .map(
                      (funcionario) => DropdownMenuItem<dynamic>(
                        value: funcionario,
                        child: Text(funcionario['nome']),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    indice = funcionarios.indexOf(value);
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            Text(
              funcionarios.isNotEmpty
                  ? funcionarios[indice]['nome']
                  : "Nome do funcionário",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 20),


            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.p2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
funcionarios.isNotEmpty && funcionarios[indice]['img'] != null
    ? Image.network(
        funcionarios[indice]['img'],
        width: 200,
        errorBuilder: (context, error, stackTrace) =>
            Image.asset('assets/icone.png', width: 200),
      )
    : Image.asset('assets/icone.png', width: 200),

                    const SizedBox(height: 10),


                    Text(
                      funcionarios.isNotEmpty
                          ? "Cargo: ${funcionarios[indice]['cargo']}"
                          : "Cargo",
                    ),

                    // SALÁRIO
                    Text(
                      funcionarios.isNotEmpty
                          ? "Salário: R\$ ${funcionarios[indice]['salario']}"
                          : "Salário",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: indice > 0
                      ? () => setState(() => indice--)
                      : null,
                  child: Text("Anterior"),
                ),
                ElevatedButton(
                  onPressed: indice < funcionarios.length - 1
                      ? () => setState(() => indice++)
                      : null,
                  child: Text("Próximo"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}