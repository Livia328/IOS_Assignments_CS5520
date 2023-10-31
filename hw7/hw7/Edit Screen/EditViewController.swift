//
//  EditViewController.swift
//  hw7
//
//  Created by 陈可轩 on 2023/10/30.
//

import UIKit
import Alamofire

class EditViewController: UIViewController {

    let editScreen = EditView()
    let notificationCenter = NotificationCenter.default
    
    var token = ""
    
    var currentNote_id = ""
    var currentNote_text = ""

    override func loadView() {
        view = editScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // set the textfield as original text
        editScreen.textFieldNote.text = currentNote_text
        editScreen.buttonSave.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)
    }

    // 同时调用add和delete
    @objc func onSaveButtonTapped(){
        if let content = editScreen.textFieldNote.text {
            if !content.isEmpty {
                // call the add a note apis
                editNote()
                
            }
        } else {
            showAlert(text: "Note could not be empty.")
        }
        // self.navigationController?.popViewController(animated: true)
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
    
    func editNote() {
        if let url = URL(string: APIConfigs.baseURL+"note/delete"){
            AF.request(url, method:.post,
                       parameters:
                        [
                            "id": currentNote_id
                        ],
                       headers: [
                       "x-access-token": token
                       ])
                .responseString(completionHandler: { response in
                
                //MARK: retrieving the status code...
                let status = response.response?.statusCode
                
                switch response.result{
                case .success(let data):
                    //MARK: there was no network error...
                    
                    //MARK: status code is Optional, so unwrapping it...
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                            case 200...299:
                                print(data)
                                // Notify the main screen that a contact has been deleted
                                // self.notificationCenter.post(name: .noteDeleted, object: nil)
                                print("Note deleted from database")
                                // add a note
                                self.addNote()
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
    
    func addNote() {
        if let url = URL(string: APIConfigs.baseURL+"note/post"){
            
            // use AF to creat Post request
            // add the body parameters
            AF.request(url, method:.post,
                       parameters:
                        [
                            "text": editScreen.textFieldNote.text
                        ],
                       headers: [
                       "x-access-token": token
                       ])
                .responseString(completionHandler: { response in
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
                                // note the mainscreen to update the data
                                self.notificationCenter.post(name: .noteEdited, object: nil)
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
        }else{
            showAlert(text: "Invalid URL.")
        }
    }

}
