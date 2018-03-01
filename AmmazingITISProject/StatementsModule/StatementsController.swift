//
//  StatementsController.swift
//  AmmazingITISProject
//
//  Created by Ildar Zalyalov on 28.02.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class StatementsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let detailIdetifier = "detail"
    let createIdentifier = "create"
    
    lazy var dataSource: [StatementModel] = {
       
        var data = [StatementModel]()
        let statement = StatementModel(title: "Заявление на повышение очень мега важное реально нужно рассмотреть!!!!!111!!!!!!!", image: #imageLiteral(resourceName: "image"), category: "Хотелки", date: "28.02.18")
        let statement2 = StatementModel(title: "Заявление на повышение", image: #imageLiteral(resourceName: "image"), category: "Хотелки", date: "28.02.18")
        let statement3 = StatementModel(title: "Заявление на повышение", image: #imageLiteral(resourceName: "image"), category: "Хотелки", date: "28.02.18")
        let statement4 = StatementModel(title: "Заявление на повышение", image: #imageLiteral(resourceName: "image"), category: "Хотелки", date: "28.02.18")
        let statement5 = StatementModel(title: "Заявление на повышение", image: #imageLiteral(resourceName: "image"), category: "Хотелки", date: "28.02.18")
        
        data.append(statement)
        data.append(statement2)
        data.append(statement3)
        data.append(statement4)
        data.append(statement5)
        
        return data
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "StatementCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        obtainSavedData()
    }
    
    
    func obtainSavedData() {
        
        if let decode = UserDefaults.standard.object(forKey: "data") as? Data {
            let savedModels = NSKeyedUnarchiver.unarchiveObject(with: decode) as! [StatementModel]
            
            dataSource.append(contentsOf: savedModels)
        }
        
        dataSource.reverse()
        
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == createIdentifier {
            
        }
        else if segue.identifier == detailIdetifier{
            
            guard let model = sender as? StatementModel else  { return }
            
            let destController = segue.destination as! StatementDetailController
            destController.model = model
        }
    }
    
    
    //MARK: Buttons action
    @IBAction func addButtonPressed(_ sender: Any) {
        
    }
    
    
}

extension StatementsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! StatementCell
        
        let model = dataSource[indexPath.row]
        
        cell.configureCell(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = dataSource[indexPath.row]
        performSegue(withIdentifier: detailIdetifier, sender: model)
    }
}

