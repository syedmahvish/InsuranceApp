import UIKit
import Generics

class QuoteRequestInnerCollectionViewCell: UICollectionViewCell {
    private lazy var nameLabel : CustomLabel = {
        let label = CustomLabel()
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.blue.cgColor
        label.textAlignment = .center
        label.labelWithText(withTittle: EmptyTextConstant.emptyTextValue.rawValue, fontSize: 15, color: .blue)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(nameLabel)
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView(){
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    func configureCell(with value : String) {
        nameLabel.text = value
    }
}
