//
//  NewSupplyController.swift
//  Supplace
//
//  Created by Mirta Khairunnisa on 28/04/22.
//

import UIKit
import CoreData

class NewSupplyController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var supply: SupplyMO!
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var supplyTableView: UITableView!
    @IBOutlet var nameTextField: RoundedTextField!
    {
        didSet {nameTextField.tag = 1
        nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    @IBOutlet var suppliesCatTextField: RoundedTextField!
    {
        didSet {
            suppliesCatTextField.tag = 2
            suppliesCatTextField.delegate = self
        }
    }

    @IBOutlet var storageTextField: RoundedTextField!
    {
        didSet {
            storageTextField.tag = 3
            storageTextField.delegate = self
        }
    }
    @IBOutlet var dateBoughtTextField: RoundedTextField!
   
    {
    didSet {
        dateBoughtTextField.tag = 4
        dateBoughtTextField.delegate = self
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        if nameTextField.text == "" || suppliesCatTextField.text == "" || storageTextField.text == "" || dateBoughtTextField.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "Sorry! we can't proceed because not all fields are filled.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            
            present(alertController, animated: true, completion: nil)
            return

    }
    if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
        supply = SupplyMO (context: appDelegate.persistentContainer.viewContext)
        supply.nameData = nameTextField.text
        supply.storageData = storageTextField.text
        supply.supplyCategoryData = suppliesCatTextField.text
        supply.dateData = dateBoughtTextField.text
        
        if let supplyImage = photoImageView.image {
            supply.imageData = supplyImage.pngData()
        }

        appDelegate.saveContext()
    }
        dismiss(animated: true, completion: nil)
    }
    // MARK: - Text Field methods
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let nextTextField = view.viewWithTag(textField.tag + 1) {
                textField.resignFirstResponder()
                nextTextField.becomeFirstResponder()
            }
            
            return true
        }
    // MARK: - Table View delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            
            present(photoSourceRequestController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Image Picker methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
}

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem


    // MARK: - Table view data source

   


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


