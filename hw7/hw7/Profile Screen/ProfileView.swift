//
//  ProfileView.swift
//  hw7
//
//  Created by 陈可轩 on 2023/10/30.
//

import UIKit

class ProfileView: UIView {
    var labelProfile: UILabel!
    var labelID: UILabel!
    var labelName: UILabel!
    var labelEmail: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupLabelProfile()
        setupLabelID()
        setupLabelName()
        setupLabelEmail()
        
        initConstraints()
        
    }
    
    func setupLabelProfile() {
        labelProfile = UILabel()
        labelProfile.text = "Profile"
        labelProfile.font = UIFont.boldSystemFont(ofSize: 32)
        labelProfile.textAlignment = .center
        labelProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelProfile)
    }
    
    func setupLabelID() {
        labelID = UILabel()
        labelID.textAlignment = .center
        labelID.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelID)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.textAlignment = .center
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.textAlignment = .center
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func initConstraints() {
        // Constraints for labelProfile (centered both horizontally and vertically)
        NSLayoutConstraint.activate([
            labelProfile.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelProfile.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        // Constraints for labelID
        NSLayoutConstraint.activate([
            labelID.topAnchor.constraint(equalTo: labelProfile.bottomAnchor, constant: 60),
            labelID.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labelID.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])

        // Constraints for labelName
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: labelID.bottomAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labelName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])

        // Constraints for labelEmail
        NSLayoutConstraint.activate([
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            labelEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labelEmail.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }


    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
