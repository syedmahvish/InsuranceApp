import UIKit
import Alamofire
import CustomDropDown
import Generics

class ProfileDetailView: CustomVerticalStack {
    
    private lazy var horizontalstack = CustomHorizontalstackView()
    private lazy var innerVerticalStack = CustomVerticalStack()
    private lazy var nameLabel : CustomLabel = {
        let label  = CustomLabel()
        label.textAlignment = .center
        label.labelWithBlueColorAndSystemFont(withTittle: "--", fontSize: 17)
        return label
    }()
    private lazy var phoneLabel : CustomLabel = {
        let label  = CustomLabel()
        label.numberOfLines = 0
        return label
    }()
    private lazy var emailLabel : CustomLabel = {
        let label  = CustomLabel()
        label.numberOfLines = 0
        return label
    }()
    private lazy var idLabel : CustomLabel = {
        let label  = CustomLabel()
        label.numberOfLines = 0
        return label
    }()
    private lazy var usernameLabel : CustomLabel = {
        let label  = CustomLabel()
        label.numberOfLines = 0
        return label
    }()
    private lazy var profilePicture : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageString.defaultProfilePicture.rawValue)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        var innerVerticalViewsArray = [ViewWithProportionality]()
        innerVerticalViewsArray.append(ViewWithProportionality(view : idLabel, proportionValue : nil))
        innerVerticalViewsArray.append(ViewWithProportionality(view : usernameLabel, proportionValue : nil))
        innerVerticalStack.addViewsWithDistributionProportionally(viewsDict: innerVerticalViewsArray, spacing: 5)
        var innerHorizontalViewsArray = [ViewWithProportionality]()
        innerHorizontalViewsArray.append(ViewWithProportionality(view : profilePicture, proportionValue : 0.25))
        innerHorizontalViewsArray.append(ViewWithProportionality(view : innerVerticalStack, proportionValue : 0.7))
        horizontalstack.addViewsWithDistributionProportionally(viewsDict: innerHorizontalViewsArray, spacing: 5)
        var viewsArray = [ViewWithProportionality]()
        viewsArray.append(ViewWithProportionality(view: nameLabel, proportionValue: nil))
        viewsArray.append(ViewWithProportionality(view: horizontalstack, proportionValue: nil))
        viewsArray.append(ViewWithProportionality(view: phoneLabel, proportionValue: nil))
        viewsArray.append(ViewWithProportionality(view: emailLabel, proportionValue: nil))
        self.addViewsWithDistributionProportionally(viewsDict: viewsArray, spacing: 5)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Initialization and Configuration
extension ProfileDetailView {
    func intialViewSetup(profileInformation : ProfileInformationModel?) {
        guard let profileInformation = profileInformation else { return }
        nameLabel.text = profileInformation.name?.getFullName() ?? EmptyTextConstant.emptyTextValue.rawValue
        phoneLabel.text = profileInformation.phone ?? EmptyTextConstant.emptyTextValue.rawValue
        emailLabel.text = profileInformation.email ?? EmptyTextConstant.emptyTextValue.rawValue
        idLabel.text = profileInformation.id?.value ?? EmptyTextConstant.emptyTextValue.rawValue
        usernameLabel.text = profileInformation.id?.name ?? EmptyTextConstant.emptyTextValue.rawValue
        configureProfileImage(with : profileInformation.picture?.medium)
        layoutIfNeeded()
    }
}

// MARK: - Image Cache
extension ProfileDetailView {
    func configureProfileImage(with imageUrlString : String? = nil) {
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
