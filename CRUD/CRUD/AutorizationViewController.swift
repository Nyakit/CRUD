//
//  AutorizationViewController.swift
//  Saving Data BayBeh
//
//  Created by Пользователь on 18.02.2018.
//  Copyright © 2018 Kyle Lee. All rights reserved.
//

import UIKit
import CoreData

class AutorizationViewController: UIViewController {


    var objectsAccount = [Account]()
    
  
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        
        do {
            let objectsDB = try PersistenceServce.context.fetch(fetchRequest)
            self.objectsAccount = objectsDB
        } catch {}
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        if (loginText.text == "") || (passwordText.text == ""){
            Error(title: "Error!!",error: "Поля пусты, хитрец")
            return
        }
        for object in objectsAccount {
            if (object.login == loginText.text) && (object.password == passwordText.text) {
                object.status = true
                self.dismiss(animated: true, completion: nil)
                return
            }
        }
        Error(title: "Error!!",error: "Неверный логин/пароль")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func registrationButton(_ sender: UIButton) {
        if (loginText.text != "") && (passwordText.text != ""){
            let account = Account(context: PersistenceServce.context)
            if checkAccount(login: loginText.text!) {
            account.login = loginText.text
            account.password = passwordText.text
            account.status = false
            PersistenceServce.saveContext()
            self.objectsAccount.append(account)
            }else{
                Error(title: "Error!!",error: "Такой аккаунт уже есть")}
        }else {
            Error(title: "Error!!",error: "Поля пусты, хитрец")
        }
    }
    
    func checkAccount (login: String ) -> Bool {
        for object in objectsAccount {
            if object.login == login {
                return false
            }
        }
        return true
    }
    
    func Error (title: String,error: String) {
        let alertController = UIAlertController(title: title, message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) {(action) in }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
