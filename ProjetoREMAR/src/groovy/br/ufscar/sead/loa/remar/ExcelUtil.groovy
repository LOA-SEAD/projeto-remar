package br.ufscar.sead.loa.remar

import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.apache.poi.ss.usermodel.*
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.apache.commons.io.FileUtils

/**
 * Created by garciaph on 21/09/17.
 */

class ExcelUtil {
    def writeListToExcelFile(list, extension) {
        def workbook

        switch (extension) {
            case 'xls':
                workbook = new HSSFWorkbook()
                break
            case 'xlsx':
                workbook = new XSSFWorkbook()
                break
            default:
                return null
        }

        Sheet sheet = workbook.createSheet()

        // Fill spreadsheet
        list.eachWithIndex { l1, i ->
            Row row = sheet.createRow(i as int)
            l1.eachWithIndex { l2, j ->
                Cell cell = row.createCell(j as int)
                cell.setCellValue(l2 as String)
            }
        }

        return workbook
    }

    def getObjectsFromExcelFile(CommonsMultipartFile excelFile) {
        def rows = []

        // Convert CommonsMultipartFile to File
        File convFile = new File (excelFile.getOriginalFilename())
        excelFile.transferTo(convFile)
        FileUtils.deleteQuietly(convFile.getParentFile()) // delete temp file

        try {
            FileInputStream inputStream = new FileInputStream(convFile)
            Workbook workbook = WorkbookFactory.create(inputStream)

            for (Sheet sheet : workbook) {
                for (Row row : sheet) {
                    def cells = []
                    for (Cell cell : row) {
                        def value = getCellValue(cell)
                        cells.add(value)
                    }
                    rows.add(cells)
                }
            }

            return rows
        } catch (FileNotFoundException e) {
            println e.printStackTrace()
        } catch (IOException e) {
            println e.printStackTrace()
        }
    }

    private Object getCellValue(Cell cell) {
        switch (cell.getCellTypeEnum()) {
            case CellType.STRING:
                return cell.getStringCellValue()
            case CellType.BOOLEAN:
                return cell.getBooleanCellValue()
            case CellType.NUMERIC:
                return cell.getNumericCellValue()
        }

        return null
    }
}
