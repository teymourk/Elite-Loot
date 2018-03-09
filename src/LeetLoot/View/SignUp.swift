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

protocol HomePagesDelegate {
    func onScreenButtons(_ sender: UIButton)
}
class SignUp: SignIn {
    
    private let EmLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Please enter a valid email"
        lb.textColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false;
        return lb;
    }()
    private let signUpLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Register"
        lb.translatesAutoresizingMaskIntoConstraints = false;
        return lb;
    }()
   private let ErrorLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Passwords do not match"
        lb.textColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false;
        return lb;
    }()
   private let PasswordLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Password must be at least 6 characters"
        lb.textColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false;
        return lb;
    }()
    private let duplicateAccount: UILabel = {
        let lb = UILabel()
        lb.text = "Account already in use"
        lb.textColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false;
        return lb;
    }()
    private lazy var emailContainerView : UIView = {
        
        let emailContainerView = UIView()
        emailContainerView.backgroundColor = UIColor(red:238, green: 239, blue: 241)
        emailContainerView.translatesAutoresizingMaskIntoConstraints=false
        emailContainerView.layer.cornerRadius = 4
        emailContainerView.layer.masksToBounds = true
        
        return emailContainerView
    }()
    private let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .emailAddress
        //textfield.font = UIFont(name:"Helvectica",size:14)
        return textfield;}()

        private lazy var passwordContainerView : UIView = {
            let passwordContainerView = UIView()
            passwordContainerView.backgroundColor = UIColor(red:238, green: 239, blue: 241)
            passwordContainerView.translatesAutoresizingMaskIntoConstraints=false
            passwordContainerView.layer.cornerRadius = 4
            passwordContainerView.layer.masksToBounds = true
            return passwordContainerView
        }()
    private let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Passwords must be at least 6 characters"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .emailAddress
        textfield.isSecureTextEntry = true
       // textfield.font = UIFont(name:"Helvectica",size:14)
        //textfield.addTarget(self, action: #selector(textFieldDidChange(_:)),for: UIControlEvents.editingChanged)
        return textfield;
    }()
    private lazy var confirmPasswordContainerView : UIView = {
        let passwordContainerView = UIView()
        passwordContainerView.backgroundColor = UIColor(red:238, green: 239, blue: 241)
        passwordContainerView.translatesAutoresizingMaskIntoConstraints=false
        passwordContainerView.layer.cornerRadius = 4
        passwordContainerView.layer.masksToBounds = true
       // passwordContainerView.layer.borderWidth = 1
        
        return passwordContainerView
    }()
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


    override func SignInLabel() {
        addSubview(signUpLabel)
        NSLayoutConstraint.activate([
            //setup constraints
            signUpLabel.topAnchor.constraint(equalTo: topAnchor, constant: 63),
            signUpLabel.leftAnchor.constraint(equalTo:leftAnchor, constant: 23)
        ])
    }
    
    
    override func setupEmail(){
        addSubview(emailContainerView)
        NSLayoutConstraint.activate([
            //setup constraints
            emailContainerView.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 51),
            emailContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant:15),
            emailContainerView.widthAnchor.constraint(equalTo:widthAnchor,constant:-30),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50)
            ])
        addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.leftAnchor.constraint(equalTo: emailContainerView.leftAnchor, constant: 20),
            emailTextField.topAnchor.constraint(equalTo: emailContainerView.topAnchor,constant:15),
            emailTextField.widthAnchor.constraint(equalTo: emailContainerView.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 17)
            ])
        
    }
    override func setupPassword(){
        addSubview(passwordContainerView)
        NSLayoutConstraint.activate([
            passwordContainerView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 116),
            passwordContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            passwordContainerView.widthAnchor.constraint(equalTo:widthAnchor,constant:-30),
            passwordContainerView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.leftAnchor.constraint(equalTo: passwordContainerView.leftAnchor, constant: 20),
            passwordTextField.topAnchor.constraint(equalTo: passwordContainerView.topAnchor,constant:15),
            passwordTextField.widthAnchor.constraint(equalTo:passwordContainerView.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 17)
            ])
    }
    func setupConfirmPassword(){
        addSubview(confirmPasswordContainerView)
        NSLayoutConstraint.activate([
            confirmPasswordContainerView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 181),
            confirmPasswordContainerView.leftAnchor.constraint(equalTo:leftAnchor, constant: 15),
            confirmPasswordContainerView.widthAnchor.constraint(equalTo:widthAnchor,constant:-30),
            confirmPasswordContainerView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(confirmPasswordTextField)
        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    override func setupRegister(){
        addSubview(register)
        //setup constraints
        NSLayoutConstraint.activate([
            register.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 283),
            
            register.widthAnchor.constraint(equalTo: widthAnchor,constant:-10),
            register.centerXAnchor.constraint(equalTo:centerXAnchor)
            
            ])
    }
    func passwordLabel() {
        addSubview(PasswordLabel)
        NSLayoutConstraint.activate([
            //setup constraints
            PasswordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 285),
            // ErrorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -65),
            PasswordLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        PasswordLabel.isHidden = true;
    }
    func errorLabel() {
        addSubview(ErrorLabel)
        NSLayoutConstraint.activate([
            //setup constraints
            ErrorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 285),
            // ErrorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -65),
            ErrorLabel.leftAnchor.constraint(equalTo:leftAnchor, constant: 99)
            ])
        ErrorLabel.isHidden = true;
    }
    func DuplicateAccount(){
        addSubview(duplicateAccount)
        NSLayoutConstraint.activate([
            //setup constraints
            duplicateAccount.topAnchor.constraint(equalTo: topAnchor, constant: 285),
            // ErrorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -65),
            duplicateAccount.centerXAnchor.constraint(equalTo:centerXAnchor)
            ])
        duplicateAccount.isHidden = true;
        
        
    }
    override func EmailLabel() {
        addSubview(EmLabel)
        NSLayoutConstraint.activate([
            //setup constraints
            EmLabel.topAnchor.constraint(equalTo: topAnchor, constant: 285),
            // ErrorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -65),
            EmLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        EmLabel.isHidden = true;
    }

    override func setupLayoutAttributes() {
        back.isHidden = false
        errorLabel();
        passwordLabel();
        DuplicateAccount();
        setupEmail();
        setupPassword();
        setupConfirmPassword();
        setupRegister();
        EmailLabel();
        }
    
func setregisterbuttonenabled(enabled:Bool){
    if(enabled)
    {
        register.isEnabled = true
    }
    
    override func setupLayoutAttributes() {
        back.setImage(#imageLiteral(resourceName: "Back"), for: .normal)
        back.isEnabled = true
        signInLabel.text = "Sign Up"
        setupRegister()
        setupTextFields()
        setupConfirmPassword()
        forgotLabel()
    }
  
    @objc func registerAction(){
        guard let em = emailTextField.text else {return }
        guard let pass = passwordTextField.text else {return }
        guard let confirm = confirmPasswordTextField.text else {return}
        if pass != confirm
        {
            ErrorLabel.isHidden = false;
            passwordContainerView.layer.borderWidth = 1
            passwordContainerView.layer.borderColor = UIColor.red.cgColor
            confirmPasswordContainerView.layer.borderWidth = 1
            confirmPasswordContainerView.layer.borderColor = UIColor.red.cgColor
            PasswordLabel.isHidden = true;
        }
        else if pass.count < 6{
            ErrorLabel.isHidden = true;
            PasswordLabel.isHidden = false;
            passwordContainerView.layer.borderWidth = 1
            passwordContainerView.layer.borderColor = UIColor.red.cgColor
            confirmPasswordContainerView.layer.borderWidth = 1
            confirmPasswordContainerView.layer.borderColor = UIColor.red.cgColor
        }
        else{
            PasswordLabel.isHidden = true;
            passwordContainerView.layer.borderWidth = 0
            // passwordContainerView.layer.borderColor = paleGray.cgcolor
            confirmPasswordContainerView.layer.borderWidth = 0
            //confirmPasswordContainerView.layer.borderColor = .paleGray.cgcolor
        
        
            ErrorLabel.isHidden = true;
            passwordContainerView.layer.borderWidth = 0
            // passwordContainerView.layer.borderColor = paleGray.cgcolor
            confirmPasswordContainerView.layer.borderWidth = 0
            //confirmPasswordContainerView.layer.borderColor = .paleGray.cgcolor
            
        
        setregisterbuttonenabled(enabled:false);
          //  bool isDuplicate = false;
        
    
        Auth.auth().createUser(withEmail: em, password: pass) { user,error in
            if let error = error {
                print(error.localizedDescription)
                if em == ""
                {
                    self.EmLabel.isHidden = false;
                    self.emailContainerView.layer.borderWidth = 1;
                    self.emailContainerView.layer.borderColor = UIColor.red.cgColor
                    
                }
                
                /*{
                self.duplicateAccount.isHidden = false;
                self.emailContainerView.layer.borderWidth = 1
                self.emailContainerView.layer.borderColor = UIColor.red.cgColor
                }*/
                
            }
            else if let user = user {
                self.emailContainerView.layer.borderWidth = 0
                self.duplicateAccount.isHidden = true;
                print("Sign Up Successfully. \(user.uid)")
                guard let uid = Auth.auth().currentUser?.uid else {return}
                self.saveUID(UID:uid){ success in
                    if success{
                    print("Sucessfully saved in databse!")
                }
            }
        }
    }
  }
}
    
    func saveUID(UID:String,completion:@escaping((_ success:Bool)->()))
    {
        
        let databaseRef = Database.database().reference().child("users/\(UID)")
        let userObject = [
            "favorites":""
        ]
            as [String:Any]
        databaseRef.setValue(userObject){error, ref in completion(error == nil)
            
        }

    }
}
