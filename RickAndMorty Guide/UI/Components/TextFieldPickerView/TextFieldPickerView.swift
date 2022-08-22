//
//  TextFieldPickerView.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 28.07.2022.
//

import Foundation
import UIKit

protocol TextFieldPickerViewOutputDelegate : AnyObject {
    func filterPickerDidSelect(index: Int)
}

class TextFieldPickerView : UIView, CustomViewProtocol {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var txtPickerFilterType: UITextField!
    weak var delegate : TextFieldPickerViewOutputDelegate?
    let pickerView = UIPickerView()
    
    var filterValues : [String]? {
        didSet {
            createrPickerView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func initialize() {
        self.commonInit(for: nibName())
    }
    
    private func createrPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        txtPickerFilterType.inputView = pickerView
    }
}


extension TextFieldPickerView : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterValues?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filterValues?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .blackColor
        label.textAlignment = .center
        label.text = filterValues?[row]
        label.font = UIFont.fontRickAndMorty(size: 30)
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = filterValues?[row]
        
        txtPickerFilterType.text = value
        delegate?.filterPickerDidSelect(index: row)
        txtPickerFilterType.resignFirstResponder()
    }
}
