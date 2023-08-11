class Usuarios {
  String email;
  String password;
  bool activo;
  String nombre;
  String apellidos;
  String fechanac;
  String fechainicio;
  String fechafinal;
  String superuser;

  Usuarios(this.email, this.password, this.activo, this.nombre, this.apellidos,
      this.fechanac, this.fechainicio, this.fechafinal, this.superuser);

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'activo': activo,
      'nombre': nombre,
      'apellidos': apellidos,
      'frechanac': fechanac,
      'fechainicio': fechainicio,
      'fechafin': fechafinal,
      'superuser': superuser
    };
  }

  Usuarios.fromMap(Map<String, dynamic> map)
      : email = map["email"],
        password = map["password"],
        activo = map["activo"],
        nombre = map["nombre"],
        apellidos = map["apellidos"],
        fechanac = map["fechanac"],
        fechainicio = map["fechainicio"],
        fechafinal = map["fechafinal"],
        superuser = map["superuser"];
}
