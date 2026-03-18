import 'dart:io';
import 'entities/usuario.dart';
import 'utils/utils.dart';


void main() async {
  await DataBase.instalacion();
  String menu = Navegacion.inicio;
  while (true) {
    switch (menu) {
      case "principal":
        menu = Navegacion.principal();
        break;
      case "registro":
        menu = await Navegacion.registro();
        break;
      case "login":
        menu = await Navegacion.login();
        break;
      case "home":
        menu = Navegacion.home();
        break;
      case "buscar":
        print("En construcción");
        break;
    } 
    if (menu == "salir") {
      print("has elegido salir");
      break;
    }
  }
}
  /*
  Usuario usuario = Usuario();
  bool logeado = await usuario.login("javi", "pass");
}

 
  bool registrado = await usuario.registro({'nombre':'Javier','nick':'Xavi','password':'abc456'});
  print(registrado);
}



  void main() async {
  await DataBase.instalacion();
  String? opcion = Navegacion.login();
  switch (opcion) {
    case "1":
      break;
    case "2":
      Map<String,String> datos = Navegacion.registro();

      Usuario usuario = Usuario();
      Future<bool> registrado = usuario.registro(datos);
      if (registrado){
        stdout.writeln("Usuario registrado correctamente");
      } else {
        stdout.writeln("Ese nick ya esta ocupado");
      }

      break;
  }
*/