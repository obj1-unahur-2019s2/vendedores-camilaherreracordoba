import vendedores.*

class ClienteGenerico {
	method puedeSerAtendido(unVendedor)
}

class ClienteInseguro inherits ClienteGenerico {
	override method puedeSerAtendido(unVendedor) {
		return unVendedor.esVersatil() and unVendedor.esFirme()
	}
}

class ClienteDetallista inherits ClienteGenerico {
	override method puedeSerAtendido(unVendedor) {
		return unVendedor.certificacionesDeProductos().size() >= 3
	}
}

class ClienteHumanista inherits ClienteGenerico {
	override method puedeSerAtendido(unVendedor) {
		return unVendedor.esPersonaFisica()
	}
}