import sanjarunner_1.Fase
	
class BootStrap {
    def init = { servletContext ->
		def santos = new Fase(idFase: 0, nameFase: 'Santos Dumont')
		santos.save()
		
		def cassiano = new Fase(idFase: 1, nameFase: 'Cassiano Ricardo')
		cassiano.save()
		
		def matriz = new Fase(idFase: 2, nameFase: 'Igreja Matriz')
		matriz.save()
		
		def banhado = new Fase(idFase: 3, nameFase: 'Banhado')
		banhado.save()
		
		def vicentina = new Fase(idFase: 4, nameFase: 'Vicentina Aranha')
		vicentina.save()
		
    }
    def destroy = {
    }
}
