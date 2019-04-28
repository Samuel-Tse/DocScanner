//
//  PDFViewController.swift
//  DocScanner
//
//  Created by Samuel Tse on 28/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var imageToPDF: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.startAnimating()
        if let img = imageToPDF {
            self.navigationItem.title = "PDF Format"
            DispatchQueue.main.async { [unowned self] in
                self.savePDF(img: img)
            }
            
        }
        
    }
    
    private func createPDF(image: UIImage) -> NSData? {
        
        let pdfData = NSMutableData()
        let pdfConsumer = CGDataConsumer(data: pdfData as CFMutableData)!
        
        var mediaBox = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        let pdfContext = CGContext(consumer: pdfConsumer, mediaBox: &mediaBox, nil)!
        
        pdfContext.beginPage(mediaBox: &mediaBox)
        pdfContext.draw(image.cgImage!, in: mediaBox)
        pdfContext.endPage()
        
        return pdfData
    }
    
    private func savePDF(img: UIImage) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let docURL = documentDirectory.appendingPathComponent("myFileName.pdf")
        createPDF(image: img)?.write(to: docURL, atomically: true)
        presentPDF()
        
    }
    
    private func presentPDF() {
        
        // Add PDFView to view controller.
        let pdfView = PDFView(frame: self.view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(pdfView)
        
        // Fit content in PDFView.
        pdfView.autoScales = true
        
        // Load Sample.pdf file from app bundle.
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let docURL = documentDirectory.appendingPathComponent("myFileName.pdf")
        pdfView.document = PDFDocument(url: docURL as URL)
        self.indicator.stopAnimating()
    }
}
