package projetoremar

import com.sun.org.apache.xpath.internal.functions.FuncDoclocation

class Design {

   // List<Byte> icones = new ArrayList<Byte>()
   // List<Byte> telasFundo = new ArrayList<Byte>()
   // List<Byte> telasAbertura = new ArrayList<Byte>()

     byte[] icone
     byte[] telaFundo
     byte[] telaAbertura



    static constraints = {
        icone nullable:true, maxSize: 16384 /* 16K */
        telaFundo nullable:true, maxSize: 16384 /* 16K */
        telaAbertura nullable:true, maxSize: 16384 /* 16K */
    }
}
