//
//  ArticleTableViewController.swift
//  NewsCoreML
//
//  Created by Todor Dimitrov on 20.10.21.
//

import UIKit
import Kingfisher

class ArticleTableViewController: UITableViewController {

    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getArticles()
    }
    
    func getArticles() {
        NewsHelper().getArticles { articles in
            self.articles = articles
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleCell {
            
            let article = articles[indexPath.row]
            
            cell.titleLabel.text = article.title
            cell.categoryLabel.text = article.category.rawValue
            cell.categoryLabel.backgroundColor = article.categoryColor
            let url = URL(string: article.urlToImage)
            cell.articleImageView.kf.setImage(with: url, placeholder: UIImage(named: "Filler"))
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 260 }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        performSegue(withIdentifier: "goToURL", sender: article)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToURL",
            let article = sender as? Article,
            let webVC = segue.destination as? ArticleWebViewController {
                webVC.article = article
        }
    }
    
    @IBAction func reloadTapped(_ sender: Any) {
        getArticles()
    }
    
}

class ArticleCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
}


