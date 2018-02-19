//
//  ViewController.swift
//  Saving Data BayBeh
//
//  Created by Kyle Lee on 7/2/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var objectsRealty = [Realty]()
    var objectsAccount = [Account]()
    var flag = false
    var login = ""
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FillData (value: "Account")
        FillData (value: "Property")
        }
    
    @IBAction func onPlusTapped() {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsRealty.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func LogOutButton(_ sender: UIBarButtonItem) {
        
        for object in objectsAccount {
            if object.status {
                object.status = false
                PersistenceServce.saveContext()
            }
            let vc = storyboard?.instantiateViewController(withIdentifier: "loginView")
            present(vc!, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.addresLabel.text = objectsRealty[indexPath.row].addres
        cell.areaLabel.text = String(objectsRealty[indexPath.row].area)
        cell.priceLabel.text = String(objectsRealty[indexPath.row].price)
        cell.imageCell.image = UIImage(named: "home")
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.height / 2
        
        return cell
    }
    
    func FillData (value: String){
        switch value {
        case "Account": do {
            let fetchRequestAccount: NSFetchRequest<Account> = Account.fetchRequest()
            let objectsDBAccount = try PersistenceServce.context.fetch(fetchRequestAccount)
            self.objectsAccount = objectsDBAccount
            print("\(objectsAccount.count)")
            for object in objectsAccount {
                print("\(String(describing: object.login))")
                if object.status {
                    flag = true
                    login = object.login!
                    break
                }
            }
        } catch {}
        if flag == false{
            let vc = storyboard?.instantiateViewController(withIdentifier: "loginView")
            present(vc!, animated: false, completion: nil)
            }
        case "Property":
        do{
            objectsRealty.removeAll()
            let fetchRequestProperty: NSFetchRequest<Realty> = Realty.fetchRequest()
            let objectsDBProperty = try PersistenceServce.context.fetch(fetchRequestProperty)
            
            
            for object in objectsDBProperty {
                print("\(String(describing: object.accountid))")
                print("\(objectsDBProperty.count)")
                if object.accountid == login {
                    self.objectsRealty.append(object)
                }
            }
            self.tableView.reloadData()
            
        } catch{}
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            let fetchRequestProperty: NSFetchRequest<Realty> = Realty.fetchRequest()
            if let result = try? PersistenceServce.context.fetch(fetchRequestProperty) {
                for object in result {
                    if object.addres == objectsRealty[indexPath.row].addres {
                        PersistenceServce.context.delete(object)
                        PersistenceServce.saveContext()
                        break
                    }
                }
            }
            print("\(objectsRealty.count)")
            objectsRealty.remove(at: indexPath.row)
            print("\(objectsRealty.count)")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
            let destinationController = segue.destination as! AddViewController
            destinationController.objectsRealty = objectsRealty
            destinationController.objectsAccount = objectsAccount
            
        }
        if segue.identifier == "presentSegue" {
            let destinationController = segue.destination as! PresentViewController
            if let Index = tableView.indexPathForSelectedRow {
                destinationController.realty = self.objectsRealty[Index.row]
            }
        }
    }
}


