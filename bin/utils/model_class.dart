import 'package:mysql1/mysql1.dart';
import '../utils/database.dart';

abstract class ModelClass {
    abstract String tablename;
    abstract String primarykey;

    fromDatabase(ResultRow row);

    
  Future<List> all() async {
    MySqlConnection conn = await DataBase.obtenerConexion();
    var registros = await conn.query("SELECT * FROM $tablename");
    List listado = [];
    for(ResultRow registro in registros){
      listado.add(fromDatabase(registro));
    }
    return listado;
  }

  Future get(int id) async {
    MySqlConnection conn = await DataBase.obtenerConexion();
    var registro = await conn.query("SELECT * FROM $tablename WHERE $primarykey = ?" [id]);
    return fromDatabase(registro.first);
  }

  Future bool save() async {
    MySqlConnection conn = await DataBase.obtenerConexion();


  }
}