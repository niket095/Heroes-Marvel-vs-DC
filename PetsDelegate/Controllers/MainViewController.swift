//
//  ViewController.swift
//  PetsDelegate
//
//  Created by Nikita Putilov on 11.12.2024.
//

import UIKit

enum PetType: String {
    case cat = "cat"
    case dog = "dog"
}

class MainViewController: UIViewController {
    
    //MARK: - UI elements
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.Images.mainBackground)
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.8
        return imageView
    }()
    
    private let dimmingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black.withAlphaComponent(0.5)
        imageView.isHidden = true
        return imageView
    }()
    
    private var petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.Images.noNameBackground)
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var catButton: UIButton = {
        let button = UIButton(type: .custom)
        let image =  UIImage(named: Constants.Images.catButtonBackground)
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
        let image = UIImage(named: Constants.Images.dogButtonBackground)
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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private var codeArray: [Int] = [201, 102313, 23200, 101, 203, 202, 205, 226, 204, 207, 218, 206, 100, 208, 402, 400, 102, 505, 406, 401, 407, 404, 408, 418, 405, 403, 409, 300, 301, 302, 303, 304, 305, 306, 307, 308, 410, 411, 412, 413, 414, 415, 417, 416, 420, 421, 422, 423, 424, 425, 428, 426, 429, 430, 431, 440, 444, 449, 450, 451, 460, 463, 524, 464, 497, 496, 495, 498, 494, 499, 500, 502, 501, 503, 506, 507, 508, 509, 510, 511, 521, 527, 419, 504, 999]
    private var petsDogsArray = [UIImage]()
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
        
        view.addSubview(dimmingImageView)
        view.addSubview(activityIndicator)
        
        dimmingImageView.frame = view.bounds
        backgroundImageView.frame = view.bounds
    }
    
    private func setupArray(_ array: [UIImage], animals: String,  label: String) {
        let vc = CollectionViewController()
        vc.petLabel.text = label
        vc.petArray.removeAll()
        vc.petArray = array
        
        vc.selectPetDelegate = self
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 44
        }
        
        present(vc, animated: true)
    }
    
    private func setupFullArray(_ array: [UIImage], label: String) {
        let vc = CollectionViewController()
        vc.petLabel.text = label
        vc.petArray = array
        vc.selectPetDelegate = self
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 44
        }
        
        present(vc, animated: true)
    }
    
    //MARK: - Network
    func fetchAllHTTPPetsImages(pet: String, completion: @escaping() -> Void) {
        dimmingImageView.isHidden = false
        activityIndicator.startAnimating()
        
        codeArray.sort()
        let dispatchGroup = DispatchGroup()
        
        for statusCode in codeArray {
            dispatchGroup.enter()
            print("Началась загрузка")
            
            NetworkRequest.shared.fetchHTTPAnimalsImage(animal: pet, statusCode: statusCode) { code, image in
                guard let image = image else {
                    dispatchGroup.leave()
                    return }
                if pet == PetType.dog.rawValue {
                    self.petsDogsArray.append(image)
                } else if pet == PetType.cat.rawValue {
                    self.petsCatsArray.append(image)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Все картинки \(pet)")
            self.dimmingImageView.isHidden = true
            self.activityIndicator.stopAnimating()
            completion()
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            if self.petsCatsArray.count == 0 {
                self.fetchAllHTTPPetsImages(pet: PetType.cat.rawValue) {
                    self.setupArray(self.petsCatsArray, animals: "cat", label: "Select CAT error")
                }
            } else {
                self.setupFullArray(self.petsCatsArray, label: "Select CAT error")
            }
        } else {
            if self.petsDogsArray.count == 0 {
                self.fetchAllHTTPPetsImages(pet: PetType.dog.rawValue) {
                    self.setupArray(self.petsDogsArray, animals: "dog", label: "Select DOG error")
                }
            } else {
                self.setupFullArray(self.petsDogsArray, label: "Select DOG error")
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
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

//MARK: - SelectPetProtocol
extension MainViewController: SelectPetProtocol {
    func selectPet(image: UIImage, name: String) {
        petImageView.image = image
    }
}

