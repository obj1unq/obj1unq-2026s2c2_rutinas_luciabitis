class Rutina {
  method caloriasConsumidas(persona) = (100 * (self.tiempo(
    persona
  ) - self.descanso(persona))) * self.intensidad()
  
  method intensidad()
  
  method descanso(persona)
  
  method tiempo(persona) = persona.tiempoDedicado()
}

class Running inherits Rutina {
  const property intensidad
  
  override method descanso(persona) = if (persona.tiempoDedicado() > 20) 5
                                      else 2
}

class Maratón inherits Running {
  override method caloriasConsumidas(persona) = super(persona) * 2
}

class Remo inherits Rutina {
  override method intensidad() = 1.3
  
  override method descanso(persona) = persona.tiempoDedicado() / 5
}

class RemoDeCompeticion inherits Remo {
  override method intensidad() = 1.7
  
  override method descanso(persona) = (super(persona) - 3).max(2)
}

class Persona {
  var property peso
  
  method tiempoDedicado()
  
  method aplicarRutina(rutina) {
    self.validarRutina(rutina)
    peso -= self.pesoPerdido(rutina)
  }
  
  method validarRutina(rutina) {
    if (not self.puedeRealizarRutina(rutina)) self.error(
        "no es posible usar rutina"
      )
  }
  
  method puedeRealizarRutina(rutina)
  
  method pesoPerdido(rutina) = rutina.caloriasConsumidas(
    self
  ) / self.caloriasPorKilo()
  
  method caloriasPorKilo()
}

class Sedentario inherits Persona {
  const property tiempo
  
  override method caloriasPorKilo() = 7000
  
  override method tiempoDedicado() = tiempo
  
  override method puedeRealizarRutina(rutina) = peso > 50
}

class Atleta inherits Persona {
  override method pesoPerdido(rutina) = super(rutina) - 1
  
  override method tiempoDedicado() = 90
  
  override method caloriasPorKilo() = 8000
  
  override method puedeRealizarRutina(rutina) = rutina.caloriasConsumidas(
    self
  ) > 10000
}

class Club {
  const predios = #{}
  
  method agregarPredios(_predios) {
    predios.addAll(_predios)
  }
  
  method mejorPredioPara(persona) = predios.max(
    { predio => predio.caloriasTotalesPerdidas(persona) }
  )
  
  method predioMasTranquiPara(persona) = predios.filter(
    { predio => predio.hayRutinaTranqui(persona) }
  )
  
  method rutinaMasExigentePara(persona) = predios.map(
    { predio => predio.rutinaMasExigentePara(persona) }
  ).asSet()
}

class Predio {
  const rutinas = #{}
  
  method agregarRutinas(_rutinas) {
    rutinas.addAll(_rutinas)
  }
  
  method caloriasTotalesPerdidas(persona) = rutinas.sum(
    { rutina => rutina.caloriasConsumidas(persona) }
  )
  
  method hayRutinaTranqui(persona) = rutinas.any(
    { rutina => rutina.caloriasConsumidas(persona) < 500 }
  )
  
  method rutinaMasExigentePara(persona) = rutinas.max(
    { rutina => rutina.caloriasConsumidas(persona) }
  )
}