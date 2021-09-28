import UIKit
import Generics

class QuoteCollectionViewHeader: UICollectionReusableView {
    static let reuseIdentifier: String = String(describing: self)
    private lazy var headerLabel : CustomLabel = {
        let label = CustomLabel()
        label.labelWithText(withTittle: EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .blue)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuoteCollectionViewHeader {
    
    func configureContents() {
        self.tintColor = .white
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.left.right.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    public func configureLabel(withText text : String) {
        headerLabel.labelWithBlueColorAndSystemFont(withTittle: text, fontSize: Float(FontConstant.FONT_SIZE_20.rawValue))
        headerLabel.textAlignment = .center
    }
}

