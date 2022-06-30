//
//  MovieViewController.swift
//  movies-app
//
//  Created by training on 29-06-22.
//

import UIKit

class MovieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapPopularMovie(_ sender: Any) {
        let api: TheMovieAPIRest = TheMovieAPIRest()
        api.popularMovie(page: 1, complete: didGetPopularMovie)
    }
    
    
    func didGetPopularMovie(_ status: APIStatusType, _ response : PopularMovieResponse?) {
        print("Callback didGetPopularMovie")
        print("code    : \(status)")
        
        if status == .success {
           print("ok")
        } else {
            print("no-ok")
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
