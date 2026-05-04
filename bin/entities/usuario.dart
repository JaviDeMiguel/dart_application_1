import 'package:mysql1/mysql1.dart';
import '../utils/utils.dart';

class Usuario extends ModelClass {
  int? id_usuario;
  String? nombre;
  String? nick;
  String? password;
  int monedas = 0;
  @override
  String tablename = 'users';
  @override
  Map? primarykey() => {"id_usuario":id_usuario};
  @override
  Map? campos() => {"nombre": nombre, "nick": nick, "password": password, "monedas": monedas};

  Usuario.nulo();
  Usuario(this.id_usuario,this.nombre,this.nick,this.password,this.monedas);

  Usuario.fromDatabase(ResultRow row){
    id_usuario = row['id_usuario'] ?? -1;
    nombre = row['nombre'];
    nick = row["nick"] ?? "";
    password = row["password"] ?? "";
    monedas = row["monedas"] ?? 0;
 }

 @override
  Usuario fromDatabase(ResultRow row) => Usuario.fromDatabase(row);

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
      'INSERT INTO users (nombre,nick,password,monedas) VALUES (?,?,?,?)',
      [datos['nombre'], datos['nick'], datos['password'], 100],
    );
    await conn.close();

    return true;
  }
  
  bool restarMonedas (int decremento){
    if(decremento >= monedas){
    monedas -= decremento;
    return true;
    } return false;
  }



  /* EL METODO ALL VIENE A SUSTITUIR A:
  Future<List<Usuario>> all() async {
    MySqlConnection conn = await DataBase.obtenerConexion();
    var registros = await conn.query("SELECT * FROM users");
    List<Usuario> listado = [];
    for(ResultRow registro in registros){
      Usuario usuario = Usuario.fromDatabase(registro);
      listado.add(usuario);
    }
    return listado;
  }
*/

}
