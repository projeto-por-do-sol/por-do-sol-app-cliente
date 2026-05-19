import 'package:client_app/src/shared/models/item_carrinho.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pedido_provider.g.dart';

@Riverpod(keepAlive: true)
class PedidoNotifier extends _$PedidoNotifier{

  @override //TODO: tem que fazer tudo (não sei como fazer aqui)
  Map<QuiosqueCarrinho, List<ItemCarrinho>> build() {
    return {};
  }


}