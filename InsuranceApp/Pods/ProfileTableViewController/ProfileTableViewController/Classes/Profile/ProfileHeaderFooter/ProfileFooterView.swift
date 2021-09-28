import UIKit
import CustomDropDown
import Generics

class ProfileFooterView: UIView {
    
    private lazy var saveButton: CustomButton = {
        let saveButton = CustomButton()
        saveButton.blueButtonWithSystemFontandTittle(withText: "Save", fontSize: FontConstant.FONT_SIZE_20.rawValue)
        saveButton.titleLabel?.textAlignment = .center
        return saveButton
    }()
    
    var delegate : UpdateProfileInformation?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.left.right.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - View Initialization and Configuration
extension ProfileFooterView {
    func addButtonAction() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        delegate?.updateProfileInformation()
    }
}

protocol UpdateProfileInformation  {
    func updateProfileInformation()
}
