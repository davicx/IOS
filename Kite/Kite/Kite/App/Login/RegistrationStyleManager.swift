//
//  RegistrationStyleManager.swift
//  Kite
//
//  Created by David Vasquez on 2/18/26.
//

import UIKit

protocol RegistrationStyleManagerDelegate: AnyObject {
    func didTapRegisterButton()
    func didTapLoginButton()
}

class RegistrationStyleManager {
    weak var delegate: RegistrationStyleManagerDelegate?

    let logoView = UIView()
    let formView = UIView()
    let dividerView = UIView()
    let registerView = UIView()
    let footerView = UIView()

    let userNameTextField = UITextField()
    let fullNameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()

    let errorLabel = UILabel()
    var errorLabelHeightConstraint: NSLayoutConstraint?
    let registerButton = UIButton(type: .system)
    let successLabel = UILabel()
    var successLabelHeightConstraint: NSLayoutConstraint?

    func setupViews(in view: UIView) {
        logoView.backgroundColor = .clear
        formView.backgroundColor = .white
        dividerView.backgroundColor = .clear
        registerView.backgroundColor = .clear
        footerView.backgroundColor = .lightGray

        setupLogoImage()

        [logoView, formView, dividerView, registerView, footerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        setupDividerView()
        setupFooterView()
    }

    func setupConstraints(in view: UIView) {
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: view.topAnchor),
            logoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),

            formView.topAnchor.constraint(equalTo: logoView.bottomAnchor),
            formView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            formView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),

            dividerView.topAnchor.constraint(equalTo: formView.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.02),

            registerView.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
            registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),

            footerView.topAnchor.constraint(equalTo: registerView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupTextFields() {
        userNameTextField.placeholder = "Username"
        fullNameTextField.placeholder = "Full name"
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true

        Style.styleLoginTextField(userNameTextField)
        Style.styleLoginTextField(fullNameTextField)
        Style.styleLoginTextField(emailTextField)
        Style.styleLoginTextField(passwordTextField)

        [userNameTextField, fullNameTextField, emailTextField, passwordTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            formView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: formView.topAnchor, constant: 12),
            userNameTextField.centerXAnchor.constraint(equalTo: formView.centerXAnchor),
            userNameTextField.widthAnchor.constraint(equalToConstant: 320),
            userNameTextField.heightAnchor.constraint(equalToConstant: 40),

            fullNameTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            fullNameTextField.centerXAnchor.constraint(equalTo: formView.centerXAnchor),
            fullNameTextField.widthAnchor.constraint(equalTo: userNameTextField.widthAnchor),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 40),

            emailTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: formView.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: userNameTextField.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: formView.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: userNameTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupButtons(in view: UIView) {
        errorLabel.font = UIFont.systemFont(ofSize: 12)
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 1
        errorLabel.alpha = 0
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        formView.addSubview(errorLabel)

        registerButton.setTitle("Register Now", for: .normal)
        registerButton.backgroundColor = UIColor(hex: "#3797EF")
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 5
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        formView.addSubview(registerButton)

        successLabel.font = UIFont.systemFont(ofSize: 15)
        successLabel.textColor = .systemGreen
        successLabel.numberOfLines = 1
        successLabel.textAlignment = .center
        successLabel.alpha = 0
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        formView.addSubview(successLabel)

        let errorHeight = errorLabel.heightAnchor.constraint(equalToConstant: 0)
        errorLabelHeightConstraint = errorHeight
        let successHeight = successLabel.heightAnchor.constraint(equalToConstant: 0)
        successLabelHeightConstraint = successHeight
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            errorHeight,

            registerButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 4),
            registerButton.centerXAnchor.constraint(equalTo: formView.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 320),
            registerButton.heightAnchor.constraint(equalToConstant: 40),

            successLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 4),
            successLabel.centerXAnchor.constraint(equalTo: formView.centerXAnchor),
            successLabel.widthAnchor.constraint(equalTo: registerButton.widthAnchor),
            successHeight
        ])
    }

    func showError(_ message: String) {
        errorLabel.text = message
        errorLabelHeightConstraint?.constant = 18
        errorLabel.alpha = 1
    }

    func hideError() {
        errorLabel.text = nil
        errorLabelHeightConstraint?.constant = 0
        errorLabel.alpha = 0
    }

    func showSuccess(_ message: String) {
        successLabel.text = message
        successLabelHeightConstraint?.constant = 22
        successLabel.alpha = 1
    }

    func hideSuccess() {
        successLabel.text = nil
        successLabelHeightConstraint?.constant = 0
        successLabel.alpha = 0
    }

    func setupLogoImage() {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "background_14")
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.layer.contentsRect = CGRect(x: 0.25, y: 0, width: 0.5, height: 1)
        logoView.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: logoView.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: logoView.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: logoView.trailingAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: logoView.bottomAnchor)
        ])
    }

    func setupDividerView() {
        let dividerWithLabel = DividerWithLabel()
        dividerWithLabel.translatesAutoresizingMaskIntoConstraints = false
        dividerView.addSubview(dividerWithLabel)
        NSLayoutConstraint.activate([
            dividerWithLabel.centerXAnchor.constraint(equalTo: dividerView.centerXAnchor),
            dividerWithLabel.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor),
            dividerWithLabel.leadingAnchor.constraint(equalTo: dividerView.leadingAnchor, constant: 20),
            dividerWithLabel.trailingAnchor.constraint(equalTo: dividerView.trailingAnchor, constant: -20),
            dividerWithLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupFooterView() {
        let haveAccountLabel = UILabel()
        haveAccountLabel.text = "Have an Account?"
        haveAccountLabel.textColor = .black
        haveAccountLabel.font = UIFont.systemFont(ofSize: 14)

        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor(hex: "#3797EF"), for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        haveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registerView.addSubview(haveAccountLabel)
        registerView.addSubview(loginButton)

        NSLayoutConstraint.activate([
            haveAccountLabel.centerXAnchor.constraint(equalTo: registerView.centerXAnchor, constant: -25),
            haveAccountLabel.centerYAnchor.constraint(equalTo: registerView.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: haveAccountLabel.trailingAnchor, constant: 5),
            loginButton.centerYAnchor.constraint(equalTo: haveAccountLabel.centerYAnchor)
        ])
    }

    @objc func registerTapped() {
        delegate?.didTapRegisterButton()
    }

    @objc func loginTapped() {
        delegate?.didTapLoginButton()
    }
}
