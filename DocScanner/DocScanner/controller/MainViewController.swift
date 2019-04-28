//
//  MainViewController.swift
//  DocScanner
//
//  Created by Samuel Tse on 26/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit
import WeScan
import CoreData

class MainViewController: UIViewController {

    let cellID = "MainTableViewCell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Button_Cam: RoundButton!
    
    private var coreData = CoreDataStack()
    private var fetchedResultsController: NSFetchedResultsController<DocRecord>?
    private var docService: DocService?
    private var docList = [DocRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        docService = DocService(managedObjectContext: coreData.persistentContainer.viewContext)
        loadData()
        tableView.tableFooterView = UIView()
        view.bringSubviewToFront(Button_Cam)
    }
    
    @IBAction func camAction(_ sender: RoundButton) {
        
        let scannerViewController = ImageScannerController(delegate: self)
        present(scannerViewController, animated: true)
    }
    
    // MARK: - Private
    
    private func loadData() {
        if let docs = docService?.getAllDocs() {
            docList = docs
            tableView.reloadData()
            self.navigationItem.title = "All Docs(\(docList.count))"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"
        {
            if let destinationVC = segue.destination as? DetailViewController,
                let cell = sender as? MainTableViewCell {
                destinationVC.image = cell.imageView_Doc.image
                destinationVC.name = cell.label_DocName.text
                destinationVC.created = cell.label_DocCreatedDT.text
            }
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return docList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MainTableViewCell
        
        cell.label_DocName.text = docList[indexPath.row].name
        
        let dataformatter = DateFormatter()
        dataformatter.dateStyle = .medium
        dataformatter.dateFormat = "yyyy MM dd-HH:MM:SS"
        if let theDT = docList[indexPath.row].created {
            cell.label_DocCreatedDT.text = theDT
        }
        
        if let imageData = docList[indexPath.row].photo as Data?  {
            //cell.imageView?.image = UIImage(data: imageData)
            cell.imageView_Doc.image = UIImage(data: imageData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetails", sender: tableView.cellForRow(at: indexPath))
    }
    
}


extension MainViewController: ImageScannerControllerDelegate {
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        print(error)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        scanner.dismiss(animated: true, completion: nil)
        
        let date = Date()
        let dataformatter = DateFormatter()
        dataformatter.dateStyle = .short
        dataformatter.dateFormat = "yyyy,MM,dd-HH:mm"
        let formattedDate = dataformatter.string(from: date)

        if let data = results.scannedImage.pngData() as NSData? {
              let name = "new doc at \(formattedDate)"
            docService?.addDoc(name: name, dt: formattedDate, image: data as Data, completion: { (success, docs) in
                if success {
                    self.docList = docs
                    self.loadData()
                }
            })
        }
    }
    
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        scanner.dismiss(animated: true, completion: nil)
    }
}

