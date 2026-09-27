//
//  RegistrationViewController.swift
//  Kite
//
//  Created by David Vasquez on 12/15/24.
//

import UIKit

class RegistrationViewController: UIViewController, RegistrationStyleManagerDelegate {

    let styleManager = RegistrationStyleManager()
    let loginAPI = LoginAPI()
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("RegistrationViewController")

        styleManager.delegate = self
        styleManager.setupViews(in: view)
        styleManager.setupConstraints(in: view)
        styleManager.setupTextFields()
        styleManager.setupButtons(in: view)
        // Temporary: pre-fill for testing (remove before release)
        styleManager.userNameTextField.text = "sam3"
        styleManager.fullNameTextField.text = "Sam Gamgee"
        styleManager.emailTextField.text = "sam3@gmail.com"
        styleManager.passwordTextField.text = "password"
        setupElements()
    }

    func setupElements() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        view.addSubview(activityIndicator)
    }

    func didTapRegisterButton() {
        styleManager.hideError()
        styleManager.hideSuccess()

        let userName = styleManager.userNameTextField.text ?? ""
        let fullName = styleManager.fullNameTextField.text ?? ""
        let email = styleManager.emailTextField.text ?? ""
        let password = styleManager.passwordTextField.text ?? ""

        // 1) Swift App – validationFunctions
        let validUsername = validateUserName(userName: userName)
        let validFullName = validateFullName(fullName: fullName)
        let validEmail = validateEmail(email: email)
        let validPassword = validatePassword(password: password)

        if !validUsername || !validFullName || !validEmail || !validPassword {
            let message = getRegisterMessage(
                validUsername: validUsername,
                validFullName: validFullName,
                validEmail: validEmail,
                validPassword: validPassword
            )
            styleManager.showError(message)
            return
        }

        // 2) API – call register; show data.message or validation messages on failure
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false

        Task {
            defer {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                }
            }
            do {
                let response = try await loginAPI.registerNewUser(
                    username: userName,
                    fullName: fullName,
                    email: email,
                    password: password
                )
                await MainActor.run {
                    if response.success {
                        styleManager.hideError()
                        styleManager.showSuccess(response.message)
                    } else {
                        styleManager.hideSuccess()
                        let message = Self.errorMessage(from: response)
                        styleManager.showError(message)
                    }
                }
            } catch {
                await MainActor.run {
                    styleManager.hideSuccess()
                    styleManager.showError("Something went wrong. Please try again.")
                }
            }
        }
    }

    /// Build user-facing error from API response: top-level message or first failing validation message from data.registrationValidation.
    private static func errorMessage(from response: RegistrationResponseModel) -> String {
        if !response.message.isEmpty {
            return response.message
        }
        let v = response.data.registrationValidation
        if v.usernameStatus != 1, !v.usernameMessage.isEmpty { return v.usernameMessage }
        if v.emailStatus != 1, !v.emailMessage.isEmpty { return v.emailMessage }
        if v.passwordStatus != 1, !v.passwordMessage.isEmpty { return v.passwordMessage }
        if v.usernameAvailableStatus != 1, !v.usernameAvailableMessage.isEmpty { return v.usernameAvailableMessage }
        return "Registration failed."
    }

    func didTapLoginButton() {
        navigationController?.popViewController(animated: true)
    }
}
