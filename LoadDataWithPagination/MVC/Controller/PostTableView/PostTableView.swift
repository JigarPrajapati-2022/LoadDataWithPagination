//
//  PostTableView.swift
//  LoadDataWithPagination
//
//  Created by JB on 5/9/24.
//

import Foundation
import UIKit

extension PostTableViewController {
    
    //MARK: setup tableview delegate data source and header footer
    func setupTableView() {
      
        headerLoadingIndicator.hidesWhenStopped = true
        tblView.tableHeaderView = headerLoadingIndicator
        
        footerLoadingIndicator.hidesWhenStopped = true
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tblView.frame.width, height: 44))
        footerView.addSubview(footerLoadingIndicator)
        footerLoadingIndicator.center = footerView.center
        tblView.tableFooterView = UIView() // Initially, hide footer
    }
    
    //MARK: load initial data
    func loadInitialData() {
        headerLoadingIndicator.startAnimating()
        
        APIManager.shared.fetchPosts { newPosts in
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                self?.headerLoadingIndicator.stopAnimating()
                self?.tblView.register(PostTblCell.self, reuseIdentifier: "PostTblCell")
//                self?.tblView.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell")

                self?.tblView.delegate = self
                self?.tblView.dataSource = self
                guard let newPosts = newPosts else { return }
                if newPosts.isEmpty {
                    self?.hasMoreData = false
                } else {
                    DispatchQueue.main.async {
                        self?.posts.append(contentsOf: newPosts)
                        self?.tblView.reloadData()
                        self?.tblView.tableHeaderView = nil // Hide header after loading
                    }
                }
            }
            
        }
    }
    
    //MARK: load data after scrolll
    func loadMoreData() {
        guard !isLoading, hasMoreData else { return }
        
        isLoading = true
        footerLoadingIndicator.startAnimating()
        tblView.tableFooterView = footerLoadingIndicator.superview // Show footer
        
        APIManager.shared.fetchPosts { newPosts in
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                self?.footerLoadingIndicator.stopAnimating()
                self?.tblView.tableFooterView = UIView() // Hide footer when done
                
                guard let newPosts = newPosts else { return }
                
                if newPosts.isEmpty {
                    self?.hasMoreData = false
                } else {
                    DispatchQueue.main.async {
                        self?.posts.append(contentsOf: newPosts)
                        self?.tblView.reloadData()
                    }
                }
            }
           
        }
    }
}

//MARK: tableview deledate and datasource method
extension PostTableViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count

    }
   
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
         let cell:PostTblCell = tableView.dequeueReusableCell(for: PostTblCell.self, for: indexPath)

         cell.setupData(data: posts[indexPath.row])
        // Load more data when the user scrolls to the bottom
        if indexPath.row == posts.count - 1 {
            loadMoreData()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailViewController") as? PostDetailViewController
        detailViewController?.post = posts[indexPath.row]
        self.navigationController?.pushViewController(detailViewController!, animated: true)

    }
}
