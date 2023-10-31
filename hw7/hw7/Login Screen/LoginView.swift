//
//  LoginView.swift
//  hw7
//
//  Created by 陈可轩 on 2023/10/30.
//

import UIKit

class LoginView: UIView {

    var labelEmail: UILabel!
    var textFieldEmail: UITextField!
    var labelPassword: UILabel!
    var textFieldPassword: UITextField!
    var buttonLogin: UIButton!
    var buttonRegister: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    
        setupLabelEmail()
        setupLabelPassword()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonLogin()
        setupButtonRegister()
        
        initConstraints()
        
    }
    
    
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.textAlignment = .left
        labelEmail.text = "Email: "
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func setupLabelPassword() {
        labelPassword = UILabel()
        labelPassword.textAlignment = .left
        labelPassword.text = "Password: "
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPassword)
    }
    
    func setupTextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setupTextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupButtonLogin() {
        buttonLogin = UIButton(type: .system)
        buttonLogin.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogin)
    }
    
    func setupButtonRegister() {
        buttonRegister = UIButton(type: .system)
        buttonRegister.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonRegister.setTitle("Register here!", for: .normal)
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonRegister)
    }

    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            labelEmail.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            labelEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            labelEmail.trailingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.topAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo: labelEmail.trailingAnchor, constant: -120),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            textFieldEmail.heightAnchor.constraint(equalTo: labelEmail.heightAnchor),
            textFieldEmail.widthAnchor.constraint(lessThanOrEqualTo: labelEmail.widthAnchor),
            
            labelPassword.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 32),
            labelPassword.leadingAnchor.constraint(equalTo: labelEmail.leadingAnchor),
            labelPassword.trailingAnchor.constraint(equalTo: labelEmail.trailingAnchor),
            
            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.topAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: textFieldEmail.leadingAnchor),
            textFieldPassword.trailingAnchor.constraint(equalTo: textFieldEmail.trailingAnchor),
            
            buttonLogin.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 50),
            buttonLogin.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonRegister.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 16),
            buttonRegister.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
