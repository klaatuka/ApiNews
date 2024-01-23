

import UIKit

class DetailViewController: UIViewController {
  
    var imageFromApi: String? = nil
    lazy var imageOfNews: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        return img
    }()
    lazy var titleLabFromInet: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.font = .systemFont(ofSize: 16, weight: .bold)
        return text
    }()
    
    lazy var describeNiews: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Подробности"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeBtnAct))
        view.backgroundColor = #colorLiteral(red: 0.9696468711, green: 0.9239659905, blue: 0.7669146657, alpha: 1)
        
        if let imggg = imageFromApi {
            let imageURL = URL(string: imggg)!
            imageOfNews.load(url: imageURL)
        }
        view.addSubview(describeNiews)
        view.addSubview(imageOfNews)
        view.addSubview(titleLabFromInet)
        
        print("\(String(describing: imageFromApi))") //тестирую
        
        NSLayoutConstraint.activate([
            titleLabFromInet.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleLabFromInet.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabFromInet.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            describeNiews.topAnchor.constraint(equalTo: titleLabFromInet.bottomAnchor, constant: 20),
            describeNiews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            describeNiews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            describeNiews.bottomAnchor.constraint(equalTo: imageOfNews.topAnchor, constant: -20),

            imageOfNews.topAnchor.constraint(equalTo: describeNiews.bottomAnchor, constant: 20),
            imageOfNews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageOfNews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageOfNews.heightAnchor.constraint(equalTo: imageOfNews.widthAnchor, multiplier: 0.75)
        ])
    }
    @objc func closeBtnAct() {
        navigationController?.popViewController(animated: true)
    }
}
