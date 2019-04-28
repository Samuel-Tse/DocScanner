//
//  DetailViewController.swift
//  DocScanner
//
//  Created by Samuel Tse on 28/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit
import PDFKit

class DetailViewController: UIViewController {

    var image: UIImage?
    var name: String?
    var created: String?
    
    @IBOutlet weak var Label_Name: UILabel!
    @IBOutlet weak var Label_Created: UILabel!
    
    @IBOutlet weak var barButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let img = image {
            imageView.image = img
           self.navigationItem.title = "Photo Format"
            //savePDF(img: img)
        }
        if let name = name,
            let created = created {
            self.Label_Name.text = name
            self.Label_Created.text = created
        }
    }
    
    @IBAction func showPDFAction(_ sender: UIButton) {
        
       self.performSegue(withIdentifier: "showPDF", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPDF" {
            if let destinationVC = segue.destination as? PDFViewController {
                destinationVC.imageToPDF = image
            }
        }
    }
}

