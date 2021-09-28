import Foundation
import UIKit
import SnapKit

protocol CustomDropDownDataSourceProtocol {
    func getDataToDropDown(cell: UITableViewCell, indexPos: Int, makeDropDownIdentifier: String)
    func numberOfRows(makeDropDownIdentifier: String) -> Int
    func selectItemInDropDown(indexPos: Int, makeDropDownIdentifier: String)
}

extension CustomDropDownDataSourceProtocol {
    func selectItemInDropDown(indexPos: Int, makeDropDownIdentifier: String) {}
}

open class CustomDropDown: UIView {
    var customDropDownIdentifier: String = "DROP_DOWN"
    var cellReusableIdentifier: String = "dropDownCell"
    var dropDownTableView: UITableView?
    var width: CGFloat = 0
    var offset:CGFloat = 0
    var customDropDownDataSourceProtocol: CustomDropDownDataSourceProtocol?
    var nib: UINib?{
        didSet{
            dropDownTableView?.register(nib, forCellReuseIdentifier: self.cellReusableIdentifier)
        }
    }
    var viewPositionRef: CGRect?
    var isDropDownPresent: Bool = false
    
    
    //MARK: - DropDown Methods
    func setUpDropDown(viewPositionReference: CGRect,  offset: CGFloat){
        self.addBorders()
        self.addShadowToView()
        self.frame = CGRect(x: viewPositionReference.minX, y: viewPositionReference.maxY + offset, width: 0, height: 0)
        dropDownTableView = UITableView()
        
        self.width = viewPositionReference.width
        self.offset = offset
        self.viewPositionRef = viewPositionReference
        dropDownTableView?.showsVerticalScrollIndicator = false
        dropDownTableView?.showsHorizontalScrollIndicator = false
        dropDownTableView?.backgroundColor = .white
        dropDownTableView?.separatorStyle = .none
        dropDownTableView?.delegate = self
        dropDownTableView?.dataSource = self
        dropDownTableView?.allowsSelection = true
        dropDownTableView?.isUserInteractionEnabled = true
        dropDownTableView?.tableFooterView = UIView()
        self.addSubview(dropDownTableView!)
        
        dropDownTableView?.snp.makeConstraints{ make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }

    // Use this method if you want change height again and again
    // For eg in UISearchBar DropDownMenu
    func reloadDropDown(height: CGFloat){
        self.frame = CGRect(x: (self.viewPositionRef?.minX)!, y: (self.viewPositionRef?.maxY)!
                                + self.offset, width: width, height: 0)
        self.dropDownTableView?.reloadData()
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.05, options: .curveLinear
                       , animations: {
                        self.frame.size = CGSize(width: self.width, height: height)
                       })
    }
    
    //Sets Row Height of your Custom XIB
    func setRowHeight(height: CGFloat){
        self.dropDownTableView?.rowHeight = height
        self.dropDownTableView?.estimatedRowHeight = height
    }
    
    // Removes DropDown Menu
    // Use it only if needed
    func removeDropDown(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveLinear
                       , animations: {
                        self.dropDownTableView?.frame.size = CGSize(width: 0, height: 0)
                       }) { (_) in
            self.removeFromSuperview()
            self.dropDownTableView?.removeFromSuperview()
        }
    }
}

extension CustomDropDown {
    // Shows Drop Down Menu
    public func showDropDown(frame: CGRect){
        if isDropDownPresent{
            self.hideDropDown()
        } else {
            self.dropDownTableView?.reloadData()
            self.frame = frame
        }
    }
    
    //Hides DropDownMenu
    public func hideDropDown(){
        isDropDownPresent = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveLinear
                       , animations: {
                        self.frame.size = CGSize(width: self.width, height: 0)
                       })
    }
}

// MARK: - Table View Methods
extension CustomDropDown : UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (customDropDownDataSourceProtocol?.numberOfRows(makeDropDownIdentifier: self.customDropDownIdentifier) ?? 0)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (dropDownTableView?.dequeueReusableCell(withIdentifier: self.cellReusableIdentifier) ?? UITableViewCell())
        customDropDownDataSourceProtocol?.getDataToDropDown(cell: cell, indexPos: indexPath.row, makeDropDownIdentifier: self.customDropDownIdentifier)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customDropDownDataSourceProtocol?.selectItemInDropDown(indexPos: indexPath.row, makeDropDownIdentifier: self.customDropDownIdentifier)
    }
    
}

//MARK: - UIView Extension
extension UIView {
    func addBorders(borderWidth: CGFloat = 0.2, borderColor: CGColor = UIColor.lightGray.cgColor){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
    
    func addShadowToView(shadowRadius: CGFloat = 2, alphaComponent: CGFloat = 0.6) {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: alphaComponent).cgColor
        self.layer.shadowOffset = CGSize(width: -1, height: 2)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 1
    }
}

