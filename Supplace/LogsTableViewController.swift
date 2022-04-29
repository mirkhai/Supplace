//
//  LogsTableViewController.swift
//  Supplace
//
//  Created by Mirta Khairunnisa on 27/04/22.
//

import UIKit
import CoreData

class LogsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet var emptyStorageView: UIView!
    
    var fetchResultController: NSFetchedResultsController<SupplyMO>!
    
    var supplies: [SupplyMO] = []
    // MARK:- View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

            navigationController?.navigationBar.prefersLargeTitles = true
            
            // Customize the navigation bar
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            if let customFont = UIFont(name: "SpaceGrotesk-VariableFont_wght", size: 38.0) {
                // For Xcode 9 users, NSAttributedString.Key is equal to NSAttributedStringKey
                navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.28, green: 0.41, blue: 0.58, alpha: 1.00), NSAttributedString.Key.font: customFont]
            }
            
            navigationController?.hidesBarsOnSwipe = true
            // Prepare the empty view
            tableView.backgroundView = emptyStorageView
            tableView.backgroundView?.isHidden = true
            
// fetch data from data store
    let fetchRequest: NSFetchRequest<SupplyMO> = SupplyMO.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: "nameData", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
        let context = appDelegate.persistentContainer.viewContext
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
            if let fetchedObjects = fetchResultController.fetchedObjects {
                supplies = fetchedObjects
            }
        } catch {
            print(error)
        }
    }
    
}

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.hidesBarsOnSwipe = true
}

override func viewDidAppear(_ animated: Bool) {
    
    if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
        return
    }
    
    let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
    if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
        present(walkthroughViewController, animated: true, completion: nil)
    }
}

    // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            
            if supplies.count > 0 {
                tableView.backgroundView?.isHidden = true
               
            } else {
                tableView.backgroundView?.isHidden = false
            
            }
            
            return 1
        }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return supplies.count
        
        }
        

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LogsTableViewCell

        // Configure the cell...
        cell.supplyNameLabel.text = supplies[indexPath.row].nameData
        cell.supplyCatLabel.text = supplies[indexPath.row].supplyCategoryData
        cell.storageCatLabel.text = supplies[indexPath.row].storageData
        cell.dateLabel.text = supplies[indexPath.row].dateData
        if let supplyImageView = supplies[indexPath.row].imageData {
            cell.supplyImageView.image = UIImage(data: supplyImageView as Data)
        }
        return cell
    }
    
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118.0
            
        }

// MARK: UITableViewDelegate Protocol
    
override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
        // Delete the row from the data source
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            let supplyToDelete = self.fetchResultController.object(at: indexPath)
            context.delete(supplyToDelete)
            
            appDelegate.saveContext()
        }
        
        // Call completion handler to dismiss the action button
        completionHandler(true)
    }
    
    
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
    
    return swipeConfiguration
}

    


/*
// Override to support conditional editing of the table view.
override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
}
*/

/*
// Override to support editing the table view.
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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



// MARK: - Fetch requests methods

func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
}

func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
        if let newIndexPath = newIndexPath {
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    case .delete:
        if let indexPath = indexPath {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    case .update:
        if let indexPath = indexPath {
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    default:
        tableView.reloadData()
    }
    
    if let fetchedObjects = controller.fetchedObjects {
        supplies = fetchedObjects as! [SupplyMO]
    }
}

func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
}

}
    
    
