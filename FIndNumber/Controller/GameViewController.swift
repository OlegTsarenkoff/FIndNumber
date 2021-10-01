//
//  GameViewController.swift
//  FIndNumber
//
//  Created by Oleg Tsarenkoff on 27.09.21.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    lazy var game = Game(countItems: buttons.count) { [weak self] (status, time) in
        guard let self = self else { return }
        self.timerLabel.text = time.secondToString()
        self.updateInfoGame(with: status)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        newGameButton.layer.cornerRadius = 15
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        game.check(index: buttonIndex)
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    // MARK: - Function
    
    private func setupScreen() {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI() {
        for index in game.items.indices{
            buttons[index].alpha = game.items[index].isFound ? 0.2 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .systemRed
                    self?.buttons[index].tintColor = .black
                } completion: { [weak self] (_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.buttons[index].tintColor = .systemTeal
                    self?.game.items[index].isError = false
                }
            }
        }
        nextDigit.text = game.nextItem?.title
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status: StatusGame) {
        switch status {
        case .start:
            newGameButton.isHidden = true
            timerLabel.isHidden = false
        case .win:
            nextDigit.text = "Вы выиграли!"
            nextDigit.textColor = .systemGreen
            newGameButton.isHidden = false
            timerLabel.isHidden = true
            if game.isNewRecord {
                showAlert()
            } else {
                showAlertActionSheet()
            }
        case .lose:
            nextDigit.text = "Вы проиграли..."
            nextDigit.textColor = .systemRed
            newGameButton.isHidden = false
            timerLabel.isHidden = true
            showAlertActionSheet()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Поздравляем!", message: "Вы установили новый рекорд :)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertActionSheet() {
        let alert = UIAlertController(title: "Что дальше?", message: nil, preferredStyle: .actionSheet)
        
        let newGameAction = UIAlertAction(title: "Начать заново", style: .default) { [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        
        let showRecord = UIAlertAction(title: "Рекорд", style: .default) { [weak self] (_) in
            self?.performSegue(withIdentifier: "recordVC", sender: nil)
        }
         
        let menuAction = UIAlertAction(title: "В меню", style: .destructive) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(newGameAction)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

