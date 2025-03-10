//
//  FeedViewController.swift
//  Prototype
//
//  Created by Work on 10.03.2025.
//

import UIKit

final class FeedViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "FeedImageCell")!
    }
}
