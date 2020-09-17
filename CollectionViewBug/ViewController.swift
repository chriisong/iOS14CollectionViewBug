//
//  ViewController.swift
//  CollectionViewBug
//
//  Created by Chris Song on 2020-09-17.
//

import UIKit

class ViewController: UIViewController {

    var ncButton: UIButton!
    var vcButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    
    func configureButtons() {
        let ncAction = UIAction(title: "Push View Controller", handler: pushViewController)
        let vcAction = UIAction(title: "Present View Controller", handler: presentViewController)
        ncButton = UIButton(frame: .zero, primaryAction: ncAction)
        vcButton = UIButton(frame: .zero, primaryAction: vcAction)
        view.addSubview(ncButton)
        view.addSubview(vcButton)
        view.backgroundColor = .systemBackground
        
        ncButton.translatesAutoresizingMaskIntoConstraints = false
        vcButton.translatesAutoresizingMaskIntoConstraints = false
        ncButton.backgroundColor = .systemRed
        vcButton.backgroundColor = .systemBlue
        ncButton.layer.cornerRadius = 15
        vcButton.layer.cornerRadius = 15
        ncButton.clipsToBounds = true
        vcButton.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            ncButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ncButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ncButton.heightAnchor.constraint(equalToConstant: 50),
            ncButton.widthAnchor.constraint(equalToConstant: 200),
            
            vcButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            vcButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vcButton.heightAnchor.constraint(equalToConstant: 50),
            vcButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    func presentViewController(action: UIAction) {
        let vc = CollectionViewBugVC()
        self.present(vc, animated: true)
    }
    
    func pushViewController(action: UIAction) {
        let vc = CollectionViewBugVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    


}

