//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Игорь Михайлович Ракитянский on 22.07.16.
//  Copyright © 2016 RIM. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var cars = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "The List"

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext

        let fetchRequest = NSFetchRequest(entityName: "Car")

        do {
            let results = try context.executeFetchRequest(fetchRequest)
            cars = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Запрос данных не прошел: \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")

        let car = cars[indexPath.row]
        cell?.textLabel?.text = car.valueForKey("mark") as? String

        return cell!
    }

    @IBAction func addButtomPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "New Item", message: "Add new item", preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "save", style: .Default) { (action: UIAlertAction) in
            let textField = alert.textFields?.first
            self.saveMark(textField!.text!)
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

    func saveMark(mark: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Car", inManagedObjectContext: context)
        let car = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: context)

        car.setValue(mark, forKey: "mark")

        do {
            try context.save()
            cars.append(car)
        } catch let error as NSError {
            print("localized error description \(error.localizedDescription)")
        }
    }
}

