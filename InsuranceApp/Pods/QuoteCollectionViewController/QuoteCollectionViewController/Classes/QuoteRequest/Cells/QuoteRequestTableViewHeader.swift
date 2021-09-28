import UIKit
import Generics

class QuoteRequestTableViewHeader: UIView {
    
    private lazy var headerLabel = CustomLabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - View Initialization and Configuration
extension QuoteRequestTableViewHeader {
    func configureLabel(withText text : String) {
        headerLabel.text = text
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerLabel.textAlignment = .center
    }
}

