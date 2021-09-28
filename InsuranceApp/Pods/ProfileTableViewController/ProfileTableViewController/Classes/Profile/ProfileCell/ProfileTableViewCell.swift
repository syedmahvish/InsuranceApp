import UIKit
import Generics

class ProfileTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: self)
    
    private lazy var infoLabel = CustomLabel()
    lazy var infoTextField : CustomTextField = {
        let textfield = CustomTextField()
        textfield.delegate = self
        return textfield
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        var viewItems = [ViewWithProportionality]()
        var viewItem = ViewWithProportionality(view: infoLabel, proportionValue: 0.5)
        viewItems.append(viewItem)
        viewItem = ViewWithProportionality(view: infoTextField, proportionValue: 0.7)
        viewItems.append(viewItem)
        let stackview = CustomHorizontalstackView()
        stackview.addViewsWithDistributionProportionally(viewsDict: viewItems, spacing: 5)
        contentView.addSubview(stackview)
        stackview.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(5)
            make.left.right.equalTo(contentView).inset(10)
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

//MARK:- Cell configuration
extension ProfileTableViewCell {
    
    func cofigureCell(withProfileInformation profileModel: ProfileInformationViewModel) {
        infoLabel.labelWithBlueColorAndSystemFont(withTittle: profileModel.labelTitle, fontSize: Float(FontConstant.FONT_SIZE_17.rawValue))
        infoTextField.textFieldWithPlaceHolder(placeHoldertext: nil, textValue: profileModel.textFieldValue)
    }
}

//MARK:- UITextField Delegates
extension ProfileTableViewCell : UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.contentView.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
