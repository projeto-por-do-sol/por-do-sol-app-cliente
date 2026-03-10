import 'package:app_por_sol/Datas/datas_mock_acompanhamentos.dart';
import 'package:app_por_sol/model/enuns/tipo_item.dart';
import 'package:app_por_sol/model/item.dart';
import 'package:app_por_sol/model/restaurant.dart';

final List<Restaurant> datasRestaurants = [
  Restaurant(
    id: 'r1',
    nome: 'Sol & Mar',
    descricao: 'Especializado em frutos do mar',
    distancia: 1.2,
    pratos: List.generate(
      10,
      (index) => Item(
        id: 'r1p$index',
        tituloPrato: 'Prato ${index + 1} - Sol & Mar',
        descricaoPrato: 'Delicioso prato da casa',
        ingredientes: 'Peixe, arroz, salada',
        precos: 29.90 + index,
        tipo: TipoItem.SOLIDO,
        list_acompanhamentos: acompanhamentosPadrao,
      ),
    ),
  ),

  Restaurant(
    id: 'r2',
    nome: 'Sabor Tropical',
    descricao: 'Comida brasileira artesanal',
    distancia: 2.4,
    pratos: List.generate(
      10,
      (index) => Item(
        id: 'r2p$index',
        tituloPrato: index < 3
            ? 'Suco Tropical ${index + 1}'
            : 'Prato ${index + 1} - Tropical',
        descricaoPrato: 'Especial da casa',
        ingredientes: 'Ingredientes variados',
        precos: 25.90 + index,
        tipo: index < 3 ? TipoItem.BEBIDA : TipoItem.SOLIDO,
        list_acompanhamentos: index < 3 ? [] : acompanhamentosPadrao,
      ),
    ),
  ),

  Restaurant(
    id: 'r3',
    nome: 'Bella Itália',
    descricao: 'Massas e pizzas tradicionais',
    distancia: 3.1,
    pratos: List.generate(
      10,
      (index) => Item(
        id: 'r3p$index',
        tituloPrato: 'Massa ${index + 1}',
        descricaoPrato: 'Massa artesanal italiana',
        ingredientes: 'Massa fresca, molho tomate',
        precos: 32.50 + index,
        tipo: TipoItem.SOLIDO,
        list_acompanhamentos: acompanhamentosPadrao,
      ),
    ),
  ),

  Restaurant(
    id: 'r4',
    nome: 'Sushi Prime',
    descricao: 'Culinária japonesa premium',
    distancia: 1.8,
    pratos: List.generate(
      10,
      (index) => Item(
        id: 'r4p$index',
        tituloPrato: 'Combo Sushi ${index + 1}',
        descricaoPrato: 'Sushi fresco preparado na hora',
        ingredientes: 'Salmão, arroz japonês',
        precos: 39.90 + index,
        tipo: TipoItem.SOLIDO,
        list_acompanhamentos: acompanhamentosPadrao,
      ),
    ),
  ),

  Restaurant(
    id: 'r5',
    nome: 'Churrasco Gaúcho',
    descricao: 'Carnes nobres na brasa',
    distancia: 2.0,
    pratos: List.generate(
      10,
      (index) => Item(
        id: 'r5p$index',
        tituloPrato: 'Churrasco ${index + 1}',
        descricaoPrato: 'Carne selecionada na brasa',
        ingredientes: 'Picanha, farofa, vinagrete',
        precos: 45.90 + index,
        tipo: TipoItem.SOLIDO,
        list_acompanhamentos: acompanhamentosPadrao,
      ),
    ),
  ),
];
