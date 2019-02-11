//
//  RequestManager.swift
//  CheckInApp
//
//  Created by Тимур on 11/02/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol IRequestManager {
    func loadModel<Request: IModelRequest>(request: Request, completion: @escaping (Result<Request.Model>) -> Void)
    func sendData(request: BaseRequest)
}

final class RequestManager: IRequestManager {

    private let executor = Executor()

    func sendData(request: BaseRequest) {
        let urlRequest = request.request()
        executor.execute(urlRequest: urlRequest) { (_) in
            <#code#>
        }
    }

    func loadModel<Request>(request: Request, completion: @escaping (Result<Request.Model>) -> Void) where Request: IModelRequest {
        let urlRequest = request.request()
        executor.execute(urlRequest: urlRequest) { (result) in
            switch result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                guard let model = try? jsonDecoder.decode(Request.Model.self, from: data)
                    else { completion(.failure(DataError())); return }
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
