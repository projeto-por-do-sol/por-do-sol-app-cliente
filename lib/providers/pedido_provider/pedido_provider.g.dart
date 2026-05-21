// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PedidoNotifier)
final pedidoProvider = PedidoNotifierProvider._();

final class PedidoNotifierProvider
    extends $AsyncNotifierProvider<PedidoNotifier, List<PedidosModel>> {
  PedidoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pedidoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pedidoNotifierHash();

  @$internal
  @override
  PedidoNotifier create() => PedidoNotifier();
}

String _$pedidoNotifierHash() => r'3aed505b9f692ab64e6902e322e78e8e32cadf17';

abstract class _$PedidoNotifier extends $AsyncNotifier<List<PedidosModel>> {
  FutureOr<List<PedidosModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PedidosModel>>, List<PedidosModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PedidosModel>>, List<PedidosModel>>,
              AsyncValue<List<PedidosModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
