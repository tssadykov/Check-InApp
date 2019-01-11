//
//  DataRegisterViewController.swift
//  CheckInApp
//
//  Created by Тимур on 05/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import UIKit

class DataRegisterViewController: UIViewController {

    var nameDateDataView: NameDateEditView!
    var dataEditView: NameDateEditView!
    var dataView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameDateDataView = NameDateEditView()
        dataEditView = NameDateEditView()
        view.addSubview(nameDateDataView)
        view.addSubview(dataEditView)
        defaultSetupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupDataViews()
    }

    func setupDataViews() {
        let width = view.frame.width * 0.4
        let height = width * 5 / 4
        let size = CGSize(width: width, height: height)
        nameDateDataView.frame.size = size
        dataEditView.frame.size = size
        let y = view.frame.midY - 20
        let x = view.frame.width * 0.05
        nameDateDataView.frame.origin = CGPoint(x: x, y: y)
        dataEditView.frame.origin = CGPoint(x: x + width + view.frame.width * 0.1, y: y)
    }

    func defaultSetupViews() {
        nameDateDataView.leftButton.isHidden = true
        nameDateDataView.rightButton.isHidden = true

        dataEditView.leftButton.isHidden = true
        dataEditView.rightButton.setTitle("Редактировать", for: .normal)
        dataEditView.rightButton.removeTarget(self, action: #selector(saveTapped(sender:)), for: .touchUpInside)
        dataEditView.rightButton.addTarget(self, action: #selector(editTapped(sender:)), for: .touchUpInside)
    }

    func editSetupViews() {
        nameDateDataView.leftButton.isHidden = false
        nameDateDataView.leftButton.setTitle("Отменить", for: .normal)
        nameDateDataView.leftButton.addTarget(self, action: #selector(cancelTapped(sender:)), for: .touchUpInside)
        nameDateDataView.rightButton.isHidden = false
        nameDateDataView.rightButton.setTitle("Далее", for: .normal)
        nameDateDataView.rightButton.addTarget(self, action: #selector(nextTapped(sender:)), for: .touchUpInside)

        dataEditView.leftButton.isHidden = false
        dataEditView.leftButton.setTitle("Назад", for: .normal)
        dataEditView.leftButton.addTarget(self, action: #selector(backTapped(sender:)), for: .touchUpInside)
        dataEditView.rightButton.setTitle("Сохранить", for: .normal)
        dataEditView.rightButton.removeTarget(self, action: #selector(editTapped(sender:)), for: .touchUpInside)
        dataEditView.rightButton.addTarget(self, action: #selector(saveTapped(sender:)), for: .touchUpInside)
    }

    @objc func editTapped(sender: UIButton) {
        animatingToEdit()
    }

    @objc func cancelTapped(sender: UIButton) {
        animatingToDefault()
    }

    @objc func nextTapped(sender: UIButton) {
        rightFlipAnimation()
    }

    @objc func backTapped(sender: UIButton) {
        leftFlipAnimation()
    }

    @objc func saveTapped(sender: UIButton) {
        animatingToDefault()
    }

    func animatingToEdit() {
        UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseIn, animations: {
            self.nameDateDataView.layer.zPosition = 10
            let xCoord = self.view.bounds.midX - self.nameDateDataView.frame.width/2
            self.nameDateDataView.frame.origin.x = xCoord
            self.dataEditView.frame.origin.x = xCoord
        }, completion: { (_) in
            UIView.animate(withDuration: 1, delay: 0.5, options: .curveLinear, animations: {
                self.nameDateDataView.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.nameDateDataView.nameLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.nameDateDataView.nameTextField.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.nameDateDataView.dateLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.nameDateDataView.datePicker.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.dataEditView.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.dataEditView.nameLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.dataEditView.nameTextField.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.dataEditView.dateLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.dataEditView.datePicker.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }, completion: { (_) in
                self.nameDateDataView.isEdit = true
                self.dataEditView.isEdit = true
                self.dataEditView.isHidden = true
                self.editSetupViews()
                self.dataView = UIView()
                self.nameDateDataView.removeFromSuperview()
                self.dataEditView.removeFromSuperview()
                self.dataView.frame = self.nameDateDataView.frame
                self.view.addSubview(self.dataView)
                self.nameDateDataView.frame = self.dataView.bounds
                self.dataEditView.frame = self.dataView.bounds
                self.dataView.addSubview(self.nameDateDataView)
                self.dataView.addSubview(self.dataEditView)
            })
        })
    }

    func animatingToDefault() {
        nameDateDataView.isHidden = false
        dataEditView.isHidden = false
        nameDateDataView.removeFromSuperview()
        dataEditView.removeFromSuperview()
        dataView.removeFromSuperview()
        view.addSubview(nameDateDataView)
        view.addSubview(dataEditView)
        nameDateDataView.frame = dataView.frame
        dataEditView.frame = dataView.frame
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseIn, animations: {
            self.nameDateDataView.transform = .identity
            self.nameDateDataView.nameLabel.transform = .identity
            self.nameDateDataView.nameTextField.transform = .identity
            self.nameDateDataView.dateLabel.transform = .identity
            self.nameDateDataView.datePicker.transform = .identity
            self.dataEditView.transform = .identity
            self.dataEditView.nameLabel.transform = .identity
            self.dataEditView.nameTextField.transform = .identity
            self.dataEditView.dateLabel.transform = .identity
            self.dataEditView.datePicker.transform = .identity
        }, completion: { (_) in
            UIView.animate(withDuration: 2, delay: 0.5, options: .curveLinear, animations: {
                self.nameDateDataView.layer.zPosition = 1
                let x = self.view.frame.width * 0.05
                self.nameDateDataView.frame.origin.x = x
                self.dataEditView.frame.origin.x = x + self.nameDateDataView.frame.width + self.view.frame.width * 0.1
            }, completion: { (_) in
                self.nameDateDataView.isEdit = false
                self.dataEditView.isEdit = false
                self.defaultSetupViews()
            })
        })
    }

    func leftFlipAnimation() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        UIView.transition(from: dataEditView,
                          to: nameDateDataView,
                          duration: 0.5,
                          options: transitionOptions,
                          completion: nil)
    }

    func rightFlipAnimation() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(from: nameDateDataView,
                          to: dataEditView,
                          duration: 0.5,
                          options: transitionOptions,
                          completion: nil)
    }
}
