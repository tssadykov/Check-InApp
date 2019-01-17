//
//  DataView.swift
//  CheckInApp
//
//  Created by Тимур on 07/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import UIKit

class NameDateEditView: UIView {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var leftButton: EditFlowButton!
    @IBOutlet var rightButton: EditFlowButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!

    var isEdit: Bool = false {
        willSet {
            if newValue {
                nameTextField.isHidden = false
                nameTextField.text = nameLabel.text
                nameLabel.text = "Фамилия Имя Отчество"
                leftButton.isHidden = false
                rightButton.isHidden = false
                datePicker.isHidden = false
                if let date = dateLabel.text {
                    let dateFormatter = DateFormatter()
                    datePicker.date = dateFormatter.date(from: date) ?? Date()
                }
                dateLabel.text = "Дата рождения"
            } else {
                nameTextField.isHidden = true
                datePicker.isHidden = true
                leftButton.isHidden = true
                rightButton.isHidden = true
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed("NameDateEditView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        datePicker.isHidden = true
        nameTextField.isHidden = true
    }
}
