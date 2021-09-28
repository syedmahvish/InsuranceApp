import UIKit
import Generics

class ProfileHeaderView: UIView {
    
    private lazy var headerLabel = CustomLabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(self).inset(20)
            make.bottom.equalTo(self).inset(10)
            make.left.right.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - View Initialization and Configuration
extension ProfileHeaderView {
    
    func configureLabel(withText text : String) {
        headerLabel.labelWithBlueColorAndSystemFont(withTittle: text, fontSize: Float(FontConstant.FONT_SIZE_20.rawValue))
        headerLabel.textAlignment = .center
    }
}
