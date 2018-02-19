    //
//  AddViewController.swift
//  Saving Data BayBeh
//
//  Created by Пользователь on 18.02.2018.
//  Copyright © 2018 Kyle Lee. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var areaText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var countOfRoomsText: UITextField!
    @IBOutlet weak var floorText: UITextField!
    
    @IBAction func editingText(_ sender: UITextField) {
        if(updateSaveButtonState()){saveButton.isEnabled = true} else {saveButton.isEnabled = false}
    }
    
    
    
    
    
    var objectsRealty = [Realty]()

    var objectsAccount = [Account]()
    var login = ""

    
    @IBAction func AddButton(_ sender: Any) {
        print("\(objectsRealty.count)")
        print("\(objectsAccount.count)")
        if checkAddress() {
    let realty = Realty(context: PersistenceServce.context)
        print("\(objectsAccount.count)")
        for object in objectsAccount {
            print("\(String(describing: object.login))")
            if object.status{
                login = object.login!
            }
        }
        
            
        realty.accountid = login
        realty.addres = addressText.text
        realty.area = Double(areaText.text!)!
        realty.countOfRooms = Int16(countOfRoomsText.text!)!
        realty.floor = Int16(floorText.text!)!
        realty.price = Double(priceText.text!)!
        realty.prisePerSquareMeters = Double(priceText.text!)! / Double(areaText.text!)!
        
            PersistenceServce.saveContext()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    private func updateSaveButtonState() -> Bool {
        if (addressText.text!.isEmpty) || (areaText.text!.isEmpty) || (countOfRoomsText.text!.isEmpty) || (floorText.text!.isEmpty) || (priceText.text!.isEmpty) {return false}
        return true
    }
    
    func checkAddress () -> Bool {
        print("\(objectsRealty.count)")
        for object in self.objectsRealty {
            if object.addres == addressText.text {
                self.present(Error(), animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    func Error () -> UIAlertController {
        let alertController = UIAlertController(title: "Error", message: "Объект с таким адресом уже зарегистрирован", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) {(action) in }
        alertController.addAction(action)
        return alertController
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


