
import UIKit
import Alamofire

protocol HomeBusinessLogic
{
    func doSomething(request: Home.Something.Request)
}

protocol HomeDataStore
{
  //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore
{
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    var listData = [Repository]()
  
  // MARK: Do something
  
    func doSomething(request: Home.Something.Request)
    {
        worker = HomeWorker()
        worker?.doSomeWork()
        
        AF.request("https://api.github.com/search/repositories?q=ios&per_page=20&page=1")
            .validate()
            .responseDecodable(of: RepositorysGH.self) { (response) in
                guard let repositorys = response.value else { return }
                self.listData = repositorys.all
                let response = Home.Something.Response(repositories: self.listData)
                self.presenter?.presentSomething(response: response)
            }
    }
}
