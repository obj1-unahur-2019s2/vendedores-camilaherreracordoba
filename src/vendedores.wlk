class VendedorBase {
	var certificaciones = []
	
	method agregarCertificacion(unaCertificacion) {
		certificaciones.add(unaCertificacion)
	}
	method puedeTrabajarEn(unaCiudad)
	
	method puntosCertificaciones() {
		return 
		if (certificaciones.isEmpty()) {
			0
		} 
		else {
			certificaciones.sum({certificacion => certificacion.puntos()})
		}
	}
	
	method certificacionesDeProductos() {
		return certificaciones.filter({certificacion => certificacion.esDeProductos()})
	}
	method certificacionesQueNoSonDeProductos() {
		return return certificaciones.filter({certificacion => not certificacion.esDeProductos()})
	}
	method esVersatil() {
		return certificaciones.size() >= 3 and self.certificacionesDeProductos().size() >= 1 and self.certificacionesQueNoSonDeProductos().size() >=1
	}
	method esFirme() {
		return certificaciones.sum({ certificacion => certificacion.puntos()}) >= 30
	}
	
	method esInfluyente() 
	
	method tieneAfinidad(unCentro) {
		return self.puedeTrabajarEn(unCentro.ciudad())
	}
	method esPersonaFisica() = true
}

class VendedorFijo inherits VendedorBase {
	var property ciudad
	override method puedeTrabajarEn(unaCiudad) {
		return ciudad == unaCiudad
	}
	override method esInfluyente() = false
}
class VendedorViajante inherits VendedorBase {
	var property provincias = #{}
	override method puedeTrabajarEn(unaCiudad) {
		return provincias.any({provincia => unaCiudad.provincia() == provincia})
	}
	override method esInfluyente(){
		return provincias.sum({provincia => provincia.poblacion()}) >= 10000000
	}
}

class ComercioCorresponsal inherits VendedorBase {
	var property lugarDeSucursales = []
	override method puedeTrabajarEn(unaCiudad) {
		return lugarDeSucursales.any({ lugar => lugar == unaCiudad })
	}
	override method esInfluyente(){
		return lugarDeSucursales.map({lugar => lugar.provincia()}).asSet().size() >= 3 or lugarDeSucursales.size() >= 5
	}
	override method tieneAfinidad(unCentro) {
		return super(unCentro) and lugarDeSucursales.any({ lugar => lugar != unCentro.ciudad()})
	}
	override method esPersonaFisica() = false
}

class Ciudad {
	const property provincia
}

class Provincia {
	const property poblacion
}
class Certificacion {
	var property esDeProductos = false
	var property puntos
}
