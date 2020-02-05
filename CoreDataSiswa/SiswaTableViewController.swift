//
//  SiswaTableViewController.swift
//  CoreDataSiswa
//
//  Created by Rasyid Respati Wiriaatmaja on 04/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import UIKit
import CoreData

class SiswaTableViewController: UITableViewController {
    
    @IBOutlet weak var searchSiswa: UISearchBar!
    
    var siswa = [Siswa]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchSiswa.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
        
    }
    
    func getData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Siswa")
        
        do {
            let result = try context.fetch(fetchRequest)
            siswa = result as! [Siswa]
            tableView.reloadData()
        } catch {
            print(error)
        }
        
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return siswa.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataSiswa = siswa[indexPath.row]
        var cell : SiswaTableViewCell? = nil
        
        if dataSiswa.jenisKelamin == "Pria"{
            cell = tableView.dequeueReusableCell(withIdentifier: "cellPria", for: indexPath) as? SiswaTableViewCell
        }
        else if dataSiswa.jenisKelamin == "Wanita"{
            cell = tableView.dequeueReusableCell(withIdentifier: "cellWanita", for: indexPath) as? SiswaTableViewCell
        }
        
        cell?.lblNama.text = dataSiswa.nama
        cell?.lblAsal.text = dataSiswa.asal
        cell?.lblGender.text = dataSiswa.jenisKelamin
        
        return cell!
    }
    
    //atur tinggi tiap cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
        
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, handler) in
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let dataSiswa = self.siswa[indexPath.row]
            
            context.delete(dataSiswa)
            
            do{
                try context.save()
            } catch {
                print(error)
            }
            
            self.getData()
            
        }
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            
            self.performSegue(withIdentifier: "EditAction", sender: indexPath)
            
        }
        
        edit.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.6622132659, green: 0, blue: 0.08407194167, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [edit, delete])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataSiswa = siswa[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "DetailSiswa") as! DetailViewController
        
        destination.dataNama = dataSiswa.nama
        destination.dataAsal = dataSiswa.asal
        destination.dataHobi = dataSiswa.hobi
        destination.dataJenjang = dataSiswa.jenjang
        destination.dataGender = dataSiswa.jenisKelamin
        
        show(destination, sender: self)
    }
    
    
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditAction" {
            if let tujuan = segue.destination as? ViewController {
                
                let index = sender as! IndexPath
                let dataSiswa = self.siswa[index.row]
                
                tujuan.siswa = dataSiswa
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "EditAction" {
            return false
        }
        return true
    }
}

extension SiswaTableViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Siswa")
        
        if searchText != "" {
            fetchRequest.predicate = NSPredicate(format: "nama LIKE[c] %@", searchText + "*")
        }
        
        do {
            let result = try context.fetch(fetchRequest)
            siswa = result as! [Siswa]
            tableView.reloadData()
        } catch {
            print(error)
        }
        
    }
}
