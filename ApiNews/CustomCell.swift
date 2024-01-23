
import UIKit

class CustomCell: UITableViewCell {
    
    static var reuiCellName = "cell"

    let customImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let customTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() {
        self.addSubview(customImageView)
        self.addSubview(customTextLabel)
        
        NSLayoutConstraint.activate([
            
            customImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            customImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 40),
            customImageView.heightAnchor.constraint(equalTo: customImageView.widthAnchor),
            
            customTextLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 8),
            customTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            customTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8), // Верхний отступ
            customTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8), // Нижний отступ
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
