//
//  IRequest.swift
//  CheckInApp
//
//  Created by Тимур on 11/02/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import Foundation

enum RequstType: String {
    case get = "GET"
    case post = "POST"
}

protocol BaseRequest {
    func request() -> URLRequest
    func mainURL() -> String
    func service() -> String
    func type() -> RequstType
    func header() -> String
}

extension BaseRequest {
    func mainURL() -> String {
        return "url"
    }
}

protocol IModelRequest: BaseRequest {
    associatedtype Model: Codable
}
