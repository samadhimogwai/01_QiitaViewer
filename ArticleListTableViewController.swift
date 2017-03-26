//
//  ArticleListTableViewController.swift
//  QiitaViewer
//
//  Created by Hitomi Mikuni on 2017/03/20.
//  Copyright © 2017年 Hitomi Mikuni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class ArticleListTableViewController: UITableViewController {

    // MARK:Variables
    var articles: [[String: String?]] = []
    var imageCache = NSCache<AnyObject, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // タイトルを設定
        title = "記事一覧"
        
        // 記事を取得
        getArticles()
        
    }
    
    // 記事の情報を取得
    func getArticles() {
        
        // qiita.comより記事一覧を取得
        Alamofire.request("https://qiita.com/api/v2/items")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                
                //　各情報を取得
                let json = JSON(object)
                json.forEach { (_, json) in
                    let article: [String: String?] = [
                        "title": json["title"].string,
                        "url": json["url"].string,
                        "image":json["user"]["profile_image_url"].string,
                        "userId": json["user"]["id"].string]
                    self.articles.append(article)
                }
                
                self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            guard let cell: CustomTableViewCell = CustomTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")  else {
                return UITableViewCell()
            }

            let article = articles[indexPath.row]
            
            // テキストに記事のタイトルとユーザIDを表示
            cell.textLabel?.text = article["title"]!
            cell.detailTextLabel?.text = article["userId"]!
            
            cell.listUrl = article["url"]!
            let imageUrl = article["image"]!

            // キャッシュの画像を取り出す
            if let cacheImage = imageCache.object(forKey: imageUrl as AnyObject) {
                // キャッシュ画像の設定
                cell.imageView?.image = cacheImage
                return cell
            }
        
            // キャッシュの画像がないためダウンロードする
            guard let url = URL(string: imageUrl!) else {
                //urlが生成されなかった
                return cell
            }
            
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                guard error == nil else {
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    return
                }
                
                cell.imageView?.layer.cornerRadius = 20
                cell.imageView?.clipsToBounds = true
                cell.imageView?.contentMode = .scaleAspectFit
                
                
                // ダウンロードした画像をキャッシュに登録しておく
                self.imageCache.setObject(image, forKey: imageUrl as AnyObject)
                
                // 画像はメインスレッドにて設定
                DispatchQueue.main.async {
                   cell.imageView?.sd_setImage(with: url as URL?)
                    
                }
                
            }
            
            // 画像の読み込み処理開始
            task.resume()

            return cell
        }
    
    // cellが選択された場合
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        // 遷移するために Segue を呼び出す
        performSegue(withIdentifier: "showWebPage",sender: nil)
    }

  
    // WEB表示画面に遷移
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showWebPage" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                 print(self.articles)
                let article = articles[indexPath.row]
                let url = article["url"]!
                (segue.destination as! WebViewController).listUrl = url
            }
        
            
        }
    }

        
}
