//
//  GameViewController.swift
//  FIndNumber
//
//  Created by Oleg Tsarenkoff on 27.09.21.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var nextDigit: UILabel!
    
    lazy var game = Game(countItems: buttons.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }

    @IBAction func pressedButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        game.check(index: buttonIndex)
        updateUI()
    }
    
    private func setupScreen() {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].isHidden = false
        }
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI() {
        for index in game.items.indices{
            buttons[index].isHidden = game.items[index].isFound
        }
        nextDigit.text = game.nextItem?.title
        if game.status == .win {
            statusLabel.text = "Вы выиграли!"
            statusLabel.textColor = .orange
        }
    }
}

