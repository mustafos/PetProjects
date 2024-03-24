//
//  PDFViewer.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 24.03.2024.
//

import SwiftUI
import PDFKit

struct PDFViewer: View {
    var body: some View {
        VStack {
            PDFKitView(pdfDoc: PDFDocument(data: generatePDF())!)
            
            Button {
                savePDF()
            } label: {
                Text("Save PDF")
            }
        }
    }
    
    @MainActor
    private func generatePDF() -> Data {
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842))
        let data = pdfRenderer.pdfData { context in
            context.beginPage()
            
            alignText(value: "Test", x: 0, y: 30, width: 595, height: 150, alignment: .center, textFont: UIFont.systemFont(ofSize: 50, weight: .bold))
            
            alignText(value: """
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
""", x: 0, y: 150, width: 595, height: 595, alignment: .left, textFont: UIFont.systemFont(ofSize: 20, weight: .regular))
            
            let globalIcon = UIImage(named: "logo")
            let globalIconRect = CGRect(x: 450, y: 550, width: 100, height: 100)
            globalIcon?.draw(in: globalIconRect)
        }
        return data
    }
    
    func alignText(value: String, x: Int, y: Int, width: Int, height: Int, alignment: NSTextAlignment, textFont: UIFont) {
        let paragtaphStyle = NSMutableParagraphStyle()
        paragtaphStyle.alignment = alignment
        
        let attributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.paragraphStyle: paragtaphStyle
        ]
        let textRect = CGRect(x: x, y: y, width: width, height: height)
        value.draw(in: textRect, withAttributes: attributes)
    }
    
    @MainActor
    func savePDF() {
        let fileName = "GeneratedPDF.pdf"
    let pdfData = generatePDF()
        
        if let documentDirect = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let documentURL = documentDirect.appendingPathComponent(fileName)
            do {
                try pdfData.write(to: documentURL)
                print("PDF Saved at: \(documentURL)")
            } catch {
                print("error")
            }
        }
    }
}

#Preview {
    PDFViewer()
}

struct PDFKitView: UIViewRepresentable {
    let pdfDoc: PDFDocument
    
    init(pdfDoc: PDFDocument) {
        self.pdfDoc = pdfDoc
    }
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDoc
        pdfView.autoScales = true
        
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = pdfDoc
    }
}
