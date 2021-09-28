import UIKit
import Generics

class QuoteRequestHeaderView: UITableViewHeaderFooterView {
    
    public static let reuseIdentifier: String = String(describing: self)
    
    lazy var headerLabel : CustomLabel = {
        let label = CustomLabel()
        label.labelWithBlueColorAndSystemFont(withTittle: "", fontSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    lazy var headerImage = UIImageView()
    lazy var headerButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        button.addTarget(self, action: #selector(showOrHideRows), for: .touchUpInside)
        return button
    }()
    var delegate : QuoteRequestHeaderViewConfigure?
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - View Initialization and Configuration
extension QuoteRequestHeaderView {
    
    func configureContents() {
        self.contentView.backgroundColor = .white
        addSubview(headerImage)
        addSubview(headerLabel)
        addSubview(headerButton)
        
        headerImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.left.equalTo(contentView).inset(10)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(headerImage.snp.right).inset(-10)
        }
        headerButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.right.equalTo(contentView).inset(10)
            make.left.equalTo(headerLabel.snp.right).inset(-10)
        }
        
    }
    
    public func configureSection(with sectionHeaderModel : SectionHeaderModel) {
        guard let title = sectionHeaderModel.title,
              let image = sectionHeaderModel.image,
              let index = sectionHeaderModel.index else {
            return
        }
        headerLabel.text = title
        headerImage.image = UIImage(systemName: image)
        headerButton.tag = index
    }
    
    @objc func showOrHideRows() {        
        delegate?.toggleSection(selectedIndex: headerButton.tag)
    }
}

protocol QuoteRequestHeaderViewConfigure {
    func toggleSection(selectedIndex : Int)
}

extension QuoteRequestHeaderViewConfigure {
    func toggleSection(selectedIndex : Int) {}
}

