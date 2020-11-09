//
//  ViewController.swift
//  task2.1
//
//  Created by Elizaveta on 5/10/19.
//  Copyright © 2019 Elizaveta. All rights reserved.
//

import UIKit

struct Album
{
    let image: UIImage
    let name: String
}

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet var regView: UIView!
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var login: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var rPassword: UITextField!
    @IBOutlet var rulesSwitch: UISwitch!
    @IBOutlet var enterButton: UIButton!
    @IBOutlet var warningLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        rPassword.isHidden = true
        warningLabel.text = ""
        collectionView.isHidden = true
        infoLabel.isHidden = true
        infoLabel.text = ""
        readPropertyList()
    }
    
    var plistData: [String: String] = [:]
    var images = ["сomeonover.jpg", "fallingIntoYou.jpg", "jlp.jpg", "spiceWorld.jpg"]
    
    func readPropertyList ()
    {
        var format = PropertyListSerialization.PropertyListFormat.xml
        let plistPath = Bundle.main.path(forResource: "Albums", ofType: "plist")
        let plistXML = FileManager.default.contents(atPath: plistPath!)
        do
        {
            plistData = try PropertyListSerialization.propertyList(from: plistXML!, options: .mutableContainersAndLeaves, format: &format) as! [String: String]
        }
        catch { }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! AlbumCell
        cell.nameLabel.text = Array(plistData.keys).sorted()[indexPath.item]
        cell.image.image = UIImage.init(named: images[indexPath.item])!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        infoLabel.text = Array(plistData.values).sorted()[indexPath.item]
    }
   
    @IBAction func buttonClicked(_ sender: Any) {
        if segment.selectedSegmentIndex == 0
        {
            let udPassword = UserDefaults.standard.object(forKey: self.login.text!)
            if udPassword != nil
            {
                if ((udPassword! as! String).elementsEqual(password.text!)) == true
                {
                    collectionView.isHidden = false
                    infoLabel.isHidden = false
                    regView.isHidden = true
                }
                else
                {
                    warningLabel.text = "Неверный пароль"
                }
            }
            else
            {
                warningLabel.text = "Неверный логин"
            }
            
        }
        else
        {
            if ((login.text?.elementsEqual(""))! || (password.text?.elementsEqual(""))! || (rPassword.text?.elementsEqual(""))!) == false
            {
                if (rPassword.text)!.elementsEqual(password.text!)
                {
                    UserDefaults.standard.set(password.text, forKey: login.text!)
                    collectionView.isHidden = false
                    infoLabel.isHidden = false
                    regView.isHidden = true
                }
                else
                {
                    warningLabel.text = "Пароли не совпадают"
                }
            }
            else
            {
                warningLabel.text = "Заполните все поля"
            }
        }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        if segment.selectedSegmentIndex == 0
        {
            rPassword.isHidden = true
        }
        else
        {
            rPassword.isHidden = false
        }
        warningLabel.text = ""
        login.text = ""
        password.text = ""
        rPassword.text = ""
        enterButton.isEnabled = false
        rulesSwitch.isOn = false
    }
    
    @IBAction func switchTapped(_ sender: Any) {
        enterButton.isEnabled = !enterButton.isEnabled
    }
    
}
