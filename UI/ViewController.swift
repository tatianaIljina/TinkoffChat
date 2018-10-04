//
//  ViewController.swift
//  UI
//
//  Created by Татьяна Ильина on 28.09.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var loadPhoto: UIButton!
    let imagePicker = UIImagePickerController()
    @IBAction func loadPhotoAction(_ sender: Any) {
        let sheet = UIAlertController(title: "Add photo", message: nil, preferredStyle: .actionSheet)
        let importPhoto = UIAlertAction(title: "Установить из галлереи", style: .destructive) { (action) in self.openGallery()}
        let makePhoto = UIAlertAction(title: "Сделать снимок", style: .destructive) { (action) in self.openCamera()}
        
        sheet.addAction(importPhoto)
        sheet.addAction(makePhoto)
        
        print ("Выберите изображение профиля")
        
        self.present(sheet, animated: true)
        
    }

    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            let warning = UIAlertController(title: "Не могу открыть галерею", message: nil, preferredStyle: .alert)
            warning.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(warning, animated: true)
    }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true)
        }
        else {
            let warning = UIAlertController(title: "Не могу открыть камеру", message: nil, preferredStyle: .alert)
            warning.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(warning, animated: true)
        }
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

    
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
            self.profileImage.image = selectedImage
        
            self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

    
    


