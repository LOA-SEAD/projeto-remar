/**
 * Created by loa on 12/03/15.
 */
package projetoremar
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.util.regex.Pattern
import java.util.zip.ZipEntry
import java.util.zip.ZipOutputStream


class FileUtils {


    public static void writeToFile(def directory, def fileName, def list) {
        File file = new File("$directory/$fileName")

        def text = []
        text << "{\"palavras\": [\n"

        int i = 1;
        list.each {
            text << "{ ${it.toJSON()} }"
            if (i < list.size()) {
                text << ","
            }
            text << "\n"
            i++
        }
        text << "]}\n"

        PrintWriter pw = new PrintWriter(file)

        text.each {
            pw.write("${it}")
        }

        pw.close()
    }
}
