//
//  PresentViewController.swift
//  Saving Data BayBeh
//
//  Created by Пользователь on 19.02.2018.
//  Copyright © 2018 Kyle Lee. All rights reserved.
//

import UIKit
import CoreData

class PresentViewController: UIViewController {
    
    var realty = Realty()

    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var areaText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var countOfRoomText: UITextField!
    @IBOutlet weak var floorText: UITextField!
    @IBOutlet weak var pricePerSquareMetersText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressText.text = realty.addres
        priceText.text = String(realty.price)
        areaText.text = String(realty.area)
        floorText.text = String(realty.floor)
        countOfRoomText.text = String(realty.countOfRooms)
        pricePerSquareMetersText.text = String(realty.prisePerSquareMeters)
    }
    @IBAction func changeButton(_ sender: UIButton) {
        
        if let button = sender.titleLabel?.text {
            switch button {
            case "Изменить": sender.setTitle("Сохранить", for: .normal)
                addressText.isEnabled = true
                priceText.isEnabled = true
                areaText.isEnabled = true
                floorText.isEnabled = true
                countOfRoomText.isEnabled = true
            case "Сохранить": sender.setTitle("Изменить", for: .normal)
            if updateSaveButtonState() {
                removeObject ()
                let property = Realty(context: PersistenceServce.context)
                property.accountid = self.realty.accountid
                property.addres = addressText.text
                property.area = Double(areaText.text!)!
                property.countOfRooms = Int16(countOfRoomText.text!)!
                property.floor = Int16(floorText.text!)!
                property.price = Double(priceText.text!)!
                property.prisePerSquareMeters = Double(priceText.text!)! / Double(areaText.text!)!
                
                PersistenceServce.saveContext()
                self.dismiss(animated: true, completion: nil)
                }
            default: break
            }
        }
        
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func removeObject (){
        let fetchRequest: NSFetchRequest<Realty> = Realty.fetchRequest()
        do {
            let objectsDB = try PersistenceServce.context.fetch(fetchRequest)

        for object in objectsDB {
            if object.accountid == realty.accountid && object.addres == realty.addres {
                PersistenceServce.context.delete(object)
            }
        }
        } catch {}
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func editingSave(_ sender: UITextField) {
        if(updateSaveButtonState()){changeButton.isEnabled = true} else {changeButton.isEnabled = false}
    }
    
    
     func updateSaveButtonState() -> Bool {
        if (addressText.text!.isEmpty) || (areaText.text!.isEmpty) || (countOfRoomText.text!.isEmpty) || (floorText.text!.isEmpty) || (priceText.text!.isEmpty) {return false}
        return true
    }
    

}
