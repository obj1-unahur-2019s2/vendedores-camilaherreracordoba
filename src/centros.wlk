import vendedores.*

class CentroDeDistribucion {
	const property ciudad
	var property vendedores = []
	
	method tieneAlVendedor(unVendedor) {
		return vendedores.any({ vendedor => vendedor == unVendedor})
	} 
	
	method buscarVendedor(unVendedor) { 
		return 
		if (not self.tieneAlVendedor(unVendedor)) {
			self.error("no se encontró al vendedor")
		} 
		else {
			 vendedores.find({ vendedor => vendedor == unVendedor})
		}
	} 
	
	method agregarVendedor(unVendedor) {
		if (self.tieneAlVendedor(unVendedor)) {
			self.error("este vendedor ya se encuentra trabajando en el centro")
		}
		else {
			vendedores.add(unVendedor)
		}
	}
	method vendedorEstrella() {
		return vendedores.max({ vendedor => vendedor.puntosCertificaciones() })
	}
	method puedeCubrirCiudad(unaCiudad) {
		return vendedores.any({ vendedor => vendedor.puedeTrabajarEn(unaCiudad)})
	}
	method vendedoresGenericos(){
		return vendedores.filter({ vendedor => vendedor.certificacionesQueNoSonDeProductos().size() >= 1}).asSet()
	}
	method esRobusto() {
		return vendedores.count({vendedor => vendedor.esFirme()}) >= 3
	}
	
	method repartirCertificacion(unaCertificacion) {
		vendedores.forEach({vendedor => vendedor.agregarCertificacion(unaCertificacion)})
	}
	
	method esCandidato(unVendedor) {
		return unVendedor.tieneAfinidad(self) and unVendedor.esVersatil()
	}
}