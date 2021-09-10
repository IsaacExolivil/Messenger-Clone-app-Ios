//
//  LoginViewController.swift
//  Messenger
//
//  Created by Isaac Loez on 09/09/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logomessenger")
        imageView.contentMode = .scaleAspectFit
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
        button.setTitle("Iniciar Sesión", for: .normal)
        button.backgroundColor = .link
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
        
        loginButton.addTarget(self, action: #selector(logingButtonTapped),
                              for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //Añadir subvistas
        view.addSubview(scrollView)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(loginButton)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom+10,
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
    
    @objc private func logingButtonTapped() {
        
        passwordField.resignFirstResponder()
        emailField.resignFirstResponder()
        
        guard let email = emailField.text, let pasword = passwordField.text,
              !email.isEmpty, !pasword.isEmpty, pasword.count >= 6 else {
            
            alertUserLoginError()
            return
        }
        //Firebase login
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pasword, completion: { [weak self ]authResult, error in
            guard let strongSelf = self else {
                return
            }
            
            guard let result = authResult, error == nil else {
                print ("Ocurrio un erro en el email: \(email)")
                return
            }
            
            let user = result.user
            print("Iniciar sesion \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        })
    }
    //Funcion para desplegar alerta
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Opsss",
                                      message: "Por favor ponga toda la información correcta",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Entendido",
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

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField{
            passwordField.becomeFirstResponder()
        } else if textField == passwordField{
            logingButtonTapped()
        }
        return true
    }
    
}
