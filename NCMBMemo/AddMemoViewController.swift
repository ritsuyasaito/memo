//
//  AddMemoViewController.swift
//  NCMBMemo
//
//  Created by 齋藤律哉 on 2019/03/04.
//  Copyright © 2019 ritsuya. All rights reserved.
//

import UIKit
import NCMB

class AddMemoViewController: UIViewController {
    
    @IBOutlet var memoTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        //テキスト追加画面にきたとき、すぐに文字打つところが点滅するように。
        memoTextView.becomeFirstResponder()
    }
    
    
    
    
    
    @IBAction func save() {
        //メモクラスに対してオブジェクトを作る
        let object = NCMBObject(className: "Memo")
        //書かれた文字をセットする。保存するカラム（列）の名前をmemoとする。（プロパティ）
        object?.setObject(memoTextView.text, forKey: "memo")
        object?.saveInBackground({ (error) in
            if error != nil {
                print(error)
            } else {
                    let alertController = UIAlertController(title: "保存完了！", message: "メモの保存が完了しました。メモ一覧のに戻ります。", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    //成功したら前の画面に戻るよ
                    self.navigationController?.popViewController(animated: true)
                    })
                
                //以下の文がないとalertが表示されない。
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
