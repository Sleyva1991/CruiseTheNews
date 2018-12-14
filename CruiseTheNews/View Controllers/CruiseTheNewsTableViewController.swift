//
//  CruiseTheNewsTableViewController.swift
//  CruiseTheNews
//
//  Created by Johnny Hicks on 12/13/18.
//  Copyright © 2018 Johnny Hicks. All rights reserved.
//

import UIKit

class CruiseTheNewsTableViewController: UITableViewController {
    
    var newsArticles: [NewsArticle] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NewsArticleController.shared.fetchArticles { (articles) in
            if let articles = articles {
                self.newsArticles = articles
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsArticles.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)

        let article = self.newsArticles[indexPath.row]
        
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.author

        return cell
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let detailVC = segue.destination as? CruiseTheNewsDetailViewController,
                let indexPath = self.tableView.indexPathForSelectedRow {
                    detailVC.newsArticle = self.newsArticles[indexPath.row]
            }
        }
    }
}
