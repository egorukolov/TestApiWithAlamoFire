//
//  CharacterViewController.swift
//  TestApiWithAlamoFire
//
//  Created by Egor Ukolov on 10.07.2024.
//

import UIKit
import Alamofire

class CharacterViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    
        NetworkManager.shared.fetchCharacter { result in
            switch result {
            
            case .success(let character):
                DispatchQueue.main.async {
                    self.updateUI(with: character)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError(error)
                }
            }
        }
    }
    
    func updateUI(with character: Character) {
        nameLabel.text = "Name: \(character.name)"
        statusLabel.text = "Status: \(character.status)"
        speciesLabel.text = "Species: \(character.species)"
        typeLabel.text = "Type: \(character.type)"
        genderLabel.text = "Gender: \(character.gender)"
        
        AF.request(character.image).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                        self.activityIndicator.stopAnimating()
                    }
                }
            case .failure(let error):
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
            }
        }
    }
    
    func showError(_ error: Error) {
        print(error.localizedDescription)
        activityIndicator.stopAnimating()
    }
}

// 0. Привести в порядок структуру файлов приложения
// 1. Перенести загрузку данных в NetworkManager
// 2. Реализовать UIAlertController при ошибке
// 3. Реализовать получение списка персонажей, отображенных в таблице на первом экране
// 4. Реализовать иконку перснажа слева от его имени в ячейки таблицы

// Прописать везде структуру классов через MARK:
