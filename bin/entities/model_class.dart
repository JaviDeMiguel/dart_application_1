import 'dart:ffi';

import 'package:mysql1/mysql1.dart';
import '../utils/database.dart';

abstract class ModelClass {
  abstract String tablename;
  //abstract String primarykey;

  fromDatabase(ResultRow row);
  campos();
  primarykey();

  Future<List> all() async {
    MySqlConnection? conn;
    List listado = [];
    try {
      conn = await DataBase.obtenerConexion();
      var registros = await conn.query("SELECT * FROM $tablename");
      for (ResultRow registro in registros) {
        listado.add(
          fromDatabase(registro),
        ); //Todo el metodo "all" funciona como una plantilla, por ejemplo, el método fromdatabase o la propiedad tablename que se usan en él serán las de las clases que los heredan. Se pisan al ser heredados.
      }
    } catch (error) {
      print(error);
    } finally {
      if (conn != null) {
        // conn?.close();
        conn.close; //
      } //
    }
    return listado;
  }

  Future get(int id) async {
    MySqlConnection? conn;
    try {
      conn = await DataBase.obtenerConexion();
      var registro = await conn.query(
        "SELECT * FROM $tablename WHERE ${primarykey().keys.first} = ?",
        [id],
      );
      if (registro.isNotEmpty) {
        return fromDatabase(registro.first);
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    } finally {
      conn?.close();
    }
  }

  /* save() async {
    if (await exists()){
      await update();
    }else{
      await insert;
    }
    return true;
  }*/

  Future<bool> exists() async {
    MySqlConnection conn = await DataBase.obtenerConexion();
    var respuesta = await conn.query(
      "SELECT * FROM $tablename WHERE ${primarykey().keys.first} = ?"[primarykey()
          .values
          .first],
    );
    return respuesta.isNotEmpty;
  }

  Future<bool> insert() async {
    MySqlConnection conn = await DataBase.obtenerConexion();
    String listaCampos = campos().keys.join(",");
    List valores = campos().values.tolist();
    String interrogantes = valores.map((e) => "?").join(",");
    await conn.query(
      'INSERT INTO $tablename ($listaCampos) VALUES ($interrogantes)',
      valores,
    );
    await conn.close();
    return true;
  }
}
