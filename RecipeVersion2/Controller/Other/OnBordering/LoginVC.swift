//
//  LoginVC.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit
import SafariServices
import FirebaseAuth

class LoginVC: UIViewController {
    
    private let userNameEmailField: UITextField = {
        let textField =  UITextField()
        textField.placeholder = "UserName or Email"
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
        let textField =  UITextField()
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
    
    private let loginButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Terms Of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
       let button =  UIButton()
       button.setTitle("Privacy Policy", for: .normal)
       button.setTitleColor(.secondaryLabel, for: .normal)
       return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create An Account", for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundColor = UIImageView(image: UIImage(named: ""))
        backgroundColor.contentMode = .scaleAspectFit
        header.addSubview(backgroundColor)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)

        userNameEmailField.delegate = self
        passwordField.delegate = self
        
        addSubViews()
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frames
        headerView.frame = CGRect(
                                  x: 0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.height/3.0)
        
        userNameEmailField.frame = CGRect(
                                  x: 25,
                                  y: headerView.bottom + 40,
                                  width: view.width - 50,
                                  height: 52.0)
        
        passwordField.frame = CGRect(
                                  x: 25,
                                  y: userNameEmailField.bottom + 10,
                                  width: view.width - 50,
                                  height: 52.0)
        
        loginButton.frame = CGRect(
                                  x: 25,
                                  y: passwordField.bottom + 10,
                                  width: view.width - 50,
                                  height: 52.0)
        
        createAccountButton.frame = CGRect(
                                  x: 25,
                                  y: loginButton.bottom + 10,
                                  width: view.width - 50,
                                  height: 52.0)
        
        termsButton.frame = CGRect(
                                  x: 10,
                                  y: view.height - view.safeAreaInsets.bottom - 100,
                                  width: view.width - 20,
                                  height: 50)
        
        privacyButton.frame = CGRect(
                                  x: 10,
                                  y: view.height - view.safeAreaInsets.bottom - 50,
                                  width: view.width - 20,
                                  height: 50)
        
        configurationHeaderView()
    }
    
    private func configurationHeaderView() {
        
        guard headerView.subviews.count == 1 else { return }
        guard let backgroundView = headerView.subviews.first else { return }
        backgroundView.frame = headerView.bounds
        
        // Add  Logo
        let imageView = UIImageView(image: UIImage(named: AppImages.logo))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width / 4.9,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width / 1.75,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubViews() {
        
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    @objc private func didTapLoginButton() {
        
        passwordField.resignFirstResponder()
        userNameEmailField.resignFirstResponder()
        
        guard let userNameEmail = userNameEmailField.text, !userNameEmail.isEmpty,
            let password = passwordField.text, !password.isEmpty, password.count >= 6 else {
                simpleAlert(title: "", message: "Password Shoud be 6 Characters")
                return
        }
        
        // login functionallity
        var userName: String?
        var email: String?
        
        if userNameEmail.contains("@"), userNameEmail.contains(".") {
            // email
            email = userNameEmail
        } else {
            // userName
            userName = userNameEmail
        }
        
        AuthManager.shared.loginUser(userName: userName, email: email, password: password) { success in
            
            DispatchQueue.main.async {
                
            if success {
                    // user log in
                self.dismiss(animated: true, completion: nil)
                } else {
                    // error occurred
                self.simpleAlert(title: "error", message: "error")
                }
            }
        }
    }
    
    @objc private func didTapTermsButton() {
        
        guard let url = URL(string: "https://www.gov.uk/help/terms-conditions") else { return }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true, completion: nil)
    }
    
    @objc private func didTapPrivacyButton() {
        
        guard let url = URL(string: "https://www.gov.uk/data-protection") else { return }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true, completion: nil)
    }
    
    @objc private func didTapCreateAccountButton() {
        
        let viewController = RegisterVC()
        viewController.title = "Create Account"
        present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userNameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
}
