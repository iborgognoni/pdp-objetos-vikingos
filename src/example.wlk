/* Danger Zone */
class UserException inherits Exception {}

class Expedicion {
	const property vikingos = []
	const property ciudadesAInvadir = []
	
	method subir(vikingo, expedicion){
		if(not vikingo.puedeSubirA(expedicion)){
			throw new UserException(message= "el vikingo no cumple los requisitos para subir a la expedicion")
		}
		vikingos.add(vikingo)
	}
	
	method cantidadDeVikingos() = vikingos.size()
	
	method valeLaPena() = ciudadesAInvadir.all({ciudad => ciudad.valeLaPena(self.cantidadDeVikingos())})
}


class Vikingo {
	var property casta = jarl
	
	method esProductivo()
	method tieneArmas()
	
	method puedeSubirA(expedicion) = self.esProductivo() && casta.puedeIr(self, expedicion)
}




class Soldado inherits Vikingo {
	var property vidasCobradas = 0
	var property cantidadDeArmas = 0
	
	override method esProductivo() = vidasCobradas > 0 && self.tieneArmas()
	
	override method tieneArmas() = cantidadDeArmas > 0
}

class Granjero inherits Vikingo {
	var property hijos = 0
	var property hectareas = 0
	
	override method esProductivo() = hectareas == 2*hijos
	
	override method tieneArmas() = false
}

class Casta {
	method puedeIr(vikingo, expedicion) = true
}

object jarl inherits Casta {
	override method puedeIr(vikingo, expedicion) = not vikingo.tieneArmas()
}

object karl inherits Casta {
	
}

object thrall inherits Casta {
	
}

class Capital {
	var property oro
	
	method valeLaPena(cantidadDeVikingos) = 3*cantidadDeVikingos == oro
}

class Aldea {
	var property oro
	
	method valeLaPena(cantidadDeVikingos) = oro >= 15
}

class AldeaAmurallada inherits Aldea {
	var property cantidadMinima
	override method valeLaPena(cantidadDeVikingos) = super(cantidadDeVikingos) && (cantidadDeVikingos >= cantidadMinima)
}