//
//  ContactListTableViewController.swift
//  LSAddressbookSecond
//
//  Created by 李明禄 on 2017/4/16.
//  Copyright © 2017年 SocererGroup. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {

    var personList:[Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData { (personArray) in
            self.personList = personArray
            print(personArray)
            self.tableView.reloadData()
        }
        
    }
    @IBAction func addPerson(_ sender: Any) {
        performSegue(withIdentifier: "list2Person", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.personList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath)
        let person = self.personList[indexPath.row]
        
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.address

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "list2Person", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PersonVC
//        let indexPath = sender as! IndexPath
//        vc.person = self.personList[indexPath.row]
        if let indexPath = sender as? IndexPath {
            vc.person = self.personList[indexPath.row]
            
            vc.completionCallBack = {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    
    

    func loadData (completion:@escaping (_ result:[Person])->()) {
        DispatchQueue.global().async {
            //耗时操作
            var personList:[Person] = []
            for i in 1...20 {
                let person = Person()
                person.name = "rock - \(i)"
                person.phone = "186" + String(format: "\(arc4random_uniform(100000)))")
                person.address = "beijing" + String(format: "\(arc4random_uniform(100000))")
                personList.append(person)
                
                DispatchQueue.main.async {
                    completion(personList)
                }
            }
        }
    }
}
