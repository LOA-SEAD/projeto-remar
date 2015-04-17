import projetoremar.Marshallers
import projetoremar.PalavrasMarshaller

// Place your Spring DSL code here
beans = {
    marshallers(Marshallers) {
        marshallers = [
                new PalavrasMarshaller()
        ]
    }
}
