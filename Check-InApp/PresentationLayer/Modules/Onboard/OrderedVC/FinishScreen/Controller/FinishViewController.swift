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

    unowned var assembly: IPresentationAssembly

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupFinishButton()
    }

    init(assembly: IPresentationAssembly) {
        self.assembly = assembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func finishButtonTapped(_ sender: UIButton) {
        guard let pageVC = parent as? OnboardPageViewController else { return }
        UserDefaults.standard.set(true, forKey: "isWatchingOnboard")
        pageVC.dismiss(animated: true, completion: nil)
    }

    private func setupFinishButton() {
        finishButton.layer.cornerRadius = finishButton.bounds.width * 0.05
        finishButton.clipsToBounds = true
    }
}
