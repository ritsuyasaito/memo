//
//  DetailViewController.swift
//  NCMBMemo
//
//  Created by 齋藤律哉 on 2019/03/04.
//  Copyright © 2019 ritsuya. All rights reserved.
//

import UIKit
import NCMB
import SVProgressHUD

class DetailViewController: UIViewController {
    
    var selectedMemo: NCMBObject!
    
    
    @IBOutlet var memoTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        memoTextView.text = selectedMemo.object(forKey: "memo") as! String
        
        
    }
    

    @IBAction func updata() {
        selectedMemo.setObject(memoTextView.text, forKey: "memo")
        selectedMemo.saveInBackground { (error) in
            if error != nil {
                
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
                
            } else {
                //成功,前の画面に戻る
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func delete() {
        selectedMemo.deleteInBackground { (error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            } else {
                //削除成功
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}
