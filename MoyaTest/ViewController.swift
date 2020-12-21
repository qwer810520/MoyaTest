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
          let responseData = response.data
          print("debugDescription: ", response.debugDescription)
          print("statusCode: \(response.statusCode)")
          print("result: \(String(data: responseData, encoding: .utf8))")
        case .failure(let error):
          print("request failure, error is \(error)")
      }
    }

    DispatchQueue.main.async {
      let type = APITest.test
      AF.request(type.baseURL.absoluteString + type.path).responseData { response in
        switch response.result {
          case .success(let data):
            print("AF request success, statusCode is \(response.response?.statusCode ?? 0)")
          case .failure(let error):
            print("AF request failure, error is \(error.localizedDescription)")
        }
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
    return "_functions/hasCampaign?listId=123456"
//    return "_functions/hasCampaign.json"
  }

  var method: Moya.Method {
    return .get
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    return .requestPlain
  }

  var headers: [String : String]? {
    return nil
  }
}



