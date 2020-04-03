//
//  ViewController.swift
//  AlisverisListesiDemo
//
//  Created by Hasan Ali on 3.04.2020.
//  Copyright © 2020 Hasan Ali Şişeci. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    var alisverisListesi : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Alışveriş Listesi"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //Add Button
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        addButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = addButton
        
       //Edit Button (Hazır bir buton kullancağız)
            let editButton = editButtonItem
            editButton.tintColor = UIColor.black
            self.navigationItem.leftBarButtonItem = editButton
            
            loadData()
        }
        
        //Edit için hazır bir fonksiyon
        override func setEditing(_ editing: Bool, animated: Bool) {
            super.setEditing(editing, animated: animated)
            tableView.setEditing(editing, animated: animated)
        }
        
        //TableView içini editleyebilmemiz için bir hazır fonksiyon daha
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                alisverisListesi.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.middle)
            }
            saveData()
        }
    
    @objc func addButtonClicked() {
        //Alerti Oluşturmak
        let alert = UIAlertController(title: "Ürün Ekle", message: "Eklemek istediğiniz ürünü giriniz : ", preferredStyle: UIAlertController.Style.alert)
        //Alert'e textField'ı ekliyoruz
        alert.addTextField(configurationHandler: { txtMarkaAdi in
            txtMarkaAdi.placeholder = "Alışveriş Listesine Eklenecek Ürün"
        })
        //Alert Butonları
            //Alert'in içindeki Ekle Butonu
        let addButton = UIAlertAction(title: "Ekle", style: UIAlertAction.Style.default, handler: { action in
            //Ekle butona tıklandığında olmasını istediğimiz olay
            let firstTextField = alert.textFields![0] as UITextField
            self.elemanEkle(alinacakEleman: firstTextField.text!)
        })
            //Alert'in içindeki İptal Butonu
        let cancelButton = UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel, handler: nil)
        
        //Butonları alert'e ekleme
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        
        //Alert'i göstermek için gerekli fonksiyon
        self.present(alert,animated: true,completion: nil)
        saveData()
    }
    
    
    func elemanEkle(alinacakEleman : String) {
        //Yeni elemanı dizimize dahil diyoruz
        alisverisListesi.insert(alinacakEleman, at: 0)
        
        //Tabloya Ekleme
        let indexPath : IndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.right)
        saveData()
    }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return alisverisListesi.count
         }
         
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = UITableViewCell()
           cell.textLabel?.text = alisverisListesi[indexPath.row]
           return cell
         }
    
    func saveData() {
        UserDefaults.standard.set(alisverisListesi, forKey: "alisverisListesi")
    }
    
    func loadData() {
        if let loadedData : [String] = UserDefaults.standard.value(forKey: "alisverisListesi") as? [String] {
            alisverisListesi = loadedData
        }
        
        tableView.reloadData()
        
    }

}

