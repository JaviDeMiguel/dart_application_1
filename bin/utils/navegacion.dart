import 'dart:io';
import '../entities/entities.dart';
import 'utils.dart';

abstract class Navegacion {
  static String inicio = 'principal';

  static String principal() {
    String opcion;
    do {
      stdout.writeln("""Elige una opción:
          1. Iniciar sesión
          2. Registrarse
          3. Salir""");
      opcion = stdin.readLineSync() ?? "Error";
      if (_opcionInvalida(opcion,3)) {
        stdout.writeln("Opcion no valida");
      }
    } while (_opcionInvalida(opcion,3));
    if (opcion == "1") {
      return "login";
    } else if (opcion == "2") {
      return "registro";
    } else {
      return "salir";
    }
  }

  static Future<String> registro() async {
    print("Has elegigo registro");
    String? nombre;
    String? nick;
    String? password;
    Map<String, String> datos = {};
    do {
      stdout.writeln("""Registro:
    Introduce tu nombre""");
      nombre = stdin.readLineSync() ?? "error";
      stdout.writeln("Introduce tu usuario");
      nick = stdin.readLineSync() ?? "error";
      stdout.writeln("Introduce tu contraseña");
      password = stdin.readLineSync() ?? "error";
      if (nombre.isEmpty || nick.isEmpty || password.isEmpty) {
        stdout.writeln("Ningún campo puede estar vacío");
      }
      if (password.length < 6) {
        stdout.writeln("la contraseña no puede tener menos de 6 caracteres");
      }
    } while (nombre.isEmpty ||
        nick.isEmpty ||
        password.isEmpty ||
        password.length < 6);

    datos = {"nombre": nombre, "nick": nick, "password": password};
    bool registrado = await Usuario.registro(datos);
    if (registrado) {
      print("Te has registrado correctamente");
      return "principal";
    } else {
      print("El usuario ya existe, vuelve a intentarlo");
      return 'registro';
    }
  }

  static Future<String> login() async {
    print("Has elegido login");
    String? nick;
    String? password;
    do {
      stdout.writeln("Introduce tu usuario");
      nick = stdin.readLineSync() ?? "error";
      stdout.writeln("Introduce tu contraseña");
      password = stdin.readLineSync() ?? "error";
      if (nick.isEmpty || password.isEmpty) {
        stdout.writeln("Ningún campo puede estar vacío");
      }
      if (password.length < 6) {
        stdout.writeln("la contraseña no puede tener menos de 6 caracteres");
      }
    } while (nick.isEmpty || password.isEmpty || password.length < 6);
    bool login = await Sesion.login(nick, password);
    if (login) {
      print("Bienvenido ${Sesion.usuario!.nombre}");
      return "home";
    } else {
      print("Bienvenido $nick");
      return "principal";
    }
  }

  static String home() {
    String opcion;
    do {
      stdout.writeln("""Elige una opción:
          1. Buscar y comprar Pokemon
          2. Quiz Pokemon
          3. Compra aleatoria
          4. Mi equipo
          5. Salir""");
      opcion = stdin.readLineSync() ?? "Error";
      if (_opcionInvalida(opcion,5)) {
        stdout.writeln("Opcion no valida");
      }
    } while (_opcionInvalida(opcion,6));
    switch (opcion) {
      case "1":
        return "buscar";
      case "2":
        print("Esta opción aún no está disponible");
        return "home";
      case "3":
        print("Esta opción aún no está disponible");
        return "home";
      case "4":
        print("Esta opción aún no está disponible");
        return "home";
      case "5":
        return "salir";
      case "6":
        return "home";
      default:
        return "principal";
    }
  }

  static bool _opcionInvalida(String opcion, int numero) {
    return (int.tryParse(opcion) ?? 0) > numero || (int.tryParse(opcion) ?? 0) < 1;
  }
}






    /* bool respuesta=true;
    for(int i=0;i<=numero; i++){
      if (opcion=="$i"){
        respuesta=false;
        break;
        }else
        respuesta=true;
    }
    return respuesta;
  }
}

  
  

  static String login() {
    String opcion;
    do {
      stdout.writeln("""Bienvenido, qué opción deseas elegir
  1: Iniciar sesión
  2: Registrarte""");
      opcion = stdin.readLineSync() ?? "error";
      if (opcion != "1" && opcion != "2") {
        stdout.writeln("La opcion elegida no es válida");
      }
    } while (opcion != "1" && opcion != "2");
    return opcion;
  }


  static Map<String,String> registro(){
    String? nombre;
    String? nick;
    String? password;
    Map<String,String> datos = {};
    do {
        stdout.writeln("""Registro:
    Introduce tu nombre""");
        nombre = stdin.readLineSync() ?? "error";
        stdout.writeln("Introduce tu usuario");
        nick = stdin.readLineSync() ?? "error";
        stdout.writeln("Introduce tu contraseña");
        password = stdin.readLineSync() ?? "error";
        if (nombre.isEmpty || nick.isEmpty || password.isEmpty) {
          stdout.writeln("Ningún campo puede estar vacío");
        }
        if (password.length < 6) {
          stdout.writeln("la contraseña no puede tener menos de 6 caracteres");
        }
      } while (nombre.isEmpty ||
          nick.isEmpty ||
          password.isEmpty ||
          password.length < 6);

    datos = {"nombre":nombre, "nick":nick, "password": password};
    return datos;
  }
}*/