class Rutina {
  var property intensidad
  var property tiempo
  var property descanso
  
  method caloriasConsumidas() = (100 * (tiempo - descanso)) * intensidad
}

class Running inherits Rutina {
  override method descanso() = if (tiempo < 20) 90 else 5
}

class Maratón inherits Running {
  override method caloriasConsumidas() = super() * 2
}

class Remo inherits Rutina {
  override method intensidad() = 1.3
  
  override method descanso() = tiempo / 5
}

class RemoDeCompeticion inherits Remo {
  override method intensidad() = 1.7
  
  override method descanso() = super() - 3
}