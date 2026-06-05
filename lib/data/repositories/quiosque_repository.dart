import 'package:client_app/src/shared/models/item_quiosque.dart';
import 'package:client_app/src/shared/models/quiosque_model.dart';

///   - `listarQuiosques()` -> GET de "quiosques próximos"
///   - `listarItensQuiosque(idQuiosque)` -> GET do cardápio do quiosque
/// O parse via `fromJson` já está pronto para receber o `jsonDecode` da resposta.


class QuiosqueRepository {
  static final QuiosqueRepository instance = QuiosqueRepository._init();

  QuiosqueRepository._init();

  static const List<Map<String, dynamic>> _quiosques = [
    {
      'idQuiosque': '1',
      'nomeQuiosque': 'Quiosque 1',
      'imgPerfilQuiosque': 'logo.png',
      'imgBannerQuiosque': 'bannerTeste.png',
      'avaliacaoQuiosque': 4.5,
      'distanciaQuiosque': '60',
      'disponivelEntrega': false,
      'tempoEspera': 30,
      'categorias': ['Lanches', 'Bebidas'],
      'horarioAbre': '09:00',
      'horarioFecha': '18:00',
    },
    {
      'idQuiosque': '2',
      'nomeQuiosque': 'Quiosque 2',
      'imgPerfilQuiosque': 'logo.png',
      'imgBannerQuiosque': 'logo.png',
      'avaliacaoQuiosque': 2.1,
      'distanciaQuiosque': '84',
      'disponivelEntrega': false,
      'tempoEspera': 45,
      'categorias': ['Porções', 'Cervejas'],
      'horarioAbre': '11:00',
      'horarioFecha': '23:00',
    },
    {
      'idQuiosque': '3',
      'nomeQuiosque': 'Quiosque do Porto Teste aleatório Teste aleatório 2.0',
      'imgPerfilQuiosque': 'logo1.png',
      'imgBannerQuiosque': 'bannerTeste1.png',
      'avaliacaoQuiosque': 4.8,
      'distanciaQuiosque': '12',
      'disponivelEntrega': true,
      'tempoEspera': 15,
      'categorias': ['Frutos do Mar', 'Bebidas'],
      'horarioAbre': '04:00',
      'horarioFecha': '22:00',
    },
    {
      'idQuiosque': '4',
      'nomeQuiosque': 'Quiosque Beira Mar',
      'avaliacaoQuiosque': 3.9,
      'distanciaQuiosque': '45',
      'disponivelEntrega': false,
      'tempoEspera': 25,
      'categorias': ['Lanches', 'Sucos Naturais'],
      'horarioAbre': '05:00',
      'horarioFecha': '21:00',
    },
    {
      'idQuiosque': '5',
      'nomeQuiosque': 'Cantinho da Praia',
      'imgPerfilQuiosque':
          'https://www.guiaviagensbrasil.com/imagens/quiosque-praia-monguaga-sp.jpg',
      'imgBannerQuiosque':
          'https://www.guiaviagensbrasil.com/imagens/quiosque-praia-monguaga-sp.jpg',
      'avaliacaoQuiosque': 5.0,
      'distanciaQuiosque': '5',
      'disponivelEntrega': true,
      'tempoEspera': 20,
      'categorias': ['Lanches', 'Porções', 'Bebidas', 'Outros'],
      'horarioAbre': '10:00',
      'horarioFecha': '22:00',
    },
    {
      'idQuiosque': '6',
      'nomeQuiosque': 'Quiosque Central',
      'imgPerfilQuiosque': 'logo.png',
      'imgBannerQuiosque': 'bannerTeste.png',
      'avaliacaoQuiosque': 4.2,
      'distanciaQuiosque': '110',
      'disponivelEntrega': false,
      'tempoEspera': 40,
      'categorias': ['Pratos Feitos', 'Sobremesas'],
      'horarioAbre': '10:00',
      'horarioFecha': '22:00',
    },
  ];

  static const List<Map<String, dynamic>> _adicionais = [
    {'nome': 'ketchup', 'preco': 200},
    {'nome': 'mostarda', 'preco': 300},
    {'nome': 'cheddar', 'preco': 1500},
    {'nome': 'bacon', 'preco': 1800},
  ];

  /// Cardápio base. O `idQuiosque` é preenchido em `listarItensQuiosque`,
  /// conforme o quiosque solicitado.
  static const List<Map<String, dynamic>> _itens = [
    {
      'idItem': '1',
      'secaoItem': 'Porções',
      'nomeItem': 'Batata frita',
      'descricaoItem':
          'Batata inglesa frita com sal Batata inglesa frita com sal Batata inglesa frita com sal Batata inglesa frita com sal Batata inglesa frita com sal',
      'precoItem': 4590,
      'imgItem':
          'https://www.tendaatacado.com.br/dicas/wp-content/webp-express/webp-images/uploads/2022/06/como-fazer-batata-frita-topo.jpg.webp',
      'disponivel': true,
      'ingredientes': ['batata', 'sal'],
      'adicionais': _adicionais,
    },
    {
      'idItem': '2',
      'secaoItem': 'Porções',
      'nomeItem': 'Iscas de Frango',
      'descricaoItem':
          'Peito de frango empanado e frito, crocante por fora e suculento por dentro. Acompanha molho da casa.',
      'precoItem': 3800,
      'imgItem':
          'https://www.sabornamesa.com.br/media/k2/items/cache/dcca011eac737955750c5f2f4e56b627_XL.jpg',
      'disponivel': true,
      'ingredientes': ['frango', 'farinha de rosca', 'tempero especial'],
      'adicionais': _adicionais,
    },
    {
      'idItem': '3',
      'secaoItem': 'Bebidas',
      'nomeItem': 'Suco de Laranja',
      'descricaoItem':
          'Suco natural da fruta, espremido na hora. Fonte de vitamina C, refrescante e sem conservantes.',
      'precoItem': 1200,
      'imgItem':
          'https://www.sabornamesa.com.br/media/k2/items/cache/b018fd5ec8f1b90a1c8015900c2c2630_XL.jpg',
      'disponivel': true,
      'ingredientes': ['laranja'],
      'adicionais': <Map<String, dynamic>>[],
    },
    {
      'idItem': '4',
      'secaoItem': 'Hambúrgueres',
      'nomeItem': 'X-Salada Especial',
      'descricaoItem':
          'Pão brioche, blend bovino 150g, queijo prato, alface, tomate, cebola roxa e maionese artesanal.',
      'precoItem': 3290,
      'imgItem':
          'https://s2-receitas.glbimg.com/Td050XeFMOBB7XFeJigA5voIlvE=/0x0:1200x675/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_1f540e0b94d8437dbbc39d567a1dee68/internal_photos/bs/2024/7/K/ehv3mfQjmY0VivlyFd8g/x-salada-classico.jpg',
      'disponivel': true,
      'ingredientes': ['carne bovina', 'queijo', 'alface', 'tomate', 'pão'],
      'adicionais': _adicionais,
    },
    {
      'idItem': '5',
      'secaoItem': 'Porções',
      'nomeItem': 'Anéis de Cebola',
      'descricaoItem':
          'Cebolas selecionadas empanadas com farinha panko, fritas até ficarem douradas e muito crocantes.',
      'precoItem': 2550,
      'imgItem':
          'https://guiadacozinha.com.br/wp-content/uploads/2018/05/aneldecebola.webp',
      'disponivel': true,
      'ingredientes': ['cebola', 'farinha panko'],
      'adicionais': _adicionais,
    },
    {
      'idItem': '6',
      'secaoItem': 'Sobremesas',
      'nomeItem': 'Petit Gâteau',
      'descricaoItem':
          'Bolinho quente de chocolate com recheio cremoso. Acompanha uma bola de sorvete de baunilha.',
      'precoItem': 2200,
      'imgItem':
          'https://s2-receitas.glbimg.com/PSo7shjUPc3x5w_8zMTj3J4ZrEM=/0x0:1280x800/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_1f540e0b94d8437dbbc39d567a1dee68/internal_photos/bs/2022/E/p/KwxNhgRFSwV6vTBCzmqA/petit-gateau.jpg',
      'disponivel': true,
      'ingredientes': ['chocolate', 'sorvete de baunilha'],
      'adicionais': <Map<String, dynamic>>[],
    },
  ];

  /// Lista os quiosques próximos.
  // TODO: trocar pela requisição "quiosques próximos"
  Future<List<QuiosqueModel>> listarQuiosques() async {
    return _quiosques.map(QuiosqueModel.fromJson).toList();
  }

  /// Lista os itens vendidos em um quiosque específico.
  // TODO: trocar pela requisição do cardápio do quiosque
  Future<List<ItemQuiosque>> listarItensQuiosque(String idQuiosque) async {
    return _itens
        .map((item) => ItemQuiosque.fromJson({...item, 'idQuiosque': idQuiosque}))
        .toList();
  }
}
