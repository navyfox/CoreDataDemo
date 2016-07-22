//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Игорь Михайлович Ракитянский on 22.07.16.
//  Copyright © 2016 RIM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var list = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "The List"

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        cell?.textLabel?.text = list[indexPath.row]

        return cell!
    }

    @IBAction func addButtomPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "New Item", message: "Add new item", preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "save", style: .Default) { (action: UIAlertAction) in
            let textField = alert.textFields?.first
            self.list.append(textField!.text!)
            self.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "cancel", style: .Default) { (action: UIAlertAction) in

        }

        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in

        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        presentViewController(alert, animated: true, completion: nil)

    }

}

