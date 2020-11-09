//
//  ViewController.swift
//  GreenhouseApp
//
//  Created by Elizaveta on 5/31/19.
//

import UIKit
import MapKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var signSegment: UISegmentedControl!
    @IBOutlet var loginField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var rPasswordField: UITextField!
    @IBOutlet var enterButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var rulesSwitch: UISwitch!
    @IBOutlet var regView: UIView!
    @IBOutlet var menuView: UIView!
    
    public var getTable: (() -> [NSManagedObject])?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rPasswordField.isHidden = true
        errorLabel.text = ""
        menuView.isHidden = true
        menuView.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "menuBackground")!)
    }
    
    @IBAction func makeButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "makeSegue", sender: loginField.text)
    }
    
    @IBAction func mapButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "mapSegue", sender: self)
    }
    
    @IBAction func ordersButtonClicked(_ sender: Any) {
          /*let table = getTable()
          performSegue(withIdentifier: "ordersSegue", sender: table)*/ //no comment after table != nill
         performSegue(withIdentifier: "ordersSegue", sender: self)
        
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        if signSegment.selectedSegmentIndex == 0
        {
            rPasswordField.isHidden = true
        }
        else
        {
            rPasswordField.isHidden = false
        }
        errorLabel.text = ""
        loginField.text = ""
        passwordField.text = ""
        rPasswordField.text = ""
        enterButton.isEnabled = false
        rulesSwitch.isOn = false
    }
    
    @IBAction func switchTapped(_ sender: Any) {
        enterButton.isEnabled = !enterButton.isEnabled
    }
    
    
    @IBAction func enterTapped(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if signSegment.selectedSegmentIndex == 0
        {
            //let udPassword = UserDefaults.standard.object(forKey: self.loginField.text!)
            let udPassword = AuthorizationEntity(persistentContainer: (appDelegate?.persistentContainer)!, login: self.loginField.text!).password()
            if udPassword != nil
            {
                if ((udPassword! as! String).elementsEqual(passwordField.text!)) == true
                {
                    
                    regView.isHidden = true
                    menuView.isHidden = false
                }
                else
                {
                    errorLabel.text = "Incorrect password"
                }
            }
            else
            {
                errorLabel.text = "Incorrect login"
            }
            
        }
        else
        {
            if ((loginField.text?.elementsEqual(""))! || (passwordField.text?.elementsEqual(""))! || (rPasswordField.text?.elementsEqual(""))!) == false
            {
                if (rPasswordField.text)!.elementsEqual(passwordField.text!)
                {
                    //UserDefaults.standard.set(passwordField.text, forKey: loginField.text!)
                    var _: AuthorizationEntity = AuthorizationEntity(persistentContainer: (appDelegate?.persistentContainer)!, login: loginField.text!, password: passwordField.text!)
                    var _: UserEntity = UserEntity(persistentContainer: (appDelegate?.persistentContainer)!, login: loginField.text!)
                    regView.isHidden = true
                    menuView.isHidden = false
                }
                else
                {
                    errorLabel.text = "Passwords aren't the same"
                }
            }
            else
            {
                errorLabel.text = "Fill all fields"
            }
        }
    }
}
