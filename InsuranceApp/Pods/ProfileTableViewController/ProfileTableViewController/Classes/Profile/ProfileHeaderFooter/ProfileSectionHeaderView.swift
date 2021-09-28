import UIKit
import Generics

public class ProfileSectionHeaderView: UITableViewHeaderFooterView {
    
    public static let reuseIdentifier: String = String(describing: self)
    lazy var headerLabel: CustomLabel = {
        let headerLabel = CustomLabel()
        return headerLabel
    }()
    lazy var footerButton: CustomButton = {
        let button = CustomButton()
        button.isHidden = true
        button.addTarget(self, action: #selector(footerButtonTapped), for: .touchUpInside)
        return button
    }()
    public var delegate : ProfileSectionHeaderViewFooterButtonConfigurable?

    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Initialization and Configuration
public extension ProfileSectionHeaderView {
    
    func configureContents() {
        tintColor = .white
        addSubview(headerLabel)
        addSubview(footerButton)
        headerLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        footerButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.left.right.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    public func configureLabel(withText text : String, hideFooterView : Bool = true) {
        headerLabel.labelWithBlueColorAndSystemFont(withTittle: text, fontSize: Float(FontConstant.FONT_SIZE_20.rawValue))
        headerLabel.textAlignment = .center
        headerLabel.isHidden = false
        footerButton.isHidden = hideFooterView
    }
    
    public func configureButton(withText text : String, hideHeaderView : Bool = true) {
        footerButton.blueButtonWithSystemFontandTittle(withText: text, fontSize: FontConstant.FONT_SIZE_20.rawValue)
        footerButton.isHidden = false
        headerLabel.isHidden = hideHeaderView
    }
    
    @objc func footerButtonTapped() {
        delegate?.saveData()
    }
}

public protocol ProfileSectionHeaderViewFooterButtonConfigurable {
    func saveData()
}

extension ProfileSectionHeaderViewFooterButtonConfigurable {
    func saveData() {}
}
