//
//  Aircompany.swift
//  CheckInApp
//
//  Created by Тимур on 17/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import Foundation

protocol ICompany {
    var name: String { get set }
    var id: String { get set }
}

struct Aircompany: ICompany, Codable {
    var name: String
    var id: String
}
