//
//  ViewController.swift
//  toDoListAPP
//
//  Created by Berken Özbek on 13.04.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // table view oluşturmak için kullanıldı.
    var tableView: UITableView!
    
    // textfield oluşturmak için kullanıldı.
    var textField: UITextField!
    
    // görevleri bir dizide tutmak için kullanıldı.
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view kurulumu
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        // text field kurulumu
        textField = UITextField(frame: CGRect(x: 90, y: view.bounds.height - 70, width: view.bounds.width - 180, height: 50))
        textField.borderStyle = .roundedRect
        textField.placeholder = "Yeni Görev Ekle..."
        view.addSubview(textField)
        
        // "ekle" butonu kurulumu
        let ekleButonu = UIButton(type: .system)
                ekleButonu.frame = CGRect(x: view.bounds.width - 80, y: view.bounds.height - 70, width: 60, height: 50)
                ekleButonu.setTitle("Ekle", for: .normal)
                ekleButonu.backgroundColor = UIColor(red: 114/255, green: 137/255, blue: 218/255, alpha: 1)
                ekleButonu.layer.cornerRadius = 5
                ekleButonu.setTitleColor(.white, for: .normal)
                ekleButonu.addTarget(self, action: #selector(addTask), for: .touchUpInside)
                view.addSubview(ekleButonu)
        
        // "tümünü temizle" butonu kurulumu
        let temizleButonu = UIButton(type: .system)
                temizleButonu.frame = CGRect(x: 20, y: view.bounds.height - 70, width: 60, height: 50)
                temizleButonu.setTitle("Temizle", for: .normal)
                temizleButonu.backgroundColor = UIColor(red: 114/255, green: 0, blue: 0, alpha: 1)
                temizleButonu.layer.cornerRadius = 5
                temizleButonu.setTitleColor(.white, for: .normal)
                temizleButonu.addTarget(self, action: #selector(clearTasks), for: .touchUpInside)
                view.addSubview(temizleButonu)
    }
    
    // yeni görev eklenip verilerin yenilenmesi sağlandı.
    @objc func addTask() {
        if let text = textField.text, !text.isEmpty {
            tasks.append(text)
            textField.text = ""
            tableView.reloadData()
        }
    }
    
    // tüm görevlerin silinip verilerin yenilenmesi sağlandı.
    @objc func clearTasks() {
        tasks.removeAll()
        tableView.reloadData()
    }
    
    // Table view delegate metodu ile verilen gösterilmesi sağlandı.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // kullanıcının istediği görevi tekrar düzenlemesi sağlandı.
        let alert = UIAlertController(title: "Yeniden Düzenle", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = self.tasks[indexPath.row]
        }
        let kaydet = UIAlertAction(title: "Kaydet", style: .default) { _ in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                self.tasks[indexPath.row] = text
                self.tableView.reloadData()
            }
        }
        let cikis = UIAlertAction(title: "Çıkış", style: .cancel, handler: nil)
        alert.addAction(kaydet)
        alert.addAction(cikis)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // kullanıcının istediği görevi sola kaydırıp silmesi sağlandı.
        return (1 != 0)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // silinen görevin görevler dizisinden silinmesi sağlandı.
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
