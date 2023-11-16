//
//  DatabaseManager.swift
//  test
//
//  Created by Abdullah Asim on 15/11/2023.
//  Copyright © 2023 Abdullah Asim. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct DatabaseManager{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arr = [ImageMeta]()
    
    func saveImage(img:UIImage, row:Int16, col:Int16)
    {
        let newItem = ImageMeta(context:context)
        newItem.image = img.jpegData(compressionQuality: 1.0)
        newItem.row = row
        newItem.col = col
        saveItems()
        
    }
    
    mutating func deleteAll()
    {
        loadItems()
        for i in 0..<arr.count{
            context.delete(arr[i])
//            arr.remove(at: i)
        }
        saveItems()
    }
    
    private func saveItems(){
        do{
            try context.save()
            
        }catch{
            print(error)
        }
    }
    
    mutating func loadItems() -> [ImageMeta]
    {
        let request : NSFetchRequest<ImageMeta> = ImageMeta.fetchRequest()
        do{
            arr = try context.fetch(request)
        }catch{
            print(error)
        }
        return arr
        
    }
    
}

