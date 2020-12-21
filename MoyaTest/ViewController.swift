//
//  ViewController.swift
//  MoyaTest
//
//  Created by Min on 2020/12/21.
//

import UIKit
import Moya
import Alamofire

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    client.request(.test) { result in
      switch result {
        case .success(let response):
          debugPrint(result)
          do {
            let decoder = try JSONDecoder().decode(CampaignInfoModel.self, from: response.data)
            dump(decoder)
          } catch {
            print("decadoble failure, error is \(error.localizedDescription)")
          }
        case .failure(let error):
          print("request failure, error is \(error)")
      }
    }
  }
}


let client = MoyaProvider<APITest>(plugins: [NetworkLoggerPlugin()])

enum APITest {
  case test
}

extension APITest: TargetType {
  var baseURL: URL {
    guard let baseURL = URL(string: "https://www.pr.icook.tw/") else {
      fatalError("URL init failure")
    }
    return baseURL
  }

  var path: String {
    return "_functions/hasCampaign"
//    return "_functions/hasCampaign.json"
  }

  var method: Moya.Method {
    return .get
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    let data = ["listId": 123456]
    return .requestParameters(parameters: data, encoding: URLEncoding.queryString)
  }

  var headers: [String : String]? {
    return nil
  }
}
