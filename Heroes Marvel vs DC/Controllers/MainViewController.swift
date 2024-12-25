//
//  ViewController.swift
//  Heroes Marvel vs DC
//
//  Created by Nikita Putilov on 11.12.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - UI elements
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.8
        return imageView
    }()
    
    private var petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noName")
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var catButton: UIButton = {
        let button = UIButton(type: .custom)
        let image =  UIImage(named: "catBackground")
        button.setBackgroundImage(image, for: .normal)
        button.setTitle("CAT", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tag = 0
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var dogButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "dogBackground")
        button.setBackgroundImage(image, for: .normal)
        button.setTitle("DOG", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tag = 1
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private var codeArray: [Int] = [201, 102313, 23200, 101, 203, 202, 205, 226, 204, 207, 218, 206, 100, 208, 402, 400, 102, 505, 406, 401, 407, 404, 408, 418, 405, 403, 409, 300, 301, 302, 303, 304, 305, 306, 307, 308, 410, 411, 412, 413, 414, 415, 417, 416, 420, 421, 422, 423, 424, 425, 428, 426, 429, 430, 431, 440, 444, 449, 450, 451, 460, 463, 524, 464, 497, 496, 495, 498, 494, 499, 500, 502, 501, 503, 506, 507, 508, 509, 510, 511, 521, 527, 419, 504, 999]
    private var petsArray = [UIImage]()
    private var petsCatsArray = [UIImage]()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - Setup
    private func setupViews() {
        view.backgroundColor = .clear
        
        view.addSubview(backgroundImageView)
        view.addSubview(petImageView)
        view.addSubview(catButton)
        view.addSubview(dogButton)
        
        backgroundImageView.frame = view.bounds
    }
    
    private func setupArray(_ array: [UIImage], flag: Bool, animals: String,  label: String) {
        let vc = CollectionViewController()
        vc.petLabel.text = label
        vc.isUsingArray = flag
        vc.petArray.removeAll()
        vc.petArray = array
        
        vc.selectHeroDelegate = self
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 44
        }
        
        present(vc, animated: true)
    }
    
    private func setupFullArray(_ array: [UIImage], flag: Bool, label: String) {
        let vc = CollectionViewController()
        vc.petLabel.text = label
        vc.isUsingArray = flag
        vc.petArray = array
        vc.selectHeroDelegate = self
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 44
        }
        
        present(vc, animated: true)
    }
    
    func fetchAllHTTPPetsImages(pet: String, completion: @escaping() -> Void) {
        codeArray.sort()
        let dispatchGroup = DispatchGroup()
        
        for statusCode in codeArray {
            dispatchGroup.enter()
            print("Началась загрузка")
            
            NetworkRequest.shared.fetchHTTPAnimalsImage(animal: pet, statusCode: statusCode) { code, image in
                guard let image = image else {
                    dispatchGroup.leave()
                    return }
                if pet == "dog" {
                    self.petsArray.append(image)
                } else if pet == "cat" {
                    self.petsCatsArray.append(image)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Все картинки \(pet)")
            completion()
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            if self.petsCatsArray.count == 0 {
                self.fetchAllHTTPPetsImages(pet: "cat") {
                    self.setupArray(self.petsCatsArray, flag: false, animals: "cat", label: "Select CAT hero")
                }
                
            } else {
                self.setupFullArray(self.petsCatsArray, flag: false, label: "Select CAT hero")
            }
        } else {
            if self.petsArray.count == 0 {
                self.fetchAllHTTPPetsImages(pet: "dog") {
                    self.setupArray(self.petsArray, flag: true, animals: "dog", label: "Select DOG hero")
                }
                
            } else {
                self.setupFullArray(self.petsArray, flag: true, label: "Select DOG hero")
            }
        }
    }
}

//MARK: - Constraints
extension MainViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            petImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            petImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            petImageView.widthAnchor.constraint(equalToConstant: view.frame.width - 10),
            petImageView.heightAnchor.constraint(equalToConstant: 420),
            
            catButton.topAnchor.constraint(equalTo: petImageView.bottomAnchor, constant: 30),
            catButton.leadingAnchor.constraint(equalTo: petImageView.leadingAnchor),
            catButton.trailingAnchor.constraint(equalTo: petImageView.centerXAnchor, constant: -10),
            catButton.heightAnchor.constraint(equalToConstant: 65),
            
            dogButton.topAnchor.constraint(equalTo: petImageView.bottomAnchor, constant: 30),
            dogButton.trailingAnchor.constraint(equalTo: petImageView.trailingAnchor),
            dogButton.leadingAnchor.constraint(equalTo: petImageView.centerXAnchor, constant: 10),
            dogButton.heightAnchor.constraint(equalToConstant: 65),
        ])
    }
}

extension MainViewController: SelectHeroProtocol {
    func selectHero(image: UIImage, name: String) {
        petImageView.image = image
    }
}

