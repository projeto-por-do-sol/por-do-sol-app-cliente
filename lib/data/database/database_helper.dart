import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Instância privada do Singleton
  static final DatabaseHelper instance = DatabaseHelper._init();

  // Objeto do banco de dados do sqflite
  static Database? _database;

  // Construtor privado
  DatabaseHelper._init();

  // Getter para o banco de dados (abre o banco se não estiver aberto)
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cliente.db');
    return _database!;
  }

  // Inicializa o banco de dados no caminho correto do dispositivo
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Abre o banco e define a versão e o que fazer na criação
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Define a estrutura das tabelas usando SQL puro
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pedidos (
        idPedido TEXT NOT NULL,
        idProduto TEXT NOT NULL,
        idQuiosque TEXT NOT NULL,
        codigoPedido TEXT NOT NULL,
        nomeQuiosque TEXT NOT NULL,
        imgBannerQuiosque TEXT,
        nomeItem TEXT NOT NULL,
        valorTotal INTEGER NOT NULL,
        ingredientes TEXT,
        adicionais TEXT,
        qtdeItem INTEGER NOT NULL,
        status TEXT NOT NULL,
        horaPedido TEXT NOT NULL,
        PRIMARY KEY (idPedido, idProduto, idQuiosque)
      )
    ''');
  }
}