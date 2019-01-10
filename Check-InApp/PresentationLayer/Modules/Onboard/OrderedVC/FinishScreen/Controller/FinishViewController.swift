//
//  FinishViewController.swift
//  CheckInApp
//
//  Created by Тимур on 06/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    @IBOutlet var finishButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupFinishButton()
    }

    @IBAction func finishButtonTapped(_ sender: UIButton) {
        guard let pageVC = parent as? OnboardPageViewController else { return }
        UserDefaults.standard.set(true, forKey: "IsIntroWatched")
        pageVC.dismiss(animated: true, completion: nil)
    }

    func setupFinishButton() {
        finishButton.layer.cornerRadius = finishButton.bounds.width * 0.05
        finishButton.clipsToBounds = true
    }
}
