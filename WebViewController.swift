//
//  WebViewController.swift
//  QiitaViewer
//
//  Created by Hitomi Mikuni on 2017/03/20.
//  Copyright © 2017年 Hitomi Mikuni. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    //MARK: Variables
    var listUrl: String?
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // WebViewのurlを読み込ませてwebページを表示させる
        guard let listUrl = listUrl else {
            return
        }
        
        guard let url = URL(string: listUrl) else {
            return
        }
        
        // URLの内容をwebViewに表示
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
