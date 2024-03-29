//
//  RecordViewController.swift
//  FIndNumber
//
//  Created by Oleg Tsarenkoff on 1.10.21.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var recordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
        if record != 0 {
            recordLabel.text = "Ваш рекорд - \(record) секунд."
        } else {
            recordLabel.text = "Рекорд не установлен."
        }
    }
}
