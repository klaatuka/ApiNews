

import UIKit

class ViewController: UIViewController {
    let service = Service()
    var articles: [OneNews] = []
    lazy var tableview: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reuiCellName)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = #colorLiteral(red: 0.9696468711, green: 0.9239659905, blue: 0.7669146657, alpha: 1)
        return table
    }()
    lazy var searchBtn: UIButton = {
        let btn = UIButton(primaryAction: searchBtnAct)
        btn.setTitle("Поиск", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.8477413058, green: 0.4423024654, blue: 0.007165560499, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.tintColor = .white
        return btn
    }()
    lazy var searchBtnAct = UIAction { _ in
        
        self.service.getNews(value: self.inputText.text ?? "", limit: "20") { articles in
            self.articles = articles
            self.tableview.reloadData()
        }
    }
    lazy var inputText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.968627451, blue: 0.9333333333, alpha: 1)
        text.font = .systemFont(ofSize: 16, weight: .bold)
        text.delegate = self
        text.layer.cornerRadius = 10
        text.clipsToBounds = true
        text.placeholder = "введите текст для поиска"
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: text.frame.height))
        text.leftView = leftView
        text.leftViewMode = .always
        text.layer.borderColor = #colorLiteral(red: 0.8477413058, green: 0.4423024654, blue: 0.007165560499, alpha: 1)
        text.layer.borderWidth = 1.0
        
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9696468711, green: 0.9239659905, blue: 0.7669146657, alpha: 1)
        title = "Новости"
        setTable()
    }
    func setTable(){
        view.addSubview(tableview)
        view.addSubview(searchBtn)
        view.addSubview(inputText)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: inputText.topAnchor, constant: -20).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        inputText.topAnchor.constraint(equalTo: tableview.bottomAnchor, constant: 20).isActive = true
        inputText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        inputText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        inputText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        searchBtn.topAnchor.constraint(equalTo: inputText.bottomAnchor, constant: 20).isActive = true
        searchBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        searchBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        searchBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        searchBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuiCellName, for: indexPath) as? CustomCell {
            cell.customTextLabel.text = articles[indexPath.row].title
            
            // Загрузка изображения
            let imageURL = URL(string: articles[indexPath.row].urlToImage ?? "")
            if let imgUnwrap = imageURL {
                cell.customImageView.load(url: imgUnwrap)
            }
            cell.selectionStyle = .none
            cell.backgroundColor = #colorLiteral(red: 0.9696468711, green: 0.9239659905, blue: 0.7669146657, alpha: 1)
            return cell
        }
        return UITableViewCell()
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.titleLabFromInet.text = articles[indexPath.row].title
        vc.describeNiews.text = articles[indexPath.row].description
        vc.imageFromApi = articles[indexPath.row].urlToImage
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.service.getNews(value: self.inputText.text ?? "", limit: "20") { articles in
            self.articles = articles
            self.tableview.reloadData()
        }
        return true
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
