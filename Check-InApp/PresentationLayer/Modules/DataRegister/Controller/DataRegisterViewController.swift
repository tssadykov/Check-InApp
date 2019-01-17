//
//  DataRegisterViewController.swift
//  CheckInApp
//
//  Created by Тимур on 05/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import UIKit

class DataRegisterViewController: UIViewController {

    @IBOutlet var editButton: UIButton!
    var nameDateDataView: NameDateEditView!
    var dataEditView: NameDateEditView!
    var dataView: UIView!
    var didViewsInstalled: Bool = false
    unowned var assembly: IPresentationAssembly

    override func viewDidLoad() {
        super.viewDidLoad()

        nameDateDataView = NameDateEditView()
        dataEditView = NameDateEditView()
        view.addSubview(nameDateDataView)
        view.addSubview(dataEditView)
        addActionsForDataViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !didViewsInstalled {
            setupViews()
            didViewsInstalled = true
        }
    }

    init(assembly: IPresentationAssembly) {
        self.assembly = assembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        setupDataViews()
        editButton.layer.cornerRadius = editButton.frame.width * 0.05
    }

    private func setupDataViews() {
        let width = view.frame.width * 0.4
        let height = width * 3 / 2
        let size = CGSize(width: width, height: height)
        nameDateDataView.frame.size = size
        dataEditView.frame.size = size
        let y = view.frame.maxY - 2*height
        let x = view.frame.width * 0.05
        nameDateDataView.frame.origin = CGPoint(x: x, y: y)
        dataEditView.frame.origin = CGPoint(x: x + width + view.frame.width * 0.1, y: y)
        nameDateDataView.isEdit = false
        dataEditView.isEdit = false
        nameDateDataView.leftButton.setImage(named: "forbidden-mark")
        nameDateDataView.rightButton.setImage(named: "forward")
        dataEditView.leftButton.setImage(named: "back")
        dataEditView.rightButton.setImage(named: "tick-sign")
        setShadows(for: editButton)
        setShadows(for: nameDateDataView)
        setShadows(for: dataEditView)
    }

    private func setShadows(for view: UIView) {
        view.layer.shadowRadius = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shouldRasterize = true
    }
    
    private func addActionsForDataViews() {
        nameDateDataView.leftButton.addTarget(self, action: #selector(cancelTapped(sender:)), for: .touchUpInside)
        nameDateDataView.rightButton.addTarget(self, action: #selector(nextTapped(sender:)), for: .touchUpInside)

        dataEditView.leftButton.addTarget(self, action: #selector(backTapped(sender:)), for: .touchUpInside)
        dataEditView.rightButton.addTarget(self, action: #selector(saveTapped(sender:)), for: .touchUpInside)
    }

    @IBAction func editButtonTapped(_ sender: UIButton) {
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

    private func animatingToEdit() {
        UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseInOut, animations: {
            self.editButton.isHidden = true
            self.nameDateDataView.layer.zPosition = 10
            let xCoord = self.view.bounds.midX - self.nameDateDataView.frame.width/2
            self.nameDateDataView.frame.origin.x = xCoord
            self.dataEditView.frame.origin.x = xCoord
        }, completion: { (_) in
            UIView.animate(withDuration: 1, delay: 0.5, options: [.curveLinear, .layoutSubviews], animations: {
                let rect = self.nameDateDataView.frame
                let newRect = CGRect(x: rect.minX - rect.width/2,
                                     y: rect.minY - rect.height/2,
                                     width: rect.width*2, height: rect.height*2)
                self.nameDateDataView.frame = newRect
                self.dataEditView.frame = newRect
            }, completion: { (_) in
                self.nameDateDataView.isEdit = true
                self.dataEditView.isEdit = true
                self.dataEditView.isHidden = true
                self.dataEditView.frame = self.nameDateDataView.frame
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

    private func animatingToDefault() {
        nameDateDataView.isHidden = false
        dataEditView.isHidden = false
        nameDateDataView.removeFromSuperview()
        dataEditView.removeFromSuperview()
        dataView.removeFromSuperview()
        view.addSubview(nameDateDataView)
        view.addSubview(dataEditView)
        nameDateDataView.frame = dataView.frame
        dataEditView.frame = dataView.frame
        nameDateDataView.isEdit = false
        dataEditView.isEdit = false
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseIn, animations: {

            let rect = self.nameDateDataView.frame
            let newRect = CGRect(x: rect.minX + rect.width/4, y: rect.minY + rect.height/4,
                                 width: rect.width/2, height: rect.height/2)
            self.nameDateDataView.frame = newRect
            self.dataEditView.frame = newRect
        }, completion: { (_) in
            UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseInOut, animations: {
                self.nameDateDataView.layer.zPosition = 0
                self.dataEditView.layer.zPosition = 0
                let x = self.view.frame.width * 0.05
                self.nameDateDataView.frame.origin.x = x
                self.dataEditView.frame.origin.x = x + self.nameDateDataView.frame.width + self.view.frame.width * 0.1
            }, completion: { (_) in
                self.editButton.isHidden = false
        })
    })
    }

    private func leftFlipAnimation() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        UIView.transition(from: dataEditView,
                          to: nameDateDataView,
                          duration: 0.5,
                          options: transitionOptions,
                          completion: nil)
        nameDateDataView.layer.zPosition = 10
        dataEditView.layer.zPosition = 0
    }

    private func rightFlipAnimation() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(from: nameDateDataView,
                          to: dataEditView,
                          duration: 0.5,
                          options: transitionOptions,
                          completion: nil)
        nameDateDataView.layer.zPosition = 0
        dataEditView.layer.zPosition = 10
    }
}
