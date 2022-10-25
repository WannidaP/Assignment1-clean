
import UIKit

struct RepositoriesGH: Decodable {
    var all: [Repository]
    enum CodingKeys: String, CodingKey {
      case all = "items"
  }
}
struct Repository: Decodable {
    var fullname: String
    var owner: Owner
    enum CodingKeys: String, CodingKey {
      case fullname = "full_name"
      case owner
  }
}
struct Owner: Decodable {
    var avatar: String
    enum CodingKeys: String, CodingKey {
        case avatar = "avatar_url"
    }
}


enum Home
{
    struct DisplayedRepository {
        var fullname: String
        var avatar: String
    }
  // MARK: Use cases
  
    enum Repositories
    {
        struct Request
        {
        }
        struct Response
        {
          var repositories: [Repository]
        }
        struct ViewModel
        {
          var displayedRepositories: [DisplayedRepository]
            
        }
    }
}
