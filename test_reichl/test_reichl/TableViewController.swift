//
//  TableViewController.swift
//  Covid
//
//  Created by Reichl Sarah on 26.01.22.
//

import UIKit

class TableViewController: UITableViewController {
    
    var titles : [CovidInfo]!    
    
    let queue = DispatchQueue(label: "demo")
    let link = "https://edufs.edu.htl-leonding.ac.at/~c.aberger/download/4ahitm/covid.json"
    
        override func viewDidLoad() {
            super.viewDidLoad()
            queue.async {
                self.titles = self.download()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //falls titles nil is wird keine section angelegt
        var count = 0
        if(titles != nil) {
            count = titles.count
        }
        return count
    }

    
    //In dem Klammern wird festgelegt welche Art von "Objekt" heruntergeladen werden soll
    func download() -> [CovidInfo] {
        var titles = [CovidInfo]()
        if let url = URL(string: link) {
            if let data = try? Data(contentsOf: url) {
                print("data: \(data)")
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
                    if let array = jsonObject as? [ [String: Any] ] {
                        for obj in array {
                        
                        //In das Array der ConvidInfos-Objekte werden nun state fzhosp und fzicu eingefügt
                        let data = CovidInfo(
                            state: obj["Bundesland"] as! String,
                            fzHosp: obj["FZHosp"] as! Int,
                            fzICU:obj["FZICU"] as! Int)
                            
                        //Objekt wird dem Array titles hinzugefügt
                        titles.append(data)
                    } }
                } else {
                    print("Failed to fetch JSON-Data!") }
            } else {
                print("Failed to fetch JSON-Data!") }
        }
        return titles
        
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testcell", for: indexPath)
     
        //State des CovidObjekts wird als Titel angefügt
        cell.textLabel?.text = titles[indexPath.row].state
        
        //fzhosp und fzicu werden als variablen im untertitel hinzugefügt
        let fzHospString = String.init(_:titles[indexPath.row].fzHosp)
        let fzICUString = String.init(_:titles[indexPath.row].fzICU)
        cell.detailTextLabel?.text = fzHospString + "/" + fzICUString
   
     
     return cell
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
    
}
