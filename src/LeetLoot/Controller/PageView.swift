//
//  PageViewController.swift
//  LeetLoot
//
//  Created by Will on 12/28/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class PageView: UIViewController {
    
    lazy var menuBar = { () -> Menu in
        let view = Menu()
            view.delegate = self
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var pages: [UIViewController] = {
        let home = Home()
        let browse = Browse()
        return [home, browse]
    }()
    
    private var menuOp = Menu.Options.menu
    
    lazy var pageCarousel = { () -> ScrollView in
        let scrollView = ScrollView()
            scrollView.createScrollableViews(forPages: pages, controller: self)
            scrollView.contentSize.width = view.bounds.size.width * CGFloat(pages.count)
            scrollView.delegate = self
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set navigation bar
        navigationItem.title = "LeetLoot"
        navigationController?.navigationBar.isTranslucent = false;
        
        setupMenuBar()
        setupNavBar()
    }
    
    private func setupNavBar() {
        let signIn = UIBarButtonItem(title: "Browse game", style: .plain, target: self, action: #selector(onSignIn(sender: )))
        navigationItem.leftBarButtonItem = signIn
    }
    
    @objc
    private func onSignIn(sender: UIBarButtonItem) {
        //signIn.openMenu()
        let layout = UICollectionViewFlowLayout()
        let myPge = Browse_Game(collectionViewLayout: layout)
        navigationController?.pushViewController(myPge, animated: true)
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addSubview(pageCarousel)
        
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.topAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 45),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pageCarousel.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            pageCarousel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

//Mark: ScrollViewDelegate
extension PageView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        
        //Prevents scroll bar from extending beyond Home and Browse positions
        if 0...Constants.kWidth  ~= offsetX {
            menuBar.menuOptionsBar.frame.origin.x = (offsetX / menuBar.optionsCount) + (Constants.kWidth / menuBar.optionsCount)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        menuOp = menuOp == .Home ? .Browse : .Home
    }
}

//Mark: MenuBarDelegate
extension PageView: MenuBarDelegate {
    func onMenuButtons(_ sender: UIButton) {
        menuOp = sender.tag == 0 ? .Home : .Browse
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseInOut ,
                       animations: {
            self.pageCarousel.contentOffset.x = self.menuOp == .Home ? (Constants.kWidth - Constants.kWidth) : Constants.kWidth
            self.view.layoutIfNeeded()
        })
    }
}
