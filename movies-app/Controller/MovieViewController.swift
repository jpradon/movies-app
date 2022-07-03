//
//  MovieViewController.swift
//  movies-app
//
//  Created by training on 29-06-22.
//

import UIKit

class MovieViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                           UIScrollViewDelegate {

    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieCollectionView: UICollectionView!

    // MARK: Properties
    var movieList: [Movie] = []
    var genresList: [Genres] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }

    func setup() {
        let api: TheMovieAPIRest = TheMovieAPIRest()
        activityIndicator.startAnimating()
        api.listMovie(complete: didGetGenresMovie)
        api.popularMovie(page: 1, complete: didGetPopularMovie)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }

    func didGetPopularMovie(_ status: APIStatusType, _ response : PopularMovieResponse?) {
        print("Callback didGetPopularMovie")
        print("code    : \(status)")

        activityIndicator.stopAnimating()
        if status == .success {
            successfulAlertMessage("Carga OK de Películas Populares")

            response?.results.forEach { movieData in
                movieList.append(Movie(name: movieData.title, image: "https://image.tmdb.org/t/p/w500/\(movieData.posterPath)", favorite: false, releaseDate: movieData.releaseDate, synopsis: movieData.overview, genreIDS: movieData.genreIDS))
            }
            movieCollectionView.reloadData()
            print("Cantidad de películas: \(movieList.count)")
            print("Películas: \(movieList)")
        } else {
            errorAlertMessage("No fue posible obtener las películas populares")
        }
    }

    func didGetGenresMovie(_ status: APIStatusType, _ response : ListMovieResponse?) {
        print("Callback didGetGenresMovie")
        print("code    : \(status)")
    
        activityIndicator.stopAnimating()
        if status == .success {
            successfulAlertMessage("Carga OK de List Películas")
            response?.genres.forEach { genresData in
                genresList.append(Genres(id: genresData.id, name: genresData.name))
            }
            print("Cantidad de géneros de películas: \(genresList.count)")
        } else {
            errorAlertMessage("No fue posible obtener el list de películas")
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        cell.nameMovieLabel.text = movieList[indexPath.row].name
        if let urlImage = URL(string: movieList[indexPath.row].image) {
            cell.photoMovieImageView.load(url: urlImage)
        }
        return cell
    }

    @IBAction func onTapPopularMovie(_ sender: Any) {
        let api: TheMovieAPIRest = TheMovieAPIRest()
        activityIndicator.startAnimating()
        api.popularMovie(page: 1, complete: didGetPopularMovie)
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
