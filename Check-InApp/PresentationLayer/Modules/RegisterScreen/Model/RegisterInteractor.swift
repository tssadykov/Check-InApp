//
//  RegisterInteractor.swift
//  CheckInApp
//
//  Created by Тимур on 17/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import Foundation

protocol IRegisterInteractor {
    var companies: [Aircompany
        ] { get set }
}

class RegisterInteractor: IRegisterInteractor {
    var companies: [Aircompany]

    init(companies: [Aircompany]) {
        self.companies = companies
    }
}
