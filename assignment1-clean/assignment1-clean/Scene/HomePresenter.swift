
import UIKit

protocol HomePresentationLogic
{
    func presentRepositories(response: Home.Repositories.Response)
}

class HomePresenter: HomePresentationLogic
{
  weak var viewController: HomeDisplayLogic?
  
  // MARK: Do something
  
    func presentRepositories(response: Home.Repositories.Response)
    {
        let displayedRepositories = response.repositories.map{ convert(repository: $0) }
        let viewModel = Home.Repositories.ViewModel(displayedRepositories: displayedRepositories)
        viewController?.displayRepositories(viewModel: viewModel)
    }
    
    // MARK: Format repository to displayed repository
    private func convert(repository: Repository) -> Home.DisplayedRepository
    {
        let fullname = repository.fullname
        let avatar = repository.owner.avatar
        return Home.DisplayedRepository(fullname: fullname, avatar: avatar)
    }
}
