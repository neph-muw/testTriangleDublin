//
//  ViewController.swift
//  TestTriangle
//
//  Created by Roman Mykitchak on 15/10/2018.
//  Copyright © 2018 Roman Mykitchak. All rights reserved.
//

import UIKit

//https://www.raywenderlich.com/567-urlsession-tutorial-getting-started
class ViewController: UIViewController {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var weatherDays:Array = [WeatherDay]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getWeather()
    }
    
    func getWeather() {
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://samples.openweathermap.org/data/2.5/forecast?") {
            urlComponents.query = "Dublin,IE&appid=b6907d289e10d714a6e88b30761fae22"
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    debugPrint(error)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with:
                            data, options: [])
                        guard let jsonArray = jsonResponse as? [String: Any] else {
                            debugPrint("Error: jsonArray can not convert to string:any")
                            return
                        }
                        guard let list = jsonArray["list"] else {
                            debugPrint("Error: jsonArray list can not convert to string:any")
                            return
                        }
                        debugPrint(list)
                        guard let w1 = ((list as? Array<Dictionary<String,Any>>)!.first?["weather"]) as? [String:Any] else {
                            debugPrint("Error: jsonArray weather can not convert to string:any")
                            return
                        }
                        guard let w2 = w1["description"] as? String else {
                            debugPrint("Error: jsonArray list can not convert to string:any")
                            return
                        }
                        debugPrint(w2)
                        
                        
                        let decoder = JSONDecoder()
                        let bigData = try decoder.decode(Weather.self, from: data)
                        print(bigData)
                        debugPrint((bigData.list.first as! WeatherDay).weather.description)
                        
                    } catch let err {
                        print("Error: ", err)
                    }
                    
                    
                    DispatchQueue.main.async {
                        
                    }
                } else {
                    debugPrint("No data")
                }
            }
            
            dataTask?.resume()
        }
    }


}

