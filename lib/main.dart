    // 1. ABA TERRITÓRIOS (Com 14 territórios editáveis)
  final List<Map<String, String>> listaTerritorios = List.generate(
    14,
    (index) => {
      'numero': '${index + 1}',
      'nome': 'Território ${index + 1}',
      'status': 'Disponível',
    },
  );

  Widget _buildAbaTerritorios() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Territórios (1 a 14)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E2D4A)),
            ),
            Text(
              'Total: ${listaTerritorios.length}',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: listaTerritorios.length,
            itemBuilder: (context, index) {
              final item = listaTerritorios[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF1E2D4A),
                    child: Text(
                      item['numero']!,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    item['nome']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Status: ${item['status']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.amber),
                    onPressed: () {
                      _mostrarDialogoEditarNome(index);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _mostrarDialogoEditarNome(int index) {
    TextEditingController controller = TextEditingController(text: listaTerritorios[index]['nome']);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Território ${listaTerritorios[index]['numero']}'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Nome do Território'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  listaTerritorios[index]['nome'] = controller.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
                                    
