import 'package:client_app/data/repositories/quiosque_repository.dart';
import 'package:client_app/src/shared/models/item_quiosque.dart';
import 'package:client_app/src/shared/models/quiosque_model.dart';

class QuiosqueService {
  static final QuiosqueService instance = QuiosqueService._init();

  final QuiosqueRepository _repository = QuiosqueRepository.instance;

  QuiosqueService._init();

  Future<List<QuiosqueModel>> buscarQuiosques() =>
      _repository.listarQuiosques();

  Future<List<ItemQuiosque>> buscarItensQuiosque(String idQuiosque) =>
      _repository.listarItensQuiosque(idQuiosque);
}
