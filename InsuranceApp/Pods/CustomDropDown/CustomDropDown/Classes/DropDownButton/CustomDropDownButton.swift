import UIKit
import Generics

public class CustomDropDownButton: CustomButton {
    public var stateModelArray : [StateModel]?
    public let dropDown = CustomDropDown()
    var dropDownRowHeight: CGFloat = 30
    public var delegate : CustomDropDownButtonDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton(withFrame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureButton(withFrame frame : CGRect) {
        self.buttonWithText(withText: EmptyTextConstant.emptyTextValue.rawValue, fontSize: FontConstant.FONT_SIZE_17.rawValue, andImage: ImageString.dropDownImage.rawValue, height: frame.height)
        self.addTarget(self, action: #selector(dropDownButtonTapped), for: .touchUpInside)
        dropDown.customDropDownIdentifier = "DROP_DOWN_STATE"
        dropDown.cellReusableIdentifier = ReuseIdentifierString.dropDownCellIdentifier.rawValue
        dropDown.customDropDownDataSourceProtocol = self
        dropDown.setUpDropDown(viewPositionReference: frame, offset: 0)
        registerWithNib(for: "CustomDropDownCell")
        dropDown.setRowHeight(height: self.dropDownRowHeight)
        dropDown.isUserInteractionEnabled = true
        self.addSubview(dropDown)
    }
    
    @objc func dropDownButtonTapped() {
        delegate?.showDropDown(height: self.dropDownRowHeight * 3)
    }

    private func registerWithNib(for classString : String) {
        let podBundle = Bundle(for: self.classForCoder)
        guard let bundleURL = podBundle.url(forResource: "CustomDropDown", withExtension: "bundle"),
              let bundle = Bundle(url: bundleURL)
        else {
            return
        }
        
        dropDown.nib = UINib(nibName: classString, bundle: bundle)
    }
}

extension CustomDropDownButton : CustomDropDownDataSourceProtocol {
    
    func getDataToDropDown(cell: UITableViewCell, indexPos: Int, makeDropDownIdentifier : String) {
        if makeDropDownIdentifier == "DROP_DOWN_STATE" {
            let customCell = cell as! CustomDropDownCell
            customCell.stateNameLabel.text = stateModelArray?[indexPos].stateName
        }
    }
    
    func numberOfRows(makeDropDownIdentifier: String) -> Int {
        return stateModelArray?.count ?? 0
    }
    
    func selectItemInDropDown(indexPos: Int, makeDropDownIdentifier: String) {
        let selectedState = stateModelArray?[indexPos].stateName
        self.setTitle(selectedState, for: .normal)
        self.dropDown.hideDropDown()
        delegate?.hideDropDown(with: selectedState)
    }
}


public protocol CustomDropDownButtonDelegate {
    func showDropDown(height : CGFloat)
    func hideDropDown(with selectedText : String?)
}
