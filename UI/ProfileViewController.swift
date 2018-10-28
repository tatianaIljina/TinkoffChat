//
//  ViewController.swift
//  UI
//
//  Created by Татьяна Ильина on 28.09.2018.
//  Copyright © 2018 Татьяна Ильина. All rights reserved.
//

import UIKit
class ProfileViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var aboutYourselfLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var loadPhoto: UIButton!
    @IBOutlet var inputNameField: UITextField!
    @IBOutlet var editProfile: UIButton!
    @IBOutlet var saveOperation: UIButton!
    @IBOutlet var saveGCD: UIButton!
    @IBOutlet var inputInfo: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    let imagePicker = UIImagePickerController()
    var isProfileImageEdited = false
    

    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func editProfile(_ sender: UIButton) {
        
        
        //разблокируем кнопку изменения фото
        loadPhoto.isEnabled = true
        loadPhoto.isHidden = false
        
        //покажем кнопки сохранения изменений
        saveGCD.isHidden = false
        saveGCD.isEnabled = true
        
        saveOperation.isHidden = false
        saveOperation.isEnabled = true
        

        saveGCD.clipsToBounds =  true
        saveOperation.clipsToBounds =  true
        
        //скроем кнопку редактировать профиль
        editProfile.isEnabled = false
        editProfile.isHidden = true
        
        //делаем активными для редактрования поля
        inputNameField.isEnabled = true
        inputNameField.borderStyle = UITextField.BorderStyle.roundedRect
        inputInfo.isEnabled = true
        inputInfo.borderStyle = UITextField.BorderStyle.roundedRect
    }
    
    
    @IBAction func saveChangesButton(_ sender: UIButton) {
        if isProfileImageEdited == true || inputNameField.isEditing == true || inputInfo.isEditing == true {
            print("Изменения были сделаны")

            //print(inputNameField.text!)
            let DataManager: DataManager = OperationDataManager()
            DataManager.saveProfile(name: self.inputNameField.text!, info: self.inputInfo.text!,
                                              hasError: { (hasError : Bool ) in
                                                if hasError {
                                                    self.profileNotSaved()
                                                } else {
                                                    self.profileWasSaved()
                                                }
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            self.saveGCD.isEnabled = false
            self.saveOperation.isEnabled = false
            self.loadPhoto.isEnabled = false

        })
        }
        else {
            print ("not changed")
        }
    }
//    func loadInfo(){
//        activityIndicator.isHidden = false
//        activityIndicator.startAnimating()
//        DataManager.loadFromFile
//        inputNameField.text = profile["name"]
//        inputInfo.text = profile["description"])
//    }
    
    
    func profileNotSaved(){
        saveGCD.isEnabled = true
        saveOperation.isEnabled = true
        
        let warning = UIAlertController(title: "Ошибка при сохранении данных", message: nil, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "Отментить", style: .default, handler: nil)
        let tryAgain = UIAlertAction(title: "Попробовать еще раз",style: .default, handler: nil) //{ (action) in функция, которая еще раз сохраняет данные}
        warning.addAction(cancel)
        warning.addAction(tryAgain)
        self.present(warning, animated: true, completion: nil)
        
    }
    
    func profileWasSaved(){
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()

        //убрать кнопки сохранить
        saveGCD.isHidden = true
        saveGCD.isEnabled = false
        
        saveOperation.isHidden = true
        saveOperation.isEnabled = false
        
        //добавить кнопку редактировать
        editProfile.isHidden = false
        editProfile.isEnabled = true
        
        //сделать поля неактивными
        inputInfo.isEnabled = false
        inputInfo.borderStyle = UITextField.BorderStyle.none
        
        inputNameField.isEnabled = false
        inputNameField.borderStyle = UITextField.BorderStyle.none
        
        //убрать кнопку загрузить фото
        loadPhoto.isEnabled = false
        loadPhoto.isHidden = true
        
        let alert = UIAlertController(title: "Данные успешно сохранены", message: nil, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)

//        loadInfo()
    }
    
    private func configureTextFields(){
        inputNameField.delegate = self
        inputInfo.delegate = self
        
    }
    
    private func dismissKeyboard(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    
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
        let frameI = editProfile.frame //не выводится, потому что кнопки еще нет
        print(frameI)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let modelName = UIDevice.current.name //в качестве симулятора
        print(modelName)
        let frameVDL = editProfile.frame
        print(frameVDL)
        editProfile.layer.cornerRadius = 10
        editProfile.layer.borderWidth = 1.0
        editProfile.clipsToBounds =  true
        nameLabel.font = UIFont.boldSystemFont(ofSize: 29.0)
        profileImage.layer.cornerRadius = 30
        profileImage.layer.masksToBounds = true
        loadPhoto.setTitle(" ", for: UIControl.State.normal)
        loadPhoto.layer.cornerRadius = 30
        loadPhoto.layer.masksToBounds = true
        loadPhoto.imageEdgeInsets = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
        configureTextFields()
        dismissKeyboard()
        
        //скрываем кнопки сохранить изменения
        saveGCD.isHidden = true
        saveGCD.isEnabled = false
        
        saveOperation.isHidden = true
        saveOperation.isEnabled = false
        
        //скрываем кнопку загрузить фото
        loadPhoto.isHidden = true
        loadPhoto.isEnabled = false
        
        inputNameField.isEnabled = false
        inputNameField.borderStyle = UITextField.BorderStyle.none
        
        
        inputInfo.isEnabled = false
        inputInfo.borderStyle = UITextField.BorderStyle.none
        
        activityIndicator.isHidden = true
        
        saveGCD.layer.cornerRadius = 10
        saveGCD.layer.borderWidth = 1.0
        
        saveOperation.layer.cornerRadius = 10
        saveOperation.layer.borderWidth = 1.0
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let frameVDA = editProfile.frame
        print(frameVDA) //значения разные поскольку метод viewDidLoad берет размеры из storyboard, а viewDidAppear размеры уже реального устройства
    }
}

    
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
            self.profileImage.image = selectedImage
            self.isProfileImageEdited = true
            self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

    
    


