import UIKit
import Generics

class InstagramTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "InstagramCellIdentifier"
    private lazy var verticalStackView : UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 5
        return verticalStackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(5)
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

extension InstagramTableViewCell {
    
    func setupInitialView() {
        //top notification
        setupNotificationView()
        //profile info
        setupProfileView()
        //Post text
        setupPostTextView()
        //Post Shared Image
        setupPostImageView()
        //comments and like buttons
        setupCommentsandLikeView()
        //bottom buttons
        setupFooter()
    }
    
    private func setupNotificationView() {
        let notificationLabel = CustomLabel()
        notificationLabel.labelWithText(withTittle: "Jeff Morgan likes this", fontSize: 15, color: .black)
        let button = CustomButton()
        button.setImage(UIImage(systemName: "ellipsis.rectangle.fill"), for: .normal)
        let innerHorizontalStackView = addViewsToHorizontalStackView(views: [notificationLabel, button])
        notificationLabel.snp.makeConstraints { make in
            make.width.equalTo(innerHorizontalStackView.snp.width).multipliedBy(0.8)
        }
        innerHorizontalStackView.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
    
    private func setupProfileView() {
        let image = UIImage(named: "instaPost")
        let profileImageView = UIImageView(image: image)
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = 35
        profileImageView.clipsToBounds = true
        
        let nameLabel = CustomLabel()
        nameLabel.labelWithText(withTittle: "Mahvish", fontSize: 20, color: .black)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        let connection = CustomLabel()
        connection.labelWithText(withTittle: " . 3rd+", fontSize: 15, color: .black)
        let nameAndConnectionView = addViewsToHorizontalStackView(views: [nameLabel, connection], distribution : .fillProportionally,spacing: 5)
        //designation
        let designationLabel = CustomLabel()
        designationLabel.labelWithText(withTittle: "Chief Executive Officer at Office", fontSize: 15, color: .black)
        designationLabel.numberOfLines = 0
        //posted and visibility
        let dayPostedLabel = CustomLabel()
        dayPostedLabel.labelWithText(withTittle: "4d", fontSize: 15, color: .black)
        let visibilityIamgeView = UIImageView(image: UIImage(systemName: "globe"))
        let postedAndVisibiltyView = UIView()
        postedAndVisibiltyView.addSubview(dayPostedLabel)
        postedAndVisibiltyView.addSubview(visibilityIamgeView)
        //vertical stack view for profile info
        let profileAndDesignationStackView = addViewsToVerticalStackView(views: [nameAndConnectionView, designationLabel, postedAndVisibiltyView])
        //follow button
        let followButton = createInstaButton(with: "+ Follow", font: 15, alignment : .right, color: .blue)
        followButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        let innerHorizontalStackView = addViewsToHorizontalStackView(views: [profileImageView, profileAndDesignationStackView, followButton])
        verticalStackView.addArrangedSubview(innerHorizontalStackView)
        //layout constraints
        dayPostedLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(postedAndVisibiltyView)
            make.right.equalTo(visibilityIamgeView.snp.left).inset(-10)
        }
        visibilityIamgeView.snp.makeConstraints { make in
            make.width.equalTo(10)
        }
        profileAndDesignationStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(innerHorizontalStackView).inset(0)
            make.width.equalTo(innerHorizontalStackView.snp.width).multipliedBy(0.6)
        }
        profileImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(innerHorizontalStackView).inset(10)
            make.width.equalTo(innerHorizontalStackView.snp.width).multipliedBy(0.2)
        }
        followButton.snp.makeConstraints { make in
            make.width.equalTo(innerHorizontalStackView.snp.width).multipliedBy(0.2)
        }
        innerHorizontalStackView.snp.makeConstraints { make in
            make.height.equalTo(85)
        }
    }
    
    private func setupPostTextView() {
        let postTextView = UITextView()
        postTextView.text = "You can post and share content on LinkedIn using the share box at the top of the LinkedIn homepage. Use Start a post from the main share box on the LinkedIn desktop experience to view additional sharing options. Activate to view larger image. Use Start a post to share posts."
        postTextView.font = UIFont.systemFont(ofSize: 15)
        postTextView.textAlignment = .left
        postTextView.isScrollEnabled = true
        verticalStackView.addArrangedSubview(postTextView)
        postTextView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
    
    private func setupPostImageView() {
        let image = UIImage(named: "instaPost")
        let profileImageView = UIImageView(image: image)
        verticalStackView.addArrangedSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
    }
    
    private func setupCommentsandLikeView() {
        let likeButton = createInstaButton(with: "2267", font: 15, alignment : .left)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        let commentButton = createInstaButton(with: "299 comments", font: 15, alignment : .right)
        addViewsToHorizontalStackView(views: [likeButton, commentButton])
    }
    
    private func setupFooter() {
        let likeView = createButtonWithTopImage(with: "Like", systemImageName: "hand.thumbsup", font: 15, alignment: .center)
        let commentView = createButtonWithTopImage(with: "Comment", systemImageName: "message", font: 15, alignment: .center)
        let shareView = createButtonWithTopImage(with: "Share", systemImageName: "arrowshape.turn.up.right", font: 15, alignment: .center)
        let sendView = createButtonWithTopImage(with: "Send", systemImageName: "arrow.up.right", font: 15, alignment: .center)
        addViewsToHorizontalStackView(views: [likeView, commentView, shareView, sendView], distribution: .fillEqually)
    }
    
    private func addViewsToHorizontalStackView(views : [UIView], distribution : UIStackView.Distribution = .fillProportionally, spacing : CGFloat = 10) -> UIStackView {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = distribution
        horizontalStackView.alignment = .fill
        horizontalStackView.spacing = spacing
        for view in views {
            horizontalStackView.addArrangedSubview(view)
        }
        verticalStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints { make in
            make.left.right.equalTo(verticalStackView).inset(10)
        }
        return horizontalStackView
    }
    
    private func addViewsToVerticalStackView(views : [UIView], spacing : CGFloat = 5) -> UIStackView {
        let innerVerticalStackView = UIStackView()
        innerVerticalStackView.axis = .vertical
        innerVerticalStackView.distribution = .fill
        innerVerticalStackView.alignment = .fill
        innerVerticalStackView.spacing = spacing
        for view in views {
            innerVerticalStackView.addArrangedSubview(view)
        }
        return innerVerticalStackView
    }
    
    private func createInstaButton(with text : String, font : CGFloat, alignment : UIControl.ContentHorizontalAlignment, color : UIColor = .darkGray) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: font)
        button.setTitleColor(color, for: .normal)
        button.contentHorizontalAlignment = alignment
        return button
    }
    
    private func createButtonWithTopImage(with text : String, systemImageName : String, font : CGFloat, alignment : UIControl.ContentHorizontalAlignment, color : UIColor = .darkGray) -> UIStackView {
        let button = createInstaButton(with: text, font: font, alignment: alignment)
        let imageView = UIImageView(image: UIImage(systemName: systemImageName))
        imageView.contentMode = .center
        let stackView = addViewsToVerticalStackView(views: [imageView, button], spacing: 0)
        return stackView
    }    
}
