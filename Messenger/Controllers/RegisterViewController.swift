//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Isaac Loez on 09/09/21.
//

import UIKit

class RegisterViewController: UIViewController {

    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user-2")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    //Campo de texto email
    
    private let emailField: UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Correo Electronico.."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let FirstNameField: UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Nombres.."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let lastNameField: UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Apellidos..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordField: UITextField = {
        
        let field2 = UITextField()
        field2.autocapitalizationType = .none
        field2.autocorrectionType = .no
        field2.returnKeyType = .done
        field2.layer.cornerRadius = 12
        field2.layer.borderWidth = 1
        field2.layer.borderColor = UIColor.lightGray.cgColor
        field2.placeholder = "Contraseña..."
        field2.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field2.leftViewMode = .always
        field2.backgroundColor = .white
        field2.isSecureTextEntry = true
        return field2
    }()
    
    private let loginButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Registrar", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        view.backgroundColor = .white
        //Boton de registrar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Registrar",
                                                            style: .done,
                                                            target: self,
                                                             action: #selector(didTapRegister))
        
        loginButton.addTarget(self, action: #selector(registerButtonTapped),
                              for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //Añadir subvistas
        view.addSubview(scrollView)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(FirstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(loginButton)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapChangePic))
        imageView.addGestureRecognizer(gesture)
        
    }
    
    @objc private func didTapChangePic() {
        presentPhotoActionSheet()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        imageView.layer.cornerRadius = imageView.width/2.0
        
        
        FirstNameField.frame = CGRect(x: 30,
                                  y: imageView.bottom+10,
                                  width: scrollView.width-60,
                                 height: 52)
        lastNameField.frame = CGRect(x: 30,
                                     y: FirstNameField.bottom+10,
                                  width: scrollView.width-60,
                                 height: 52)
        emailField.frame = CGRect(x: 30,
                                  y:  lastNameField.bottom+10,
                                  width: scrollView.width-60,
                                 height: 52)
        passwordField.frame = CGRect(x: 30,
                                  y: emailField.bottom+10,
                                  width: scrollView.width-60,
                                 height: 52)
        
        loginButton.frame = CGRect(x: 30,
                                      y: passwordField.bottom+10,
                                      width: scrollView.width-60,
                                     height: 52)
    }
    
    @objc private func registerButtonTapped() {
        
        passwordField.resignFirstResponder()
        emailField.resignFirstResponder()
        FirstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        
     
        
        guard let firstName = FirstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let pasword = passwordField.text,
              !email.isEmpty,
              !pasword.isEmpty,
              !firstName.isEmpty,
              !lastName.isEmpty,
              pasword.count >= 6 else {
            alertUserLoginError()
            return
        }
        //Firebase login
        
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Opsss",
                                      message: "Por favor ponga toda la información para crear la nueva cuenta",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
        
    }
    
    @objc private func didTapRegister() {
        //manda a la pantalla de registrar
        let vc = RegisterViewController()
        vc.title = "Crear cuenta"
        navigationController?.pushViewController(vc, animated: true)
    }
  

}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField{
            passwordField.becomeFirstResponder()
        } else if textField == passwordField{
            registerButtonTapped()
        }
        return true
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Imagen de perfil",
                                            message: "Como te gustaria seleccionar la imagen?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancelar",
                                            style: .cancel,
                                            handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Tomar foto",
                                            style: .default,
                                            handler: {[weak self] _  in
                                                self?.presentCamara()
                                                
                                            } ))
        actionSheet.addAction(UIAlertAction(title: "Elegir foto",
                                            style: .default,
                                            handler: {[weak self] _ in
                                                self?.presentPhotoPicker()
                                                
                                            }))
        present(actionSheet, animated: true)
        
    }
    
    func presentCamara(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
        
    }
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = selectImage
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
}
