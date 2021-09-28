import UIKit
import SnapKit
import Generics

class LoginView: UIView {
    
    private lazy var verticalStackView = CustomVerticalStack()
    lazy var signInButton : CustomButton = {
        let button = CustomButton()
        button.blueButtonWithSystemFontandTittle(withText: TitleConstant.signInButtonText.rawValue, fontSize: FontConstant.FONT_SIZE_20.rawValue)
        button.addTarget(self, action: #selector(signInButtonTap), for: .touchUpInside)
        return button
    }()
    lazy var usernameView : InformationEditableView = {
        let usernameView = InformationEditableView()
        usernameView.setViewWithLabel(withText: "Username", andTextField: "Enter username")
        return usernameView
    }()
    lazy var passwordView : InformationEditableView = {
        let passwordView = InformationEditableView()
        passwordView.setViewWithLabel(withText: "Password", andTextField: "Enter password")
        return passwordView
    }()
    lazy var loginErrorLabel : CustomLabel = {
        let label = CustomLabel()
        label.errorLabelWithSystemFont(withTittle: ErrorMessage.loginErrorMessage.rawValue)
        label.isHidden = true
        return label
    }()
    private lazy var loginImageView : UIImageView = {
        let loginImageView = UIImageView()
        loginImageView.image = UIImage(named: ImageString.loginImage.rawValue)
        loginImageView.layer.borderWidth = 1
        loginImageView.layer.borderColor = UIColor.blue.cgColor
        return loginImageView
    }()
    
    weak var delegate : LoginViewDelegate?
    
    func initializeLoginView() {
        setupInitialView()
        setupConstraints()
    }
    
    private func setupInitialView() {
        usernameView.infoTextField.delegate = self
        passwordView.infoTextField.delegate = self
        var viewsArray = [ViewWithProportionality]()
        viewsArray.append(ViewWithProportionality(view: loginImageView, proportionValue: 0.25))
        viewsArray.append(ViewWithProportionality(view: usernameView, proportionValue: 0.10))
        viewsArray.append(ViewWithProportionality(view: passwordView, proportionValue: 0.10))
        viewsArray.append(ViewWithProportionality(view: loginErrorLabel, proportionValue: 0.10))
        viewsArray.append(ViewWithProportionality(view: signInButton, proportionValue: 0.10))
        verticalStackView.addViewsWithDistributionProportionally(viewsDict: viewsArray, spacing: 10)
        self.addSubview(verticalStackView)
    }
    
    private func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    @objc private func signInButtonTap() {
        delegate?.checkValidCredentials(email: usernameView.infoTextField.text, password: passwordView.infoTextField.text)
    }
}

protocol LoginViewDelegate : AnyObject {    
    func checkValidCredentials(email : String?, password : String?)
}

extension LoginView : UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginErrorLabel.isHidden = true
        textField.resignFirstResponder()
        return true
    }
}
