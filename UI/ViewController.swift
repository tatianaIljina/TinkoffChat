//
//  ViewController.swift
//  UI
//
//  Created by Татьяна Ильина on 28.09.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var loadPhoto: UIButton!
    @IBAction func loadPhotoAction(_ sender: Any) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        present(sheet, animated: true, completion: nil)
        let importPhoto = UIAlertAction(title: "Установить из галлереи", style: .destructive) { (action) in
            let image = UIImagePickerController()
            image.delegate = self
   
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            image.allowsEditing = false
            self.present(image, animated: true)
            {
                print("Фотография выбрана")

            }
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
                self.dismiss(animated: true, completion: nil)
            }
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
                guard let selectedImage = UIImagePickerController.InfoKey.originalImage as? UIImage else {
                    fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")}
                self.profileImage.image = selectedImage
                self.dismiss(animated: true, completion: nil)
            }
            
//            func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//                if let selectedImage = UIImagePickerController.InfoKey.originalImage as? UIImage  {
//                    self.profileImage.image = selectedImage
//                }
//                else{
//                    print("ERROR!!!")
//                }
//                self.dismiss(animated: true, completion: nil)
//            }
            
        }
        let makePhoto = UIAlertAction(title: "Сделать фото", style: .destructive) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                let image = UIImagePickerController()
                image.delegate = self
                image.sourceType = UIImagePickerController.SourceType.camera
                image.allowsEditing = false
                self.present(image, animated: true)
                {
                    print("Фотография выбрана")
                
                }
                
            }
        }
        sheet.addAction(importPhoto)
        sheet.addAction(makePhoto)
        print ("Выберите изображение профиля")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
        super.init(nibName: nil, bundle: nil)
        let frameI = editButton.frame //не выводится, потому что кнопки еще нет
        print(frameI)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let modelName = UIDevice.current.name //в качестве симулятора
        print(modelName)
        let frameVDL = editButton.frame
        print(frameVDL)
        editButton.layer.cornerRadius = 10
        editButton.layer.borderWidth = 1.0
        editButton.clipsToBounds =  true
        nameLabel.font = UIFont.boldSystemFont(ofSize: 29.0)
        profileImage.layer.cornerRadius = 30
        profileImage.layer.masksToBounds = true
        loadPhoto.setTitle(" ", for: UIControl.State.normal)
        loadPhoto.layer.cornerRadius = 30
        loadPhoto.layer.masksToBounds = true
        loadPhoto.imageEdgeInsets = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let frameVDA = editButton.frame
        print(frameVDA) //значения разные поскольку метод viewDidLoad берет размеры из storyboard, а viewDidAppear размеры уже реального устройства
    }
    
    
    
    
}

