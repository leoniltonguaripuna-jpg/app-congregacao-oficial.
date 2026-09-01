
import 'package:flutter/material.dart';

void main() {
  runApp(const MeuAppCongregacao());
}

class MeuAppCongregacao extends StatelessWidget {
  const MeuAppCongregacao({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Território de Congregação',
      theme: ThemeData(
        fontFamily: 'Sans-Serif',
        scaffoldBackgroundColor: const Color(0xFFF2EFE9),
      ),
      home: const TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int abaSelecionada = 0;
  int menuInferiorIndex = 0;

  final List<Map<String, dynamic>> abas = [
    {'titulo': 'Territórios', 'icone': Icons.map},
    {'titulo': 'S Campo', 'icone': Icons.menu_book},
    {'titulo': 'Eventos', 'icone': Icons.calendar_month},
    {'titulo': 'Dirigentes', 'icone': Icons.person},
    {'titulo': 'T Publico', 'icone': Icons.store},
    {'titulo': 'L Testemunho', 'icone': Icons.collections_bookmark},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // PAINEL SUPERIOR (AZUL ESCURO)
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1E2D4A),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  // Título e Ícone do Cadeado
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        SizedBox(width: 24),
                        Text(
                          'Território de Congregação',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.lock, color: Colors.amber, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Barra de Abas Rolável
                  SizedBox(
                    height: 75,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: abas.length,
                      itemBuilder: (context, index) {
                        final isSelected = abaSelecionada == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              abaSelecionada = index;
                            });
                          },
                          child: Container(
                            width: 85,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(12),
                              border: isSelected
                                  ? Border.all(color: Colors.amber, width: 2)
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  abas[index]['icone'],
                                  color: const Color(0xFF334155),
                                  size: 22,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  abas[index]['titulo'],
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: const Color(0xFF334155),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ÁREA DE CONTEÚDO PRINCIPAL
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9E5DC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.arrow_back, color: Color(0xFF334155)),
                          const SizedBox(width: 8),
                          Text(
                            'T.2 - ST Terezinha 2',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E2D4A),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE1DDD3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.create_new_folder,
                              size: 48,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // MENU INFERIOR DE NAVEGAÇÃO
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: menuInferiorIndex,
        onTap: (index) {
          setState(() {
            menuInferiorIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1E2D4A),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Meu Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.email), label: 'Mensagens'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
        ],
      ),
    );
  }
}
