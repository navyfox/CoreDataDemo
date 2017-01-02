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

//срабатывает один раз когда загружается приложение
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "The List"

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

//срабатывает каждый раз когда происходят изменения в интерфейсе
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    //доступ к AppDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //доступ к Managed Object Context который хранится в качестве ленивого свойстава в AppDelegate
        let context = appDelegate.managedObjectContext
    //делаем запрос к сущности Car
        let fetchRequest = NSFetchRequest(entityName: "Car")

        do {
        //пробуем извлечь значения
            let results = try context.executeFetchRequest(fetchRequest)
        //если получится запишем в Cars рузультат
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
//сохраняем в Core Data
    func saveMark(mark: String) {
    //доступ к AppDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //доступ к Managed Object Context который хранится в качестве ленивого свойстава в AppDelegate
        let context = appDelegate.managedObjectContext
    //доступ к сущности Car
        let entity = NSEntityDescription.entityForName("Car", inManagedObjectContext: context)
    //чтобы сохранить мы должны создать экземпляр NSManagedObject
        let car = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: context)
    //какое значение мы хотим добывить и для какого ключа?
        car.setValue(mark, forKey: "mark")
    //пытаемся сохранить
        do {
            try context.save()
        //если сохранилось, то добавим машину в массив Cars[NSManagedObject]
            cars.append(car)
        } catch let error as NSError {
            print("localized error description \(error.localizedDescription)")
        }
    }
}

