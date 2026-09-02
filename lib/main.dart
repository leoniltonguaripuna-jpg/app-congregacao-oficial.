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
        primaryColor: const Color(0xFF1E2D4A),
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
    {'titulo': 'S. Campo', 'icone': Icons.menu_book},
    {'titulo': 'Eventos', 'icone': Icons.calendar_month},
    {'titulo': 'Dirigentes', 'icone': Icons.person},
    {'titulo': 'T. Público', 'icone': Icons.store},
    {'titulo': 'L. Testemunho', 'icone': Icons.collections_bookmark},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Painel Superior (Header)
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1E2D4A),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        SizedBox(width: 24),
                        Text(
                          'Gestão de Congregação',
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

                  // Navegação das Abas Superiores
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
                            width: 90,
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

            // Conteúdo Dinâmico com base na aba escolhida
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _construirConteudoAba(),
              ),
            ),
          ],
        ),
      ),

      // Menu Inferior
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.email), label: 'Avisos'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }

  Widget _construirConteudoAba() {
    switch (abaSelecionada) {
      case 0:
        return _buildAbaTerritorios();
      case 1:
        return _buildAbaServicoCampo();
      case 2:
        return _buildAbaEventos();
      case 3:
        return _buildAbaDirigentes();
      case 4:
        return _buildAbaTestemunhoPublico();
      case 5:
        return _buildAbaLivretoTestemunho();
      default:
        return _buildAbaTerritorios();
    }
  }

  // 1. ABA TERRITÓRIOS
  Widget _buildAbaTerritorios() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Territórios Designados',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E2D4A)),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView(
            children: [
              _itemCartaoTerritorio('T.01 - Centro Norte', 'Trabalhado há 12 dias', true),
              _itemCartaoTerritorio('T.02 - ST Terezinha 2', 'Em andamento', false),
              _itemCartaoTerritorio('T.03 - Vila Operária', 'Disponível', true),
              _itemCartaoTerritorio('T.04 - Jardim das Flores', 'Trabalhado há 30 dias', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemCartaoTerritorio(String nome, String status, bool concluido) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          concluido ? Icons.check_circle : Icons.map_outlined,
          color: concluido ? Colors.green : Colors.amber.shade800,
        ),
        title: Text(nome, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(status),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }

  // 2. ABA SERVIÇO DE CAMPO
  Widget _buildAbaServicoCampo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Relatório Diário de Campo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E2D4A))),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Horas Dedicadas', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Publicações Entregues', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Revisitas Feitas', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E2D4A)),
                onPressed: () {},
                child: const Text('Salvar Relatório', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 3. ABA EVENTOS
  Widget _buildAbaEventos() {
    return ListView(
      children: const [
        Card(
          child: ListTile(
            leading: Icon(Icons.event, color: Color(0xFF1E2D4A)),
            title: Text('Reunião de Saída de Campo'),
            subtitle: Text('Sábado às 09:00 - Salão do Reino'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.groups, color: Color(0xFF1E2D4A)),
            title: Text('Visita do Superintendente'),
            subtitle: Text('Próxima semana - Programação Especial'),
          ),
        ),
      ],
    );
  }

  // 4. ABA DIRIGENTES
  Widget _buildAbaDirigentes() {
    return ListView(
      children: const [
        Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('A')),
            title: Text('Irmão Antonio'),
            subtitle: Text('Dirigente - Grupo 01'),
          ),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('C')),
            title: Text('Irmão Carlos'),
            subtitle: Text('Dirigente - Grupo 02'),
          ),
        ),
      ],
    );
  }

  // 5. ABA TESTEMUNHO PÚBLICO
  Widget _buildAbaTestemunhoPublico() {
    return ListView(
      children: const [
        Card(
          child: ListTile(
            leading: Icon(Icons.storefront, color: Colors.indigo),
            title: Text('Ponto 1: Praça Central'),
            subtitle: Text('09:00 às 11:00 - Célia / Roberto'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.storefront, color: Colors.indigo),
            title: Text('Ponto 2: Estação de Trem'),
            subtitle: Text('14:00 às 16:00 - Vago'),
          ),
        ),
      ],
    );
  }

  // 6. ABA LIVRETO DE TESTEMUNHO
  Widget _buildAbaLivretoTestemunho() {
    return ListView(
      children: const [
        Card(
          child: ListTile(
            leading: Icon(Icons.menu_book, color: Colors.brown),
            title: Text('Livreto de Abordagens'),
            subtitle: Text('Sugestões de conversas e temas bíblicos'),
          ),
        ),
      ],
    );
  }
}


