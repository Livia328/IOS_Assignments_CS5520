//
//  ProfileViewController.swift
//  hw7
//
//  Created by 陈可轩 on 2023/10/30.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    
    let profileScreen = ProfileView()
    
    let defaults = UserDefaults.standard
    
    let notificationCenter = NotificationCenter.default
    
    var token = ""

    override func loadView() {
        view = profileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // set the text of the label
        getProfile()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Log out", style: .plain, target: self,
            action: #selector(onLogoutButtonTapped)
        )

    }
    
    // log out
    @objc func onLogoutButtonTapped() {
        // Display an alert to confirm deletion
        let alertController = UIAlertController(title: "Log out", message: "Are you sure you want to Log out?", preferredStyle: .alert)
        
        // Add "Cancel" and "Delete" actions to the alert
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] (action) in
            // Handle the deletion logic here
            self?.logout()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    // call the logout function
    func logout() {
        if let url = URL(string: APIConfigs.baseURL + "auth/logout"){
            AF.request(url, method: .get)
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
                                // remove the default
                                self.defaults.removeObject(forKey: "user_token")
                                // notificate the mainscreen that user logged out
                                self.notificationCenter.post(name: .userLoggedout, object: nil)
                                self.navigationController?.popViewController(animated: true)
                                break
                    
                            case 400...499:
                            //MARK: the request was not valid 400-level...
                                print(data)
                                break
                    
                            default:
                            //MARK: probably a 500-level error...
                                print(data)
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
    
    func getProfile() {
        if let url = URL(string: APIConfigs.baseURL + "auth/me"){
            AF.request(url, method: .get,
                       headers: [
                        "x-access-token": token
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
                                        .decode(User.self, from: data)
                                        
                                    // show the data on the screen
                                    self.profileScreen.labelID.text = "ID: \(receivedData._id)"
                                    self.profileScreen.labelName.text = "Name: \(receivedData.name)"
                                    self.profileScreen.labelEmail.text = "Email: \(receivedData.email)"
                                    
                                }catch{
                                    print("JSON couldn't be decoded.")
                                }
                                break
                    
                            case 400...499:
                            //MARK: the request was not valid 400-level...
                                print(data)
                                break
                    
                            default:
                            //MARK: probably a 500-level error...
                                print(data)
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
