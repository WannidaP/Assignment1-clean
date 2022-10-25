
import UIKit

protocol HomePresentationLogic
{
    func presentSomething(response: Home.Something.Response)
}

class HomePresenter: HomePresentationLogic
{
  weak var viewController: HomeDisplayLogic?
  
  // MARK: Do something
  
    func presentSomething(response: Home.Something.Response)
    {
        let displayedRepositories = response.repositories.map{ convert(repository: $0) }
        let viewModel = Home.Something.ViewModel(displayedRepositories: displayedRepositories)
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    // MARK: Format repository to displayed repository
    private func convert(repository: Repository) -> Home.DisplayedRepository
    {
        let fullname = repository.fullname
        let avatar = repository.owner.avatar
        return Home.DisplayedRepository(fullname: fullname, avatar: avatar)
    }
}
