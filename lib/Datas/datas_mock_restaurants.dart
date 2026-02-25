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
      ),
    ),
  ),

  Restaurant(
    id: 'r6',
    nome: 'Veg & Vida',
    descricao: 'Comida saudável e vegetariana',
    distancia: 1.5,
    pratos: List.generate(
      10,
      (index) => Item(
        id: 'r6p$index',
        tituloPrato: index < 2
            ? 'Suco Detox ${index + 1}'
            : 'Veggie ${index + 1}',
        descricaoPrato: 'Opção saudável e nutritiva',
        ingredientes: 'Legumes, quinoa',
        precos: 22.90 + index,
        tipo: index < 2 ? TipoItem.BEBIDA : TipoItem.SOLIDO,
      ),
    ),
  ),

  Restaurant(
    id: 'r7',
    nome: 'Burger House',
    descricao: 'Hambúrguer artesanal',
    distancia: 2.7,
    pratos: List.generate(
      10,
      (index) => Item(
        id: 'r7p$index',
        tituloPrato: index < 3
            ? 'Refrigerante ${index + 1}'
            : 'Burger ${index + 1}',
        descricaoPrato: 'Especial da casa',
        ingredientes: 'Ingredientes variados',
        precos: 28.90 + index,
        tipo: index < 3 ? TipoItem.BEBIDA : TipoItem.SOLIDO,
      ),
    ),
  ),

  Restaurant(
    id: 'r8',
    nome: 'Café do Porto',
    descricao: 'Café e lanches rápidos',
    distancia: 0.9,
    pratos: List.generate(
      10,
      (index) => Item(
        id: 'r8p$index',
        tituloPrato: index.isEven
            ? 'Café Especial ${index + 1}'
            : 'Lanche ${index + 1}',
        descricaoPrato: 'Especial da casa',
        ingredientes: 'Ingredientes variados',
        precos: 15.90 + index,
        tipo: index.isEven ? TipoItem.BEBIDA : TipoItem.SOLIDO,
      ),
    ),
  ),

  Restaurant(
    id: 'r9',
    nome: 'Doce Encanto',
    descricao: 'Sobremesas e confeitaria',
    distancia: 1.3,
    pratos: List.generate(
      10,
      (index) => Item(
        id: 'r9p$index',
        tituloPrato: 'Doce ${index + 1}',
        descricaoPrato: 'Sobremesa artesanal',
        ingredientes: 'Chocolate, creme',
        precos: 18.90 + index,
        tipo: TipoItem.SOLIDO,
      ),
    ),
  ),

  Restaurant(
    id: 'r10',
    nome: 'Mexicano Loco',
    descricao: 'Comida mexicana tradicional',
    distancia: 2.9,
    pratos: List.generate(
      10,
      (index) => Item(
        id: 'r10p$index',
        tituloPrato: index < 2 ? 'Margarita ${index + 1}' : 'Taco ${index + 1}',
        descricaoPrato: 'Especial mexicano',
        ingredientes: 'Ingredientes variados',
        precos: 26.90 + index,
        tipo: index < 2 ? TipoItem.BEBIDA : TipoItem.SOLIDO,
      ),
    ),
  ),
];
