//
//  Register.swift
//  hw7
//
//  Created by 陈可轩 on 2023/10/30.
//

import UIKit

class RegisterView: UIView {
    var labelName: UILabel!
    var textFieldName: UITextField!
    var labelEmail: UILabel!
    var textFieldEmail: UITextField!
    var labelPassword: UILabel!
    var textFieldPassword: UITextField!
    var buttonRegister: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupLabelName()
        setupTextFieldName()
        setupLabelEmail()
        setupLabelPassword()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonRegister()

        initConstraints()

    }

    func setupLabelName() {
        labelName = UILabel()
        labelName.textAlignment = .left
        labelName.text = "Name: "
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }

    func setupTextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.borderStyle = .roundedRect
        textFieldName.keyboardType = .emailAddress
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }


    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.textAlignment = .left
        labelEmail.text = "Email: "
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }

    func setupTextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }

    func setupLabelPassword() {
        labelPassword = UILabel()
        labelPassword.textAlignment = .left
        labelPassword.text = "Password: "
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPassword)
    }


    func setupTextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }

    func setupButtonRegister() {
        buttonRegister = UIButton(type: .system)
        buttonRegister.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonRegister)
    }


    func initConstraints() {
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            labelName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            labelName.trailingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor),

            textFieldName.topAnchor.constraint(equalTo: labelName.topAnchor),
            textFieldName.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: -120),
            textFieldName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            textFieldName.heightAnchor.constraint(equalTo: labelName.heightAnchor),
            textFieldName.widthAnchor.constraint(lessThanOrEqualTo: labelName.widthAnchor),

            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 32),
            labelEmail.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelEmail.trailingAnchor.constraint(equalTo: labelName.trailingAnchor),

            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.topAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo: textFieldName.leadingAnchor),
            textFieldEmail.trailingAnchor.constraint(equalTo: textFieldName.trailingAnchor),

            labelPassword.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 32),
            labelPassword.leadingAnchor.constraint(equalTo: labelEmail.leadingAnchor),
            labelPassword.trailingAnchor.constraint(equalTo: labelEmail.trailingAnchor),

            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.topAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: textFieldEmail.leadingAnchor),
            textFieldPassword.trailingAnchor.constraint(equalTo: textFieldEmail.trailingAnchor),

            buttonRegister.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            buttonRegister.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
