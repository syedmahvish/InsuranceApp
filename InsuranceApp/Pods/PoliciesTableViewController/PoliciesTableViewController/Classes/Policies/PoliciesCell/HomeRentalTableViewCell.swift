import UIKit
import Generics

class HomeRentalTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: self)
    private lazy var innerVerticalStack = CustomVerticalStack()
    private lazy var nameLabel : CustomLabel = {
        let label = CustomLabel()
        label.labelWithText(withTittle: EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .blue)
        return label
    }()
    private lazy var typeLabel : CustomLabel = {
        let label = CustomLabel()
        label.labelWithText(withTittle: EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .blue)
        return label
    }()
    private lazy var dateLabel : CustomLabel = {
        let label = CustomLabel()
        label.labelWithText(withTittle: EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .blue)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        var innerVerticalViewsArray = [ViewWithProportionality]()
        innerVerticalViewsArray.append(ViewWithProportionality(view : nameLabel, proportionValue : nil))
        innerVerticalViewsArray.append(ViewWithProportionality(view : typeLabel, proportionValue : nil))
        innerVerticalViewsArray.append(ViewWithProportionality(view : dateLabel, proportionValue : nil))
        innerVerticalStack.addViewsWithDistributionProportionally(viewsDict: innerVerticalViewsArray, spacing: 5)
        contentView.addSubview(innerVerticalStack)
        innerVerticalStack.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Cell Configuration
extension HomeRentalTableViewCell {
    
    func configureCell(homeRentalViewModel : HomeRentalTableViewCellConfigurable) {
        guard let homeRentalInfo = homeRentalViewModel.homeRentalInfo else {
            return
        }
        nameLabel.text = homeRentalInfo.name
        typeLabel.text = homeRentalInfo.type
        dateLabel.text = homeRentalInfo.policyEndDate
    }
}


protocol HomeRentalTableViewCellConfigurable {
    var homeRentalInfo: HomeRentalModel? { get }
}

class HomeRentalViewModel: HomeRentalTableViewCellConfigurable {
    var homeRentalInfo: HomeRentalModel?
    
    init(homeRentalInfo: HomeRentalModel) {
        self.homeRentalInfo = homeRentalInfo
        configureInformation()
    }
    
    private func configureInformation() {
        guard let homeRentalModel = homeRentalInfo else {
            return
        }
        homeRentalInfo?.name = homeRentalModel.name ?? EmptyTextConstant.emptyTextValue.rawValue
        homeRentalInfo?.type = homeRentalModel.type ?? EmptyTextConstant.emptyTextValue.rawValue
        homeRentalInfo?.policyEndDate = "Policy End Date: " + (homeRentalModel.policyEndDate ?? EmptyTextConstant.emptyTextValue.rawValue)
    }
}
