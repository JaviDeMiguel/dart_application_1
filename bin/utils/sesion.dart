import "../entities/entities.dart";
import "../utils/utils.dart";
import 'package:mysql1/mysql1.dart';

abstract class Sesion{
  static Usuario? usuario;

  static Future<bool> login(String nick, String password) async {
    MySqlConnection conn = await DataBase.obtenerConexion();
    var respuesta = await conn.query(
      'SELECT * FROM users WHERE nick = ?',
      [nick],
    );
    bool noexiste = respuesta.isEmpty;
    if(noexiste || respuesta.first[3] != password){
      await conn.close();
      return false;
    }
    //como el usuario existe y la contraseña coincide, creo el usuario de la sesión
    await conn.close();
    usuario = Usuario.fromDatabase(respuesta.first);
    return true;
  }
}
/*(
      respuesta.first[0],
      respuesta.first[1],
      respuesta.first[2],
      respuesta.first[3],
      respuesta.first[4],
    );
    return true;
  }
}
*/