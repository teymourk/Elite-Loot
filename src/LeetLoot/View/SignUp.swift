//
//  SignUp.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/21/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

protocol HomePagesDelegate {
    func onScreenButtons(_ sender: UIButton)
}
class SignUp: SignIn {
    /*confirm password text field*/
    private let confirmPasswordTextField: UITextField = {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        let textfield = UITextField()
            textfield.text = nil
            textfield.isSecureTextEntry = true
            textfield.placeholder = "Confirm Password"
            textfield.font = UIFont(name: "Helvectica",size:14)
            textfield.keyboardType = .emailAddress
            textfield.backgroundColor = .customGray
            textfield.layer.cornerRadius = 4
            textfield.leftView = paddingView
            textfield.leftViewMode = .always
            textfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
            textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    /*password label*/
    let passwordLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Helvetica", size: 14)
        lb.text = "Passwords must be 6 characters in length"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    /*register button*/
    private lazy var register: UIButton = {
        let button = UIButton(type:.system)
            button.backgroundColor = .lightBlue
            button.setTitle("REGISTER", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 4
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont .boldSystemFont(ofSize: 14)
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.addTarget(self, action: #selector(onRegister(_:)), for: .touchUpInside);
        return button
    }()
/*constraints for register button*/
    override func setupRegister(){
        addSubview(register)
        addSubview(passwordLabel);
        
        NSLayoutConstraint.activate([
            passwordLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            passwordLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 67),
            passwordLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            passwordLabel.centerXAnchor.constraint(equalTo:centerXAnchor)
            ])
    
        NSLayoutConstraint.activate([
            register.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            register.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            register.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            register.centerXAnchor.constraint(equalTo:centerXAnchor)
        ])
    }
    /*confirm password text field constraints*/
    private func setupConfirmPassword() {
        addSubview(confirmPasswordTextField)
        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    /*forgot label constraints*/
    override func forgotLabel(){
        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 5),
            errorLabel.centerXAnchor.constraint(equalTo:centerXAnchor)
        ])
    }
    /*setup entire layout*/
    override func setupLayoutAttributes() {
        back.setImage(#imageLiteral(resourceName: "Back"), for: .normal)
        back.isEnabled = true
        signInLabel.text = "Register"
        setupRegister()
        setupTextFields()
        setupConfirmPassword()
        forgotLabel()
    }
    /*activate register button on click*/
    @objc
    func onRegister(_ sender: UIButton) {
        guard   let email = emailTextField.text,
                let password = passwordTextField.text,
                let confirmPassword = confirmPasswordTextField.text else { return }
        
        // Check for if the passwords match
        if ((password.elementsEqual(confirmPassword)) != true)
        {
            self.errorLabel.text = "Passwords do not match, please try again."
            self.errorLabel.shake()
            self.errorLabel.flash()
            return
        }
        // Handle errors returned by firebase
        Auth.auth().createUser(withEmail: email, password: password) { FBUser,error in
            guard error == nil,
                let user = FBUser else {
                    self.errorLabel.text = self.handleErrorFor(error)
                    self.errorLabel.shake()
                    self.errorLabel.flash()
                    return
            }
            self.createUserWithDatsa(UID: user.user.uid)
        }
    }
    /*creates user in firebase*/
    private func createUserWithDatsa(UID:String) {
        let databaseRef = Database.database().reference().child("users/\(UID)"),
        userObject = ["favorites": ["overwatch":false, "lol":false, "dota":false, "sbm":false, "sf":false,
                                    "rl":false, "csgo":false, "hots":false, "sc2":false, "hs":false]] as Dictionary<String, Any>
        databaseRef.setValue(userObject)
        UserDefaults.standard.setValue(UID, forKey: "SignedUser")
        delegate?.signedInSuccessfully()
        emailTextField.text = nil
        passwordTextField.text = nil
        confirmPasswordTextField.text = nil
    }
}
