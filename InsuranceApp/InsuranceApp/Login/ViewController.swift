import UIKit
import SnapKit
import PromiseKit
import Alamofire
import SwiftyJSON
import Generics

class ViewController: UIViewController {
    lazy var loginView : LoginView = {
        let loginView = LoginView()
        loginView.initializeLoginView()
        return loginView
    }()
    var userCredentials = UserCredentials()
    private lazy var customTabBarViewController = CustomTabBarViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        loginView.delegate = self
        self.title = TitleConstant.loginTitle.rawValue
        self.navigationController?.navigationBar.barTintColor = .white
        self.view.backgroundColor = .white
        self.navigationItem.backButtonTitle = "Logout"
        setupConstraints()
    }
    
    private func setupConstraints() {
        loginView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ViewController : LoginViewDelegate {
    
    func checkValidCredentials(email: String?, password: String?) {
        //self.navigationController?.pushViewController(customTabBarViewController, animated: true)
        view.showLoading(style: .large, color: .blue)
        LoginService.makeLoginValidatityAPIcall(for: UserCredentials(email: email, password: password))
            .done { response in
                firstly {
                    when(fulfilled: LoginService.getProfileDetails(), LoginService.getAllStates())
                }.done { response in
                    self.view.stopLoading()
                    self.loginView.loginErrorLabel.isHidden = true
                    let responseProfileInfo = response.0
                    let stateDropDownInfo = response.1
                    if let profileInfo = responseProfileInfo.profileInformation,
                       let stateDropDownArray = stateDropDownInfo.statesArray {
                        self.customTabBarViewController.profileInformation = profileInfo
                        self.customTabBarViewController.stateDropDownArray = stateDropDownArray
                        self.navigationController?.pushViewController(self.customTabBarViewController, animated: true)
                    }
                } .catch { error in
                    self.view.stopLoading()
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            .catch { error in
                self.loginView.loginErrorLabel.isHidden = false
                self.view.stopLoading()
            }
    }
}
