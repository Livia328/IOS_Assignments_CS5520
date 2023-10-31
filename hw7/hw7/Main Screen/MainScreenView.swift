//
//  MainScreenView.swift
//  hw7
//
//  Created by 陈可轩 on 2023/10/30.
//

import UIKit

class MainScreenView: UIView {
        // make tableView scrollable
        var scrollView: UIScrollView!
        
        //tableView for contacts...
        var tableViewNotes: UITableView!
        
        //bottom view for adding a Contact...
        var bottomAddView:UIView!
        var textViewNote:UITextField!
        var buttonAdd:UIButton!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .white
            
            setupScrollView()
            
            setupTableViewNotes()
            
            setupBottomAddView()
            setupTextViewNote()
            setupButtonAdd()
            
            initConstraints()
        }
        
        func setupScrollView() {
            scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(scrollView)
        }
        
        //MARK: the table view to show the list of contacts...
        func setupTableViewNotes(){
            tableViewNotes = UITableView()
            tableViewNotes.register(NotesTableViewCell.self, forCellReuseIdentifier: "names")
            tableViewNotes.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(tableViewNotes)
        }
        
        //MARK: the bottom add contact view....
        func setupBottomAddView(){
            bottomAddView = UIView()
            bottomAddView.backgroundColor = .white
            bottomAddView.layer.cornerRadius = 6
            bottomAddView.layer.shadowColor = UIColor.lightGray.cgColor
            bottomAddView.layer.shadowOffset = .zero
            bottomAddView.layer.shadowRadius = 4.0
            bottomAddView.layer.shadowOpacity = 0.7
            bottomAddView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(bottomAddView)
        }
        
        func setupTextViewNote() {
            textViewNote = UITextField()
            textViewNote.placeholder = "Add your note here..."
            textViewNote.borderStyle = .roundedRect
            textViewNote.translatesAutoresizingMaskIntoConstraints = false
            bottomAddView.addSubview(textViewNote)
        }

        
        func setupButtonAdd(){
            buttonAdd = UIButton(type: .system)
            buttonAdd.titleLabel?.font = .boldSystemFont(ofSize: 16)
            buttonAdd.setTitle("Add Note", for: .normal)
            buttonAdd.translatesAutoresizingMaskIntoConstraints = false
            bottomAddView.addSubview(buttonAdd)
        }
        
        func initConstraints(){
            NSLayoutConstraint.activate([
                // Constraints for scrollView
                scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
                scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                scrollView.bottomAnchor.constraint(equalTo: bottomAddView.topAnchor, constant: -8),

                // Constraints for tableViewContacts inside the scrollView
                tableViewNotes.topAnchor.constraint(equalTo: scrollView.topAnchor),
                tableViewNotes.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                tableViewNotes.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                tableViewNotes.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                tableViewNotes.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                
                //bottom add view...
                bottomAddView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
                bottomAddView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                bottomAddView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                
                buttonAdd.bottomAnchor.constraint(equalTo: bottomAddView.bottomAnchor, constant: -8),
                buttonAdd.leadingAnchor.constraint(equalTo: bottomAddView.leadingAnchor, constant: 4),
                buttonAdd.trailingAnchor.constraint(equalTo: bottomAddView.trailingAnchor, constant: -4),
                
                textViewNote.bottomAnchor.constraint(equalTo: buttonAdd.topAnchor, constant: -8),
                textViewNote.leadingAnchor.constraint(equalTo: buttonAdd.leadingAnchor, constant: 4),
                textViewNote.trailingAnchor.constraint(equalTo: buttonAdd.trailingAnchor, constant: -4),
                
                bottomAddView.topAnchor.constraint(equalTo: textViewNote.topAnchor, constant: -8),
                //...
                
                tableViewNotes.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
                tableViewNotes.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                tableViewNotes.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                tableViewNotes.bottomAnchor.constraint(equalTo: bottomAddView.topAnchor, constant: -8),
                
            ])
        }
        
        
        //MARK: initializing constraints...
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

