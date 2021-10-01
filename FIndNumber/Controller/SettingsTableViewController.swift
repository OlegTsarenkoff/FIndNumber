//
//  SettingsTableViewController.swift
//  FIndNumber
//
//  Created by Oleg Tsarenkoff on 1.10.21.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var switchTimer: UISwitch!
    @IBOutlet weak var timeGame: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC":
            if let vc = segue.destination as? SelectTimeViewController {
                vc.data = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]
            }
        default:
            break
        }
    }
    
    func loadSettings() {
        timeGame.text = "\(Settings.shared.currentSettings.timeForGame) сек."
        switchTimer.isOn = Settings.shared.currentSettings.timeState
    }
    
    @IBAction func changeTimerState(_ sender: UISwitch) {
        Settings.shared.currentSettings.timeState = sender.isOn
    }
    
    @IBAction func resetSettings(_ sender: UIButton) {
        Settings.shared.resetSettings()
        loadSettings()
    }
}
