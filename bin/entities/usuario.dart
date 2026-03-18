import 'package:mysql1/mysql1.dart';
import '../utils/utils.dart';

class Usuario {
  int? id_usuario;
  String? nombre;
  String? nick;
  String? password;

  Usuario(this.id_usuario,this.nombre,this.nick,this.password);

  static Future<bool> registro(Map<String, String> datos) async {
    MySqlConnection conn = await DataBase.obtenerConexion();
    var respuesta = await conn.query('SELECT * FROM users WHERE nick = ?', [
      datos['nick'],
    ]);
    bool existe = respuesta.isNotEmpty;
    if (existe) {
      await conn.close();
      return false;
    }
    await conn.query(
      'INSERT INTO users (nombre,nick,password) VALUES (?,?,?)',
      [datos['nombre'], datos['nick'], datos['password']],
    );
    await conn.close();

    return true;
  }


}
