//
//  RegisterVC.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    private let userNameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "User Name"
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    private let emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    private let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.returnKeyType = .continue
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(userNameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        view.addSubview(cancelButton)
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let x: CGFloat = 20
        let width: CGFloat = view.width - 40
        let height: CGFloat = 50
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        
        userNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        userNameField.frame = CGRect(x: x, y: view.safeAreaInsets.top + 80, width: width, height: height)
        emailField.frame = CGRect(x: x, y: userNameField.bottom + 16, width: width, height: height)
        passwordField.frame = CGRect(x: x, y: emailField.bottom + 16, width: width, height: height)
        registerButton.frame = CGRect(x: x, y: passwordField.bottom + 16, width: width, height: height)
        cancelButton.frame = CGRect(x: x, y: registerButton.bottom + 16, width: width, height: height)
    }
    
    @objc private func didTapCancel() {
        
        dismiss(animated: true, completion: nil)
    }
    
    // Register new users
    @objc private func didTapRegister() {
        
        userNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 6,
              let user = userNameField.text, !user.isEmpty else {
            
            self.simpleAlert(title: "Error", message: "Please fill out all fields and password should be 6 characters")
            return
        }
        
        AuthManager.shared.registerNewUser(userName: user, email: email, password: password) { registered in
            
            DispatchQueue.main.async {
                
                if registered {
                    // good to go
                    let viewController = HomeVC()
                    self.navigationController?.pushViewController(viewController, animated: true)
                } else {
                    // failed
                    self.simpleAlert(title: "Error", message: "try again please")
                }
            }
        }
    }
}

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userNameField {
            emailField.becomeFirstResponder()
            
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
            
        } else {
            didTapRegister()
        }
        return true
    }
}
