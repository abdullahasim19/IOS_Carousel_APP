//
//  MainViewController.swift
//  test
//
//  Created by Abdullah Asim on 13/11/2023.
//  Copyright © 2023 Abdullah Asim. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var db  = DatabaseManager()
    var loadedData = [ImageMeta]()
    
    var rowCurrent = -1
    var colCurrent = -1
    var currentSize = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: TableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TableViewCell.cellIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
//        db.deleteAll()
        loadedData = db.loadItems()
        if loadedData.count > 0 {
            let t = loadedData.max(by: { $0.row < $1.row })
            currentSize = Int(t!.row) + 1
            loadedData = loadedData.sorted(by: {$0.col < $1.col})
            print(currentSize)
        }
        
    }
 
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImagePickerDelegate{
    
    func pickImage(row:Int, col:Int) {
        rowCurrent = row
        colCurrent = col
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        imageController.allowsEditing = true
        self.present(imageController, animated: true, completion: nil)
    }
    
    @IBAction func newItem(_ sender: UIBarButtonItem) {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        imageController.allowsEditing = true
        rowCurrent = -1
        colCurrent = -1
        self.present(imageController, animated: true, completion: nil)
    }
    
    // called when image is picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage{
            if loadedData.count > 0 {
                loadedData.removeAll()
            }
            
            if rowCurrent == -1 {
                currentSize += 1
                tableView.reloadData()
            }
            
            let newRow = rowCurrent == -1 ? currentSize - 1 : rowCurrent // row
            let newColumn = colCurrent == -1 ? 0 : colCurrent // column
            db.saveImage(img: selectedImage, row: Int16(newRow), col: Int16(newColumn))
            
            let indexPath = IndexPath(row: newRow, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
                cell.update(img:selectedImage)
                
            }
            self.dismiss(animated: true, completion: nil)
        }
        else
        {
            print("Error")
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier, for: indexPath) as! TableViewCell
        if loadedData.count > 0
        {
            var newArr = [UIImage]()
            for i in loadedData {
                if i.row == indexPath.row {
                    newArr.append(UIImage(data: i.image!)!)
                    
                }
            }
            // we now have array
            cell.loadImages(newArr)
            
        }
        cell.delegate = self
        cell.rowNumber = indexPath.row
        
        return cell
    }
    
}
