//
//  ViewController.swift
//  Add New Image
//
//  Created by mark me on 3/25/20.
//  Copyright © 2020 mark me. All rights reserved.
//

import UIKit
import CoreData


class AddNewData: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet var tableView: UITableView!
    
    static var array = [User]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        reloadData()
        //navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func reloadData() {
    let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            AddNewData.array = try context.fetch(request)
            self.tableView.reloadData()
            
        } catch {
            print("Data could not fatched right now")
        }
    }
    
    @IBAction func addButton(_ sender: Any)
    {
        
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
            
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            picker.dismiss(animated: true, completion: nil)
            self.addImage(with: image)
        
        }
    
    func addImage(with image: UIImage) {
        
        let newData = User(context: context)
        newData.image = NSData(data: image.jpegData(compressionQuality: 0.3)!) as Data
        
        
        
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Name of Picture", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {(action) in

            let main = textField.text!
            newData.name = main
            self.tableView.reloadData()

            do {
                try self.context.save()
                self.tableView.reloadData()
                self.reloadData()
            }
            catch{
                print("Data could not saved right now, Something went wrong")
            }

        }))

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Name"
            textField = alertTextField

        }
        
        present(alert, animated: true, completion: nil)
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return AddNewData.array.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FirstCell
            
            let data = AddNewData.array[indexPath.row]
            if let cellImage = UIImage(data: data.image!) {
                cell.mainImage.image = cellImage
            }
            if data.name != nil {
                cell.mainLable?.text = data.name
            }
            
            return cell
            
        }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                let commit = AddNewData.array[indexPath.row]
                context.delete(commit)
                AddNewData.array.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                do {
                    try context.save()
                    self.reloadData()
                    self.tableView.reloadData()
                }catch {
                    print("Data could not delete now")
                }
            }
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let second = storyboard?.instantiateViewController(identifier: "SecondScreen") as! SecondScreen
            navigationController?.pushViewController(second, animated: true)
            let getValue = AddNewData.array[indexPath.row]
            
            if getValue.image != nil {
                second.newimage = UIImage(data: getValue.image!)
            }
    //        if getValue.name != nil {
    //            second.newlabel = getValue.name
    //        }
            second.newlabel = getValue.name
            
            
            
        }

    }
    



