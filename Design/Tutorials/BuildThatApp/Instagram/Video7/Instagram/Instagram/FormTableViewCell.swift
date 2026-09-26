//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by David Vasquez on 12/2/24.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField value: String?)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "FormTableViewCell"
    public weak var delegate: FormTableViewCellDelegate?
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
     }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        selectionStyle = .none
        field.delegate = self
    }
    
    public func configure (with model: EditProfileFormModel) {
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    override func layoutSubviews () {
        super.layoutSubviews()
        
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.height)
        field.frame = CGRect(x: formLabel.right + 5, y: 0, width: contentView.width - 10 - formLabel.width, height: contentView.height)
        

        
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
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
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide Keyboard?
        delegate?.formTableViewCell(self, didUpdateField: textField.text)
        textField.resignFirstResponder()
        
        return true
    }

}


