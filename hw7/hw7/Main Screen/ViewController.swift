//
//  ViewController.swift
//  hw7
//
//  Created by 陈可轩 on 2023/10/30.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource {
    
    let defaults = UserDefaults.standard
    
    let allNoteScreen = MainScreenView()
    let loginScreen = LoginView()
    
    var token = ""
    
    let notificationCenter = NotificationCenter.default
    
    var allNotes = [Note]()
    
    var userLoggedIn: Bool = false
    
    override func loadView() {
        view = allNoteScreen
        if userLoggedIn {
            getAllNotes()
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Profile", style: .plain, target: self,
                action: #selector(onProfileButtonTapped)
            )
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Login", style: .plain, target: self,
                action: #selector(onLoginBarButtonTapped)
            )
            let loginController = LoginViewController()
            self.navigationController?.pushViewController(loginController, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        
        allNoteScreen.tableViewNotes.dataSource = self
        allNoteScreen.tableViewNotes.delegate = self
        allNoteScreen.tableViewNotes.separatorStyle = .none
        
        allNoteScreen.buttonAdd.addTarget(self, action: #selector(onButtonAddTapped), for: .touchUpInside)
        
        getAllNotes()
        
        notificationCenter.addObserver(
            self,
            selector: #selector(updatedTabelView(_:)),
            name: .noteEdited,
            object: nil)

        notificationCenter.addObserver(
            self,
            selector: #selector(updatedUserLoggedIn(_:)),
            name: .userLoggedin,
            object: nil)
        
        notificationCenter.addObserver(
            self,
            selector: #selector(updatedUserLoggedout(_:)),
            name: .userLoggedout,
            object: nil)
        
        notificationCenter.addObserver(
            self,
            selector: #selector(updatedUserRegistered(_:)),
            name: .userRegistered,
            object: nil)
        
        
        
        
        // if use is not loggedin, show login button on the right corner
//        if !userLoggedIn {
//            navigationItem.rightBarButtonItem = UIBarButtonItem(
//                title: "Login", style: .plain, target: self,
//                action: #selector(onLoginBarButtonTapped)
//            )
//        } else {
//            navigationItem.rightBarButtonItem = UIBarButtonItem(
//                title: "Profile", style: .plain, target: self,
//                action: #selector(onProfileButtonTapped)
//            )
//        }
        
    }
    
    @objc func updatedTabelView(_ notification: Notification) {
        print("Notification Center is triggered -- UpdateTabelView")
        getAllNotes()
    }
    
    @objc func updatedUserLoggedIn(_ notification: Notification) {
        print("Notification center triggered -- UserLoggedIn")
        userLoggedIn = true
        let tokenSaved = defaults.object(forKey: "user_token") as! String?
        if let token = tokenSaved {
            self.token = token
            print(token)
        }
        // update the view
        loadView()
    }
    
    @objc func updatedUserLoggedout(_ notification: Notification) {
        print("Notification center triggered -- UserLoggedOut")
        userLoggedIn = false
        self.allNotes.removeAll()
        self.allNoteScreen.tableViewNotes.reloadData()
        self.token = ""
        loadView()
    }
    
    @objc func updatedUserRegistered(_ notification: Notification) {
        print("Notification center triggered -- UserRegistered")
        userLoggedIn = true
        let tokenSaved = defaults.object(forKey: "user_token") as! String?
        if let token = tokenSaved {
            self.token = token
        }
        // update the view
        loadView()
    }
             
    // when user typed login button
    // lead to login page
    // ?use notification center to change user loggedin
    @objc func onLoginBarButtonTapped(){
        let loginController = LoginViewController()
        self.navigationController?.pushViewController(loginController, animated: true)
    }
                
    @objc func onProfileButtonTapped(){
        let profileController = ProfileViewController()
        profileController.token = token
        navigationController?.pushViewController(profileController, animated: true)
    }
    
    // when add note button is tapped
    // and using notification that the
    @objc func onButtonAddTapped() {
        if token != "" {
            if let content = allNoteScreen.textViewNote.text {
                if !content.isEmpty {
                    // call the add a note apis
                    addNewNote(content: content)
                    
                }
            } else {
                showAlert(text: "Note could not be empty.")
            }
        } else {
            showAlert(text: "Please login first.")
        }
    }
    
    // call the apis.sakibnm.space:3000/api/note/post
    func addNewNote(content: String) {
        if let url = URL(string: APIConfigs.baseURL+"note/post"){
            // use AF to creat Post request
            // add the body parameters
            AF.request(url, method:.post,
                       parameters:
                        [
                            "text": content
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
                            // get the updated notes by calling getAllNotes()
                            self.getAllNotes()
                            // we clear the text fields to empty after we add a new note
                            self.clearAddViewFields()
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
    
    // clear the text field after adding a new note
    func clearAddViewFields(){
        allNoteScreen.textViewNote.text = ""
    }
    
    
    // show alert to the user
    func showAlert(text:String){
        let alert = UIAlertController(
            title: "Error",
            message: "\(text)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
                
                
    //MARK: get all contacts call: getall endpoint...
    func getAllNotes(){
        if let url = URL(string: APIConfigs.baseURL + "note/getall"){
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
                                self.allNotes.removeAll()
                                let decoder = JSONDecoder()
                                do{
                                    let receivedData =
                                        try decoder
                                        .decode(AllNotes.self, from: data)
                                        
                                    for item in receivedData.notes{
                                        self.allNotes.append(item)
                                    }
                                    self.allNoteScreen.tableViewNotes.reloadData()
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

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNotes.count
    }
    
    // if the user selects a row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "names", for: indexPath) as! NotesTableViewCell
        cell.labelName.text = allNotes[indexPath.row].text
        
        //MARK: crating an accessory button...
        let buttonOptions = UIButton(type: .system)
        buttonOptions.sizeToFit()
        buttonOptions.showsMenuAsPrimaryAction = true
        //MARK: setting an icon from sf symbols...
        buttonOptions.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        
        //MARK: setting up menu for button options click...
        buttonOptions.menu = UIMenu(title: "Edit/Delete?",
                                    children: [
                                        UIAction(title: "Edit",handler: {(_) in
                                            self.editSelectedFor(currentNote: self.allNotes[indexPath.row])
                                        }),
                                        UIAction(title: "Delete",handler: {(_) in
                                            self.deleteSelectedFor(currentNote: self.allNotes[indexPath.row])
                                        })
                                    ])
        //MARK: setting the button as an accessory of the cell...
        cell.accessoryView = buttonOptions
        return cell
    }
    
    func editSelectedFor(currentNote: Note){
        //print("Will edit \(contactNames[contact])")
        // call the edit
        let editController = EditViewController()
        editController.token = token
        editController.currentNote_id = currentNote._id
        editController.currentNote_text = currentNote.text
        navigationController?.pushViewController(editController, animated: true)
    }

    // show alert do you want to delete
    func deleteSelectedFor(currentNote: Note){
        // Display an alert to confirm deletion
        let alertController = UIAlertController(title: "Delete Note", message: "Are you sure you want to delete this note?", preferredStyle: .alert)
        
        // Add "Cancel" and "Delete" actions to the alert
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (action) in
            // Handle the deletion logic here
            self?.deleteNote(currentNote: currentNote)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    func deleteNote(currentNote: Note) {
        print(currentNote._id)
        if let url = URL(string: APIConfigs.baseURL+"note/delete"){
            AF.request(url, method:.post,
                       parameters:
                        [
                            "id": currentNote._id
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
                                self.getAllNotes()
                                print("get All Notes excuted")
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

