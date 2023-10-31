//
//  RegisterViewController.swift
//  hw7
//
//  Created by 陈可轩 on 2023/10/30.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    let registerScreen = RegisterView()
    let notificationCenter = NotificationCenter.default
    let defaults = UserDefaults.standard
    
    override func loadView() {
        view = registerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        registerScreen.buttonRegister.addTarget(self, action: #selector(onButtonRegisterTapped), for: .touchUpInside)
    }

    @objc
    func onButtonRegisterTapped() {
        // call the register API
        // notice the main screen to update the token data
        // navigationController?.popViewController(animated: true)
        if let name = registerScreen.textFieldName.text,
           let email = registerScreen.textFieldEmail.text,
           let passwordText = registerScreen.textFieldPassword.text{
            if !name.isEmpty && !email.isEmpty && !passwordText.isEmpty {
                if emailIsValid(email) {
                    register(name: name, email: email, password: passwordText)
                } else {
                    showAlert(text: "Invalid Email")
                }
            } else {
                showAlert(text: "Empty Values.")
            }
        } else{
            showAlert(text: "Empty Values.")
        }
    }
    
    func showAlert(text:String){
        let alert = UIAlertController(
            title: "Error",
            message: "\(text)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
    func emailIsValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func register(name: String, email: String, password: String) {
        if let url = URL(string: APIConfigs.baseURL + "auth/register"){
            AF.request(url, method: .post,
                       parameters:
                        [
                            "name": name,
                            "email": email,
                            "password": password
                        ])
            .responseData(completionHandler: { response in
                //MARK: retrieving the status code...
                let status = response.response?.statusCode
                
                switch response.result{
                case .success(let data):
                    //MARK: there was no network error...
                    
                    //MARK: status code is Optional, so unwrapping it...
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                            case 200...299:
                            //MARK: the request was valid 200-level...
                                let decoder = JSONDecoder()
                                do{
                                    let receivedData =
                                        try decoder
                                        .decode(Login.self, from: data)
                                    // set the defaults token
                                    let user_token = receivedData.token
                                    self.defaults.set(user_token, forKey: "user_token")
                                    print("Set self default user_token: \(String(describing: user_token))")
                                    // notificate the main page that user has registered and loggein
                                    self.notificationCenter.post(name: .userRegistered, object: nil)
                                    self.navigationController?.popViewController(animated: true)
                                }catch{
                                    print("JSON couldn't be decoded.")
                                }
                                break
                    
                            case 400...499:
                            //MARK: the request was not valid 400-level...
//                                if uwStatusCode == 401 {
//                                    if let responseText = String(data: data, encoding: .utf8) {
//                                        // expect to show no user found
//                                        print("API response text: \(responseText)")
//                                        self.showAlert(text: "Incorrect password")
//                                    } else {
//                                        print("Response text could not be decoded as UTF-8")
//                                    }
//                                } else if uwStatusCode == 404 {
//                                    if let responseText = String(data: data, encoding: .utf8) {
//                                        // expect to show no user found
//                                        print("API response text: \(responseText)")
//                                        self.showAlert(text: responseText)
//                                    } else {
//                                        print("Response text could not be decoded as UTF-8")
//                                    }
//                                }
                                print(data)
                                break
                    
                            default:
                            //MARK: probably a 500-level error...
                                print(data)
                                self.showAlert(text: "User already existed")
                                break
                    
                        }
                    }
                    break
                    
                case .failure(let error):
                    //MARK: there was a network error...
                    print(error)
                    break
                }
            })
        }
    }

}
