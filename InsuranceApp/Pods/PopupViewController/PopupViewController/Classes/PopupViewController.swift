import UIKit
import Generics
import SnapKit
import WebKit

public protocol PopupViewConfigurable {
    func loadDataInView(with type : PopupViewType)
    func setButton(with type : PopupViewType)
    func buttonAction(with type : PopupViewType)
    func setTitle(with type : PopupViewType)
}

extension PopupViewConfigurable {
    public func loadDataInView(with type : PopupViewType) {}
    public func setButton(with type : PopupViewType) {}
    public func buttonAction(with type : PopupViewType) {}
    public func setTitle(with type : PopupViewType) {}
}

public enum PopupViewType {
    case webView(WebViewViewModelConfigurable)
    case payment(PaymentViewModelConfigurable)
}

public class PopupViewController: UIViewController  {
    
    public lazy var okButton : CustomButton = {
        let button = CustomButton()
        button.blueButtonWithSystemFontandTittle(withText: "", fontSize: FontConstant.FONT_SIZE_20.rawValue)
        button.addTarget(self, action: #selector(okButtonTap), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    public lazy var titleLabel : CustomLabel = {
        let titleLabel = CustomLabel()
        titleLabel.labelWithText(withTittle: "", fontSize: 20, color: .black)
        titleLabel.backgroundColor = .white
        titleLabel.textAlignment = .center
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.borderColor = UIColor.lightGray.cgColor
        return titleLabel
    }()
    public lazy var innerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    public var delegate : PopupViewConfigurable?
    public var viewType : PopupViewType?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        layoutSubViews()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.clear.withAlphaComponent(0.1)
        view.addSubview(okButton)
        view.addSubview(titleLabel)
        view.addSubview(innerView)
        delegate = self
    }
    
    private func layoutSubViews() {
        okButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.right.bottom.equalToSuperview().inset(50)
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.right.top.equalToSuperview().inset(50)
        }
        innerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(okButton.snp.top)
        }
    }
    
    @objc func okButtonTap() {
        guard let type = viewType else {
            return
        }
        delegate?.buttonAction(with: type)
    }
}

extension PopupViewController : PopupViewConfigurable {
    public func loadDataInView(with type: PopupViewType) {
        switch type {
        case let .webView(webViewViewModel):
            guard let htmlString = webViewViewModel.webViewModel?.htmlString else {
                return
            }
            createWebView(for: htmlString)
        case let .payment(paymentViewModel) :
            guard let paymentModel = paymentViewModel.paymentModel else {
                return
            }
            createPaymentView(for: paymentModel)
        }
    }
    
    public func setButton(with type: PopupViewType) {
        switch type {
        case let .webView(webViewViewModel):
            guard let title = webViewViewModel.webViewModel?.buttonTitle else {
                return
            }
            okButton.setTitle(title, for: .normal)
        case let .payment(paymentViewModel) :
            guard let title = paymentViewModel.paymentModel?.buttonTitle else {
                return
            }
            okButton.backgroundColor = .green
            okButton.setTitle(title, for: .normal)
        }
    }
    
    public func buttonAction(with type: PopupViewType) {
        switch type {
        case let .webView(_):
            self.dismiss(animated: true, completion: nil)
        case let .payment(paymentViewModel):
            guard let amount = paymentViewModel.paymentModel?.duePaymentString else {
                return
            }
            showAlert(with: amount)
        }
    }
    
    public func setTitle(with type: PopupViewType) {
        switch type {
        case let .webView(webViewViewModel):
            guard let title = webViewViewModel.webViewModel?.viewTitle else {
                return
            }
            titleLabel.text = title
        case let .payment(paymentViewModel) :
            guard let title = paymentViewModel.paymentModel?.viewTitle else {
                return
            }
            titleLabel.text = title
        }
    }
}

extension PopupViewController {
    private func showAlert(with message : String) {
        let alert = UIAlertController(title: "Confirm to make due payment of amount", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
            self.view.showLoading(style: .large, color: .blue)
            self.dismiss(animated: true, completion: {
                self.view.stopLoading()
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func createWebView(for htmlString : String) {
        let webView = WKWebView()
        let htmltext = String(format: "<span style=\"font-family: %@; font-size: %i\">%@</span>","GothamRounded-Bold",30,htmlString)
        webView.loadHTMLString(htmltext, baseURL: nil)
        addSubViewsToInnerView(viewsArray: [webView])
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
        }
    }
    
    private func createPaymentView(for paymentModel : PaymentModel) {
        guard let image = paymentModel.imageString,
              let name = paymentModel.nameLabelString,
              let duePay =  paymentModel.duePaymentString else {
            return
        }
        let imageView = UIImageView(image: UIImage(named: image))
        let nameLabel = CustomLabel()
        nameLabel.labelWithText(withTittle: name, fontSize: 15, color: .black)
        let duePaymentLabel = CustomLabel()
        duePaymentLabel.labelWithText(withTittle: duePay, fontSize: 15, color: .black)
        addSubViewsToInnerView(viewsArray: [imageView, nameLabel, duePaymentLabel])
        imageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.4)
            make.top.left.right.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.2)
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(imageView.snp.bottom).inset(10)
        }
        duePaymentLabel.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.2)
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(nameLabel.snp.bottom).inset(10)
        }
    }
    
    private func addSubViewsToInnerView(viewsArray : [UIView]) {
        viewsArray.forEach { view in
            innerView.addSubview(view)
        }
    }
}


