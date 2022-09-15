//
//  VerticalViewController.swift
//  Prj03
//
//  Created by PC115 on 2022/09/15.
//

import UIKit

class VerticalViewController: UIViewController {

    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: verticalStackView.frame.width, height: verticalStackView.frame.height)
        
        configureStackView()
    }
    
    private func configureStackView() {
        for _ in 0..<10 {
            let dummyView = randomColoredView()
            verticalStackView.addArrangedSubview(dummyView)
        }
    }
    
    // ランダム色, 100~400 heightを持ったView func生成
    private func randomColoredView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(
            displayP3Red: 1.0,
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: .random(in: 0...1))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: .random(in: 100...400)).isActive = true
        return view
    }
}
