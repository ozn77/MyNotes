//
//  NewTaskViewController.swift
//  MyNotes
//
//  Created by ozan on 12.09.2023.
//

import UIKit

class NewTaskViewController: UIViewController {
    // MARK: - Properties
    private let newTaskLabel: UILabel = {
       let label = UILabel()
        label.attributedText = NSMutableAttributedString(string: "New Task", attributes: [.foregroundColor: UIColor.white, .font: UIFont.preferredFont(forTextStyle: .largeTitle)])
        label.textAlignment = .center
        
       return label
    }()
    
    private let textView: InputTextView = {
       let inputTextView = InputTextView()
        inputTextView.placeHolder = "Enter new task"
        return inputTextView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return button
    }()
    
    private var stackView = UIStackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}
// MARK: - Selector

extension NewTaskViewController{
    @objc private func handleCancelButton(){
        self.dismiss(animated: true)
    }
    @objc private func handleAddButton(){
        guard let taskText = textView.text else { return }
        Service.sendTask(text: taskText) { error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }
        }
        self.dismiss(animated: true)
    }
}

// MARK: - Helpers
extension NewTaskViewController{
    private func style() {
        view.backgroundColor = .black.withAlphaComponent(0.7)
        newTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        stackView = UIStackView(arrangedSubviews: [cancelButton,addButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal // stackview' ın hangi yönde olucağını belirler
        stackView.spacing = 6 // stack view içindeki her eleman arasındaki boşluğu ayarlar
        stackView.distribution = .fillEqually // stack view içindeki her elemanın eşit boyutlarda olmasını sağlar
        
    }
    
    private func layout() {
        view.addSubview(newTaskLabel)
        view.addSubview(textView)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            newTaskLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            newTaskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: newTaskLabel.trailingAnchor, constant: 32),
            newTaskLabel.heightAnchor.constraint(equalToConstant: 60),
            
            textView.topAnchor.constraint(equalTo: newTaskLabel.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 16),
            textView.heightAnchor.constraint(equalToConstant: view.bounds.height / 5),
            
            stackView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 16)
            
        ])
    }
}
