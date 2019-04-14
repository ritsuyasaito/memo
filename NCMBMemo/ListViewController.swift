//
//  ListViewController.swift
//  NCMBMemo
//
//  Created by 齋藤律哉 on 2019/03/04.
//  Copyright © 2019 ritsuya. All rights reserved.
//

import UIKit
import NCMB

class ListViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    
    //NCMBObjectの空の配列を作る
    var memoArray = [NCMBObject]()
    
    @IBOutlet var memoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTableView.dataSource = self
        memoTableView.delegate = self
        
       

        // Do any additional setup after loading the view.
        
        memoTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
//行の数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //メモの数だけセルをかえす
        return memoArray.count
    }
    
    
    
    //セルの内容を決める
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = memoArray[indexPath.row].object(forKey: "memo") as? String
        return cell!
    }
    
    
    //tableViewのセルが押されたときに、どのセルが押されたのか判別する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //indexPath.rowとすると、座標の右が表示され、indexPath.sectionにすると座標の左が表示される
        //ほんとは別にいらないけど
        print(indexPath.row)
        
        
        //遷移のコード
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        //セルをタップしたときの灰色が継続しないように
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面の取得(Detail)
        if segue.identifier == "toDetail"{
            let detailViewController = segue.destination as! DetailViewController
            
            
            let selectedIndex = memoTableView.indexPathForSelectedRow!
            
            
            
            detailViewController.selectedMemo = memoArray[selectedIndex.row]
        }
    }
    
    
    
    
    func loadData(){
    //データを読み込む
    let query = NCMBQuery(className: "Memo")
    query?.findObjectsInBackground({ (result, error) in
    if error != nil {
    print(error)
    } else {
    //memoArrayの配列は[NCMBObject]()だから、resultの型を変える
    self.memoArray = result as![NCMBObject]
    self.memoTableView.reloadData()
    }
    })
    }
    
}
