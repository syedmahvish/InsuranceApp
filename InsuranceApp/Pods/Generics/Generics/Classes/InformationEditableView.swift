import UIKit
import SnapKit

open class InformationEditableView: UIView {
    lazy var infoLabel = CustomLabel()
    public lazy var infoTextField = CustomTextField()
    private lazy var horizontalStackView = CustomHorizontalstackView()
    
    public func setViewWithLabel(withText text : String?, andTextField placeHolderText : String?){
        setLabelText(withText: text)
        setTextFieldPlaceholder(withPlaceHolderText: placeHolderText)
        addViews()
        setupLayout()
    }
    
    private func setLabelText(withText text : String?) {
        guard let validText = text
        else {
            return
        }
        if validText.isValidString() {
            infoLabel.labelWithBlueColorAndSystemFont(withTittle: validText, fontSize: Float(FontConstant.FONT_SIZE_20.rawValue))
            return
        }
        print("Please enter valid label text.")
    }
    
    private func setTextFieldPlaceholder(withPlaceHolderText placeholderText : String?) {
        guard let validText = placeholderText
        else {
            return
        }
        if validText.isValidString() {
            infoTextField.textFieldWithBorderAndPlaceHolder(placeHoldertext: validText, textValue: nil)
            return
        }
        print("Please enter valid textfield placeholder text.")
    }
    
    private func addViews() {
        self.addSubview(horizontalStackView)
        var viewsArray = [ViewWithProportionality]()
        viewsArray.append(ViewWithProportionality(view : infoLabel, proportionValue : 0.5))
        viewsArray.append(ViewWithProportionality(view : infoTextField, proportionValue : 0.7))
        horizontalStackView.addViewsWithDistributionProportionally(viewsDict: viewsArray, spacing: 5)
    }
    
    private func setupLayout() {
        horizontalStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(5)
        }
    }
}

