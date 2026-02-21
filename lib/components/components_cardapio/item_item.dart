import 'package:app_por_sol/model/item.dart';
import 'package:flutter/material.dart';

class ItemItem extends StatelessWidget {
  final Item item;
  const ItemItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        elevation: 3,
        color: Colors.amber[200],
        child: InkWell(
          // onTap: () => _itemSelecionado(context),
          child: ListTile(
            //Puxar Nome do quiosque API
            title: Text(
              item.tituloPrato,
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            //Quando  implementar API, puxar imagem (logo do quiosque) salva do de dados
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                'https://www.estadao.com.br/resizer/v2/5776BB3SUJBFFNFYYDEB673PQQ.jpeg?quality=80&auth=e3574cbc8e7fd6f81aa563d250bf079da0935d5fd4d543a72743c3f54461ceee&width=1075&height=527&smart=true',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            //Puxar distancia da API Google maps, no maximo 2.5Km
          ),
        ),
      ),
    );
  }
}
