import UIKit
import Generics

class QuotesCollectionViewCell: UICollectionViewListCell {
    private lazy var nameLabel : CustomLabel = {
        let label = CustomLabel()
        label.labelWithText(withTittle: EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .blue)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.accessories = [.disclosureIndicator()]
        contentView.tintColor = .white
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.right.bottom.top.equalToSuperview().inset(5)
        }
    }
    
    func configureCell(with quoteViewModel : QuotesCollectionViewCellConfigurable) {
        guard let quoteModel = quoteViewModel.quoteModel else {
            return
        }
        nameLabel.text = quoteModel.title
    }
}

protocol QuotesCollectionViewCellConfigurable {
    var quoteModel : QuoteModel? { get }
}

class QuoteViewModel : QuotesCollectionViewCellConfigurable {
    var quoteModel : QuoteModel?
    
    init(quoteModel : QuoteModel) {
        self.quoteModel = quoteModel
        configureData()
    }
    
    private func configureData() {
        guard let model = quoteModel else {
            return
        }
        quoteModel?.title = model.title ?? EmptyTextConstant.emptyTextValue.rawValue
    }
}

