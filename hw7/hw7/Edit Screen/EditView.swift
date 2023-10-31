//
//  DetailsVIew.swift
//  hw7
//
//  Created by 陈可轩 on 2023/10/30.
//

import UIKit


class EditView: UIView {
    var textFieldNote: UITextField!
    var buttonSave: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupTextFieldNote()
        setupButtonSave()

        initConstraints()
    }

    func setupTextFieldNote(){
        textFieldNote = UITextField()
        textFieldNote.borderStyle = .roundedRect
        textFieldNote.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldNote)
    }

    func setupButtonSave(){
        buttonSave = UIButton(type: .system)
        buttonSave.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSave)
    }

    func initConstraints() {
        // Constraints for textFieldNote
        NSLayoutConstraint.activate([
            textFieldNote.centerYAnchor.constraint(equalTo: self.centerYAnchor), // Center vertically
            textFieldNote.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textFieldNote.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])

        // Constraints for buttonSave
        NSLayoutConstraint.activate([
            buttonSave.topAnchor.constraint(equalTo: textFieldNote.bottomAnchor, constant: 16),
            buttonSave.centerXAnchor.constraint(equalTo: self.centerXAnchor) // Center horizontally
        ])
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
