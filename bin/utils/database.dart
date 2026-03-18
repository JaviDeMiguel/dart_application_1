import 'package:mysql1/mysql1.dart';

abstract class DataBase {
  static final String _host = "localhost"; //127.0.0.1
  static final int _port = 3306;
  static final String _user = "root";
  static final String _dbName = "miprimera_db";

  static Future<void> instalacion() async {
    var settings = ConnectionSettings(host: _host, port: _port, user: _user);
    var conn = await MySqlConnection.connect(settings);
    await conn.query("CREATE DATABASE IF NOT EXISTS $_dbName");
    await conn.query("USE $_dbName");
    await crearTablaUsers(conn);
    await crearTablapokemon(conn);
    await crearTablausuarioPokemon(conn);
    await conn.close();
  }

  static Future<MySqlConnection> obtenerConexion() async {
    ConnectionSettings settings = ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
      db: _dbName,
    );
    MySqlConnection conn = await MySqlConnection.connect(settings);
    return conn;
  }

  static Future<void> crearTablaUsers(MySqlConnection conn) async {
    await conn.query("""CREATE TABLE IF NOT EXISTS users (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL, 
    nick VARCHAR(10) NOT NULL, 
    password VARCHAR(10) NOT NULL)""");
  }

  static Future<void> crearTablapokemon(MySqlConnection conn) async {
    await conn.query("""CREATE TABLE IF NOT EXISTS pokemon (
    id_pokemon INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL, 
    tipo1 VARCHAR(50) NOT NULL,
    tipo2 VARCHAR(50),
    ataque INT NOT NULL,
    hp INT NOT NULL,
    velocidad INT NOT NULL,
    defensa INT NOT NULL)""");
  }

  static Future<void> crearTablausuarioPokemon(MySqlConnection conn) async {
    await conn.query("""CREATE TABLE IF NOT EXISTS usuarioPokemon (
    id_usuarioPokemon INT AUTO_INCREMENT PRIMARY KEY,
    id_pokemon INT
    )""");
  }

}