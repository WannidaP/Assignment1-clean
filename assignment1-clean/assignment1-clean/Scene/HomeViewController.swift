
import UIKit

protocol HomeDisplayLogic: class
{
    func displaySomething(viewModel: Home.Something.ViewModel)
}

class HomeViewController: UITableViewController, HomeDisplayLogic
{
  var interactor: HomeBusinessLogic?
  var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
    }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    
    // MARK: Table view
    
    var displayedRepositories = [Home.DisplayedRepository]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return displayedRepositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let data = displayedRepositories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoryTableViewCell
        cell.fullnameLabel.text = data.fullname
        cell.avatarImage.loadFrom(URLAddress: data.avatar)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
  
    private var indexPath: IndexPath?
    
    func doSomething()
    {
        let request = Home.Something.Request()
        interactor?.doSomething(request: request)
    }
  
    func displaySomething(viewModel: Home.Something.ViewModel)
    {
        displayedRepositories = viewModel.displayedRepositories
        tableView.reloadData()
    }
}
