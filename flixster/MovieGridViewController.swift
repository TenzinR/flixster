//
//  MovieGridViewController.swift
//  flixster
//
//  Created by Tenzin Rigchok on 9/19/21.
//

import UIKit
import AlamofireImage
class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func trailerTap(_ sender: Any) {
    }
    var movies = [[String:Any]]()
    
    /*@objc func didTap(sender: UITapGestureRecognizer) {
       let location = sender.location(in: view)
    }
 */
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The didTap: method will be defined in Step 3 below.
        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))

        // Optionally set the number of required taps, e.g., 2 for a double click
        //tapGestureRecognizer.numberOfTapsRequired = 1

        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        //yourView.isUserInteractionEnabled = true
        //yourView.addGestureRecognizer(tapGestureRecognizer)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumLineSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
                    
                self.movies = dataDictionary["results"] as! [[String:Any]]
                self.collectionView.reloadData()
                print(self.movies)
             }
        }
        task.resume()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        let movie = movies[indexPath.item]
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        cell.posterView.af.setImage(withURL: posterURL!)
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("Loading up the details screen")
        //var Trailer = segue.destination as! TrailerViewController
        //Trailer.webView = self.
        //Find the selected movie
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        let detailsViewController = segue.destination as! CollectionViewDetailsViewController
        detailsViewController.movie = movie
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    

}
