

import Foundation
class Service {
    
    func getNews(value: String, limit: String, completion: @escaping ([OneNews]) -> ()){
        //1 url
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "newsapi.org"
        urlComponent.path = "/v2/everything"
        
        urlComponent.queryItems = [
            URLQueryItem(name: "q", value: value),
            URLQueryItem(name: "pageSize", value: limit),
            URLQueryItem(name: "apiKey", value: "1e7d4b3f76c341b7962e747954f24a13"),
            URLQueryItem(name: "language", value: "ru")
        ]
        
        //2 Запрос
        if let url = urlComponent.url{
            let query = URLRequest(url: url)
            //3 выполнить запрос
            URLSession.shared.dataTask(with: query) { data, res, err in
                guard err == nil else {
                    print(err!.localizedDescription)
                    return
                }
                //                print(res)
                if let responceData = data {
                    
                    if let result = try? JSONDecoder().decode(Responce.self, from: responceData){
                        //                        print(result.articles.first?.author)
                        DispatchQueue.main.async {
                            completion(result.articles)
                        }
                    }
                }
            }.resume()
        }
        
    }
    
}

struct Responce: Decodable {
    var articles: [OneNews]
}

struct OneNews: Decodable {
    var author: String?
    var title: String?
    var description: String?
    var urlToImage: String?
}
