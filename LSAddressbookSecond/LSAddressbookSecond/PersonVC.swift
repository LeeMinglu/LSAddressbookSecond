//
//  PersonVC.swift
//  LSAddressbookSecond
//
//  Created by 李明禄 on 2017/4/16.
//  Copyright © 2017年 SocererGroup. All rights reserved.
//

import UIKit

class PersonVC: UITableViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var photoText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    
    
    var person: Person?
    var completionCallBack:(()->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameText.text = person?.name
        photoText.text = person?.phone
        addressText.text = person?.address

    }
    
    @IBAction func savePerson(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        if person == nil {
            person = Person()
        }
        person?.name = nameText.text
        person?.phone = photoText.text
        person?.address = addressText.text
        completionCallBack?()
    }
    
}
