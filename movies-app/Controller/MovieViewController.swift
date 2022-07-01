//
//  MovieViewController.swift
//  movies-app
//
//  Created by training on 29-06-22.
//

import UIKit

class MovieViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                           UIScrollViewDelegate  {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        let api: TheMovieAPIRest = TheMovieAPIRest()
        activityIndicator.startAnimating()
        api.popularMovie(page: 1, complete: didGetPopularMovie)
        
        movieList.append(Movie(name: "María Irola", image: "staff_mariairola", favorite: false))
        movieList.append(Movie(name: "Marita Gomez", image: "staff_maritagomez", favorite: false))
        movieList.append(Movie(name: "Miriam Rodriguez", image: "staff_miriamrodriguez", favorite: false))
        movieList.append(Movie(name: "Cecilia Mendez", image: "staff_ceciliamendez", favorite: false))
        movieList.append(Movie(name: "Mario Fuentes", image: "staff_mariofuentes", favorite: false))
        movieList.append(Movie(name: "Rodrigo Fuente", image: "staff_rodrigofuente", favorite: false))
        movieList.append(Movie(name: "Maria Garcia", image: "staff_mariagarcia", favorite: false))
        movieList.append(Movie(name: "Marco Fernandez", image: "staff_marcofernandez", favorite: false))
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.nameMovieLabel.text = movieList[indexPath.row].name
//        if let imagePhoto = UIImage(named: movieList[indexPath.row].image) {
//            cell.photoMovieImageView.image = imagePhoto
//        }
        
        if let urlImage = URL(string: "https://image.tmdb.org/t/p/w500/wcKFYIiVDvRURrzglV9kGu7fpfY.jpg") {
            cell.photoMovieImageView.load(url: urlImage)
        }
        
        return cell
    }
    
    @IBAction func onTapPopularMovie(_ sender: Any) {
        let api: TheMovieAPIRest = TheMovieAPIRest()
        activityIndicator.startAnimating()
        api.popularMovie(page: 1, complete: didGetPopularMovie)
    }
    
    
    func didGetPopularMovie(_ status: APIStatusType, _ response : PopularMovieResponse?) {
        print("Callback didGetPopularMovie")
        print("code    : \(status)")
        
        activityIndicator.stopAnimating()
        if status == .success {
            successfulAlertMessage("Carga OK de Películas Populares")
        } else {
            errorAlertMessage("No fue posible obtener las películas populares")
        }
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
