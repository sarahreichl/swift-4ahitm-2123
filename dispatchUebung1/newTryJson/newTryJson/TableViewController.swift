import UIKit

class TableViewController: UITableViewController {
    
    let queue = DispatchQueue(label: "demo")
    let link = "https://jsonplaceholder.typicode.com/posts"
    var titles = [String]()
    var bodies = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        queue.async {
            let titles = self.download1()
            let bodies = self.download2()
            DispatchQueue.main.async {
                print("titles: \(titles)")
                print("bodies: \(bodies)")
                self.titles = titles
                self.bodies = bodies
                self.tableView.reloadData()
            }
        }
 
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath)
        let title = titles[indexPath.row]
        let body = bodies[indexPath.row]
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = body
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
    func download1() -> [String] {
        var titles = [String]()
        if let url = URL(string: link) {
            if let data = try? Data(contentsOf: url) {
                print("data: \(data)")
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
                    if let array = jsonObject as? [ [String: Any] ] {
                        for obj in array {
                            let id = obj["id"] as! Int
                            let title = obj["title"] as! String
                            print("obj=\(id) title=\(title)")
                            titles.append(title)
                        }
                    }
                } else {
                    print("ka json")
                }
            } else {
                print("failed to download")
            }
        }
        return titles
    }


func download2() -> [String] {
    var bodies = [String]()
    if let url = URL(string: link) {
        if let data = try? Data(contentsOf: url) {
            print("data: \(data)")
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
                if let array = jsonObject as? [ [String: Any] ] {
                    for obj in array {
                        let id = obj["id"] as! Int
                        let body = obj["body"] as! String
                        print("obj=\(id) body=\(body)")
                        bodies.append(body)
                    }
                }
            } else {
                print("ka json")
            }
        } else {
            print("failed to download")
        }
    }
    return bodies
}

}


