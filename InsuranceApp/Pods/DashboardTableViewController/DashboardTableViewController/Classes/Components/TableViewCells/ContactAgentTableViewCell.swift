import UIKit
import ProfileTableViewController
import Generics


class ContactAgentTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: self)
    
    private lazy var horizontalstack = CustomHorizontalstackView()
    private lazy var innerVerticalStack = CustomVerticalStack()
    private lazy var nameLabel : CustomLabel = {
        let label = CustomLabel()
        label.labelWithText(withTittle: EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .systemPink)
        return label
    }()
    private lazy var phoneLabel : CustomLabel = {
        let label = CustomLabel()
        label.labelWithText(withTittle: EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .systemPink)
        return label
    }()    
    private lazy var profilePicture : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageString.defaultProfilePicture.rawValue)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(horizontalstack)
        var innerVerticalViewsArray = [ViewWithProportionality]()
        innerVerticalViewsArray.append(ViewWithProportionality(view : nameLabel, proportionValue : nil))
        innerVerticalViewsArray.append(ViewWithProportionality(view : phoneLabel, proportionValue : nil))
        innerVerticalStack.addViewsWithDistributionProportionally(viewsDict: innerVerticalViewsArray, spacing: 5)
        var viewsArray = [ViewWithProportionality]()
        viewsArray.append(ViewWithProportionality(view: profilePicture, proportionValue: 0.25))
        viewsArray.append(ViewWithProportionality(view: innerVerticalStack, proportionValue: 0.7))
        horizontalstack.addViewsWithDistributionProportionally(viewsDict: viewsArray, spacing: 5)
        horizontalstack.snp.makeConstraints { make in
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
extension ContactAgentTableViewCell {
    
    func configureContactAgent(withProfileInformation profile : ProfileInformationModel?) {
        guard let profileInformation = profile else { return }
        nameLabel.text = profileInformation.name?.getFullName() ?? EmptyTextConstant.emptyTextValue.rawValue
        phoneLabel.text = profileInformation.phone ?? EmptyTextConstant.emptyTextValue.rawValue
        configureImage(with : profileInformation.picture?.medium)
    }
    
    func configureAuto(withAutoInformation autoRenewalViewModel : AutoRenewalInfoConfigurable) {
        guard let autoRenewalModel = autoRenewalViewModel.autoRenewalModel
        else {
            return
        }
        nameLabel.labelWithText(withTittle: autoRenewalModel.name ?? EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .blue)
        phoneLabel.labelWithText(withTittle: autoRenewalModel.upcomingBillingDate ?? EmptyTextConstant.emptyTextValue.rawValue, fontSize: 12, color: .blue)
        profilePicture.image = UIImage(named: autoRenewalModel.billImage ?? ImageString.defaultProfilePicture.rawValue)
    }
}

// MARK: - Image Configuartion
extension ContactAgentTableViewCell {
    private func configureImage(with imageUrlString : String? = nil) {
        guard let validurlString = imageUrlString else {
            return
        }
        profilePicture.loadImage(url: validurlString) { [weak self] loadImageResult in
            self?.handle(loadImageResult,
                         requestURL: validurlString,
                         placeHolderImage: UIImage(named: ImageString.defaultProfilePicture.rawValue))
        }
    }
    
    private func handle(_ loadImageResult: (Result<FetchImageResponse, ImageLoadingError>),
                        requestURL: String,
                        placeHolderImage: UIImage?) {
        switch loadImageResult {
        case.success(let imageResponse):
            if imageResponse.requestUrlString.compare(requestURL) == .orderedSame {
                profilePicture.image = imageResponse.image
            } else {
                profilePicture.image = placeHolderImage
            }
        case .failure: profilePicture.image = placeHolderImage
        }
    }
}

protocol ContactAgentTableViewCellConfigurable {
    var profileInformationModel : ProfileInformationModel? { get }
    var autoInformationViewModel: AutoRenewalInfoConfigurable? { get }
}

class ContactAgentTableViewCellViewModel : ContactAgentTableViewCellConfigurable {
    var profileInformationModel: ProfileInformationModel?
    var autoInformationViewModel: AutoRenewalInfoConfigurable?
    
    init(profileInformationModel: ProfileInformationModel) {
        self.profileInformationModel = profileInformationModel
    }
    init(autoInformationViewModel : AutoRenewalInfoConfigurable) {
        self.autoInformationViewModel = autoInformationViewModel
    }
}
