import 'package:client_app/data/services/cliente_service.dart';
import 'package:client_app/providers/cliente_provider/cliente_provider.dart';
import 'package:client_app/src/modules/inicio/widget/Container_busca.dart';
import 'package:client_app/src/modules/inicio/widget/card_quiosque.dart';
import 'package:client_app/src/shared/models/quiosque_model.dart';
import 'package:client_app/src/shared/utils/verificarHorario.dart';
import 'package:client_app/src/shared/widget/CustomDivider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _termoBusca = '';

  QuiosqueModel quiosque1 = QuiosqueModel(
    idQuiosque: "1",
    nomeQuiosque: "Quiosque 1",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "bannerTeste.png",
    avaliacaoQuiosque: 4.5,
    distanciaQuiosque: "60",
    disponivelEntrega: false,
    tempoEspera: 30,
    categorias: ["Lanches", "Bebidas"],
    horarioAbre: "09:00",
    horarioFecha: "18:00",
  );

  QuiosqueModel quiosque2 = QuiosqueModel(
    idQuiosque: "2",
    nomeQuiosque: "Quiosque 2",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "logo.png",
    avaliacaoQuiosque: 2.1,
    distanciaQuiosque: "84",
    disponivelEntrega: false,
    tempoEspera: 45,
    categorias: ["Porções", "Cervejas"],
    horarioAbre: "11:00",
    horarioFecha: "23:00",
  );

  QuiosqueModel quiosque3 = QuiosqueModel(
    idQuiosque: "3",
    nomeQuiosque: "Quiosque do Porto Teste aleatório Teste aleatório 2.0",
    imgPerfilQuiosque: "logo1.png",
    imgBannerQuiosque: "bannerTeste1.png",
    avaliacaoQuiosque: 4.8,
    distanciaQuiosque: "12",
    disponivelEntrega: true,
    tempoEspera: 15,
    categorias: ["Frutos do Mar", "Bebidas"],
    horarioAbre: "04:00",
    horarioFecha: "22:00",
  );

  QuiosqueModel quiosque4 = QuiosqueModel(
    idQuiosque: "4",
    nomeQuiosque: "Quiosque Beira Mar",
    avaliacaoQuiosque: 3.9,
    distanciaQuiosque: "45",
    disponivelEntrega: false,
    tempoEspera: 25,
    categorias: ["Lanches", "Sucos Naturais"],
    horarioAbre: "05:00",
    horarioFecha: "21:00",
  );

  QuiosqueModel quiosque6 = QuiosqueModel(
    idQuiosque: "6",
    nomeQuiosque: "Quiosque Central",
    imgPerfilQuiosque: "logo.png",
    imgBannerQuiosque: "bannerTeste.png",
    avaliacaoQuiosque: 4.2,
    distanciaQuiosque: "110",
    disponivelEntrega: false,
    tempoEspera: 40,
    categorias: ["Pratos Feitos", "Sobremesas"],
    horarioAbre: "10:00",
    horarioFecha: "22:00",
  );

  QuiosqueModel quiosque5 = QuiosqueModel(
    idQuiosque: "5",
    nomeQuiosque: "Cantinho da Praia",
    imgPerfilQuiosque:
        "https://www.guiaviagensbrasil.com/imagens/quiosque-praia-monguaga-sp.jpg",
    imgBannerQuiosque:
        "https://www.guiaviagensbrasil.com/imagens/quiosque-praia-monguaga-sp.jpg",
    avaliacaoQuiosque: 5.0,
    distanciaQuiosque: "5",
    disponivelEntrega: true,
    tempoEspera: 20,
    categorias: ["Lanches", "Porções", "Bebidas", "Outros"],
    horarioAbre: "10:00",
    horarioFecha: "22:00",
  );

  late List<QuiosqueModel> listaQuiosques = [
    quiosque1,
    quiosque2,
    quiosque3,
    quiosque4,
    quiosque5,
    quiosque6,
  ];

  @override
  void initState() {
    super.initState();
    listaQuiosques.sort(
      (a, b) => double.parse(a.distanciaQuiosque).compareTo(
        double.parse(b.distanciaQuiosque),
      ),
    );
    _obterLocalizacao();
  }

  Future<void> _obterLocalizacao() async {
    await ClienteService.instance.obterLocalizacao();
  }

  List<QuiosqueModel> get _listaFiltrada {
    if (_termoBusca.isEmpty) return listaQuiosques;
    final termo = _termoBusca.toLowerCase();
    return listaQuiosques
        .where((q) => q.nomeQuiosque.toLowerCase().contains(termo))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final clienteAsync = ref.watch(clienteProvider);
    final nomeCliente = clienteAsync.value?.nomeCompleto.split(' ').first;
    final listaFiltrada = _listaFiltrada;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ContainerBusca(
                nomeCliente: nomeCliente,
                onSearch: (termo) {
                  setState(() {
                    _termoBusca = termo;
                  });
                },
                trocaFiltro: (filtro, ordenacao) {
                  setState(() {
                    if (filtro == "distancia") {
                      if (ordenacao == "menor") {
                        listaQuiosques.sort(
                          (a, b) => double.parse(a.distanciaQuiosque).compareTo(
                            double.parse(b.distanciaQuiosque),
                          ),
                        );
                      } else {
                        listaQuiosques.sort(
                          (a, b) => double.parse(b.distanciaQuiosque).compareTo(
                            double.parse(a.distanciaQuiosque),
                          ),
                        );
                      }
                    } else {
                      if (ordenacao == "menor") {
                        listaQuiosques.sort(
                          (a, b) => a.avaliacaoQuiosque.compareTo(
                            b.avaliacaoQuiosque,
                          ),
                        );
                      } else {
                        listaQuiosques.sort(
                          (a, b) => b.avaliacaoQuiosque.compareTo(
                            a.avaliacaoQuiosque,
                          ),
                        );
                      }
                    }
                  });
                },
              ),

              const SizedBox(height: 30),

              if (listaFiltrada.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Nenhum quiosque encontrado.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                )
              else
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      if (listaFiltrada.any((q) => q.disponivelEntrega)) ...[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Entrega aí",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        ...listaFiltrada
                            .where((quiosque) => quiosque.disponivelEntrega)
                            .map((quiosque) => CardQuiosque(quiosque: quiosque)),
                      ],

                      if (listaFiltrada.any((q) => !q.disponivelEntrega)) ...[
                        if (listaFiltrada.any(
                          (q) =>
                              q.disponivelEntrega &&
                              verificarQuiosqueAberto(
                                q.horarioAbre,
                                q.horarioFecha,
                              ),
                        )) ...[
                          CustomDivider(),
                          const SizedBox(height: 20),
                        ],

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Não entrega aí",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        ...listaFiltrada
                            .where((quiosque) => !quiosque.disponivelEntrega)
                            .map((quiosque) => CardQuiosque(quiosque: quiosque)),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
