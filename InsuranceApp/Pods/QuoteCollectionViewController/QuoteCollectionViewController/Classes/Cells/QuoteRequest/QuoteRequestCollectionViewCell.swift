import UIKit

class QuoteRequestCollectionViewCell: UICollectionViewListCell {
    var requestTable :  QuoteRequestCollectionViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        requestTable = QuoteRequestCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        if let view = requestTable?.view {
            contentView.addSubview(view)
            view.snp.makeConstraints({ make in
                make.edges.equalTo(contentView).inset(5)
                make.height.equalTo(200)
            })
        }
    }
    
    func configureCell(with viewModel : QuotesRequestCollectionViewCellConfigurable) {
        requestTable?.quoteRequest = viewModel.quoteRequest
        requestTable?.reloadQuoteRequestView()
    }
}

protocol QuotesRequestCollectionViewCellConfigurable {
    var quoteRequest : QuoteRequest? { get }
}

class QuoteRequestCollectionViewModel : QuotesRequestCollectionViewCellConfigurable {
    var quoteRequest : QuoteRequest?
    
    init(quoteRequest : QuoteRequest) {
        self.quoteRequest = quoteRequest
    }
}
