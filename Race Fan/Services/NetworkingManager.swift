//
//  Networking.swift
//  Race Fan
//
//  Created by Neal Siegrist on 1/13/23.
//

import Foundation

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

class NetworkingManager {
    
    static func generateUrlRequest(url: URL, httpMethod: HttpMethodType = .GET) -> URLRequest? {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod.rawValue
        
        return request
    }

    static func loadData<T: Decodable>(request: URLRequest, type: T.Type, completion: @escaping (Result<T, NetworkingError>) -> Void) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if  request.url!.absoluteString.contains("driver") {
                let decoder = JSONDecoder()
                let context = CoreDataStack.shared.mainContext
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context

                do {
                    let result: Result<T, NetworkingError> = try .success(decoder.decode(T.self, from: driverStandingsResponse.data(using: .utf8)!))

                    completion(result)
                } catch {
                    completion(.failure(.parsingError))
                }
            } else if request.url!.absoluteString.contains("constructor") {
                let decoder = JSONDecoder()
                let context = CoreDataStack.shared.mainContext
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context

                do {
                    let result: Result<T, NetworkingError> = try .success(decoder.decode(T.self, from: constructorStandingsResponse.data(using: .utf8)!))

                    completion(result)
                } catch {
                    completion(.failure(.parsingError))
                }
            } else {
                let decoder = JSONDecoder()
                let context = CoreDataStack.shared.mainContext
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context

                do {
                    let result: Result<T, NetworkingError> = try .success(decoder.decode(T.self, from: scheduleJsonResponse.data(using: .utf8)!))

                    completion(result)
                } catch {
                    completion(.failure(.parsingError))
                }
            }

            print(request.url?.absoluteURL)
        }
        
        
//        ------
//        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
//
//            if let receivedError = error {
//                completion(.failure(.responseError(receivedError)))
//            }
//
//            guard let validData = data else {
//                completion(.failure(.noData))
//                return
//            }
//
//            let decoder = JSONDecoder()
//
//            //set context in decoder
//            let context = CoreDataStack.shared.mainContext
//            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
//
//            do {
//                let result: Result<T, NetworkingError> = try .success(decoder.decode(T.self, from: validData))
//
//                completion(result)
//            } catch {
//                completion(.failure(.parsingError))
//            }
//        }
//
//        dataTask.resume()
    }
    
    public static let constructorStandingsResponse = """
{
    "MRData": {
        "xmlns": "http://ergast.com/mrd/1.5",
        "series": "f1",
        "url": "http://ergast.com/api/f1/2023/constructorstandings.json",
        "limit": "30",
        "offset": "0",
        "total": "10",
        "StandingsTable": {
            "season": "2023",
            "StandingsLists": [
                {
                    "season": "2023",
                    "round": "1",
                    "ConstructorStandings": [
                        {
                            "position": "1",
                            "positionText": "1",
                            "points": "0",
                            "wins": "0",
                            "Constructor": {
                                "constructorId": "alfa",
                                "url": "http://en.wikipedia.org/wiki/Alfa_Romeo_in_Formula_One",
                                "name": "Alfa Romeo",
                                "nationality": "Swiss"
                            }
                        },
                        {
                            "position": "2",
                            "positionText": "2",
                            "points": "0",
                            "wins": "0",
                            "Constructor": {
                                "constructorId": "alphatauri",
                                "url": "http://en.wikipedia.org/wiki/Scuderia_AlphaTauri",
                                "name": "AlphaTauri",
                                "nationality": "Italian"
                            }
                        },
                        {
                            "position": "3",
                            "positionText": "3",
                            "points": "0",
                            "wins": "0",
                            "Constructor": {
                                "constructorId": "alpine",
                                "url": "http://en.wikipedia.org/wiki/Alpine_F1_Team",
                                "name": "Alpine F1 Team",
                                "nationality": "French"
                            }
                        },
                        {
                            "position": "4",
                            "positionText": "4",
                            "points": "0",
                            "wins": "0",
                            "Constructor": {
                                "constructorId": "aston_martin",
                                "url": "http://en.wikipedia.org/wiki/Aston_Martin_in_Formula_One",
                                "name": "Aston Martin",
                                "nationality": "British"
                            }
                        },
                        {
                            "position": "5",
                            "positionText": "5",
                            "points": "0",
                            "wins": "0",
                            "Constructor": {
                                "constructorId": "ferrari",
                                "url": "http://en.wikipedia.org/wiki/Scuderia_Ferrari",
                                "name": "Ferrari",
                                "nationality": "Italian"
                            }
                        },
                        {
                            "position": "6",
                            "positionText": "6",
                            "points": "0",
                            "wins": "0",
                            "Constructor": {
                                "constructorId": "haas",
                                "url": "http://en.wikipedia.org/wiki/Haas_F1_Team",
                                "name": "Haas F1 Team",
                                "nationality": "American"
                            }
                        },
                        {
                            "position": "7",
                            "positionText": "7",
                            "points": "0",
                            "wins": "0",
                            "Constructor": {
                                "constructorId": "mclaren",
                                "url": "http://en.wikipedia.org/wiki/McLaren",
                                "name": "McLaren",
                                "nationality": "British"
                            }
                        },
                        {
                            "position": "8",
                            "positionText": "8",
                            "points": "0",
                            "wins": "0",
                            "Constructor": {
                                "constructorId": "mercedes",
                                "url": "http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One",
                                "name": "Mercedes",
                                "nationality": "German"
                            }
                        },
                        {
                            "position": "9",
                            "positionText": "9",
                            "points": "0",
                            "wins": "0",
                            "Constructor": {
                                "constructorId": "red_bull",
                                "url": "http://en.wikipedia.org/wiki/Red_Bull_Racing",
                                "name": "Red Bull",
                                "nationality": "Austrian"
                            }
                        },
                        {
                            "position": "10",
                            "positionText": "10",
                            "points": "0",
                            "wins": "0",
                            "Constructor": {
                                "constructorId": "williams",
                                "url": "http://en.wikipedia.org/wiki/Williams_Grand_Prix_Engineering",
                                "name": "Williams",
                                "nationality": "British"
                            }
                        }
                    ]
                }
            ]
        }
    }
}
"""
    
    public static let driverStandingsResponse = """
    {
        "MRData": {
            "xmlns": "http://ergast.com/mrd/1.5",
            "series": "f1",
            "url": "http://ergast.com/api/f1/2023/driverstandings.json",
            "limit": "30",
            "offset": "0",
            "total": "20",
            "StandingsTable": {
                "season": "2023",
                "StandingsLists": [
                    {
                        "season": "2023",
                        "round": "1",
                        "DriverStandings": [
                            {
                                "position": "1",
                                "positionText": "1",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "albon",
                                    "permanentNumber": "23",
                                    "code": "ALB",
                                    "url": "http://en.wikipedia.org/wiki/Alexander_Albon",
                                    "givenName": "Alexander",
                                    "familyName": "Albon",
                                    "dateOfBirth": "1996-03-23",
                                    "nationality": "Thai"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "2",
                                "positionText": "2",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "alonso",
                                    "permanentNumber": "14",
                                    "code": "ALO",
                                    "url": "http://en.wikipedia.org/wiki/Fernando_Alonso",
                                    "givenName": "Fernando",
                                    "familyName": "Alonso",
                                    "dateOfBirth": "1981-07-29",
                                    "nationality": "Spanish"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "3",
                                "positionText": "3",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "bottas",
                                    "permanentNumber": "77",
                                    "code": "BOT",
                                    "url": "http://en.wikipedia.org/wiki/Valtteri_Bottas",
                                    "givenName": "Valtteri",
                                    "familyName": "Bottas",
                                    "dateOfBirth": "1989-08-28",
                                    "nationality": "Finnish"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "4",
                                "positionText": "4",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "gasly",
                                    "permanentNumber": "10",
                                    "code": "GAS",
                                    "url": "http://en.wikipedia.org/wiki/Pierre_Gasly",
                                    "givenName": "Pierre",
                                    "familyName": "Gasly",
                                    "dateOfBirth": "1996-02-07",
                                    "nationality": "French"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "5",
                                "positionText": "5",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "hamilton",
                                    "permanentNumber": "44",
                                    "code": "HAM",
                                    "url": "http://en.wikipedia.org/wiki/Lewis_Hamilton",
                                    "givenName": "Lewis",
                                    "familyName": "Hamilton",
                                    "dateOfBirth": "1985-01-07",
                                    "nationality": "British"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "6",
                                "positionText": "6",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "hulkenberg",
                                    "permanentNumber": "27",
                                    "code": "HUL",
                                    "url": "http://en.wikipedia.org/wiki/Nico_H%C3%BClkenberg",
                                    "givenName": "Nico",
                                    "familyName": "Hülkenberg",
                                    "dateOfBirth": "1987-08-19",
                                    "nationality": "German"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "7",
                                "positionText": "7",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "leclerc",
                                    "permanentNumber": "16",
                                    "code": "LEC",
                                    "url": "http://en.wikipedia.org/wiki/Charles_Leclerc",
                                    "givenName": "Charles",
                                    "familyName": "Leclerc",
                                    "dateOfBirth": "1997-10-16",
                                    "nationality": "Monegasque"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "8",
                                "positionText": "8",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "kevin_magnussen",
                                    "permanentNumber": "20",
                                    "code": "MAG",
                                    "url": "http://en.wikipedia.org/wiki/Kevin_Magnussen",
                                    "givenName": "Kevin",
                                    "familyName": "Magnussen",
                                    "dateOfBirth": "1992-10-05",
                                    "nationality": "Danish"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "9",
                                "positionText": "9",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "norris",
                                    "permanentNumber": "4",
                                    "code": "NOR",
                                    "url": "http://en.wikipedia.org/wiki/Lando_Norris",
                                    "givenName": "Lando",
                                    "familyName": "Norris",
                                    "dateOfBirth": "1999-11-13",
                                    "nationality": "British"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "10",
                                "positionText": "10",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "ocon",
                                    "permanentNumber": "31",
                                    "code": "OCO",
                                    "url": "http://en.wikipedia.org/wiki/Esteban_Ocon",
                                    "givenName": "Esteban",
                                    "familyName": "Ocon",
                                    "dateOfBirth": "1996-09-17",
                                    "nationality": "French"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "11",
                                "positionText": "11",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "perez",
                                    "permanentNumber": "11",
                                    "code": "PER",
                                    "url": "http://en.wikipedia.org/wiki/Sergio_P%C3%A9rez",
                                    "givenName": "Sergio",
                                    "familyName": "Pérez",
                                    "dateOfBirth": "1990-01-26",
                                    "nationality": "Mexican"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "12",
                                "positionText": "12",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "piastri",
                                    "permanentNumber": "81",
                                    "code": "PIA",
                                    "url": "http://en.wikipedia.org/wiki/Oscar_Piastri",
                                    "givenName": "Oscar",
                                    "familyName": "Piastri",
                                    "dateOfBirth": "2001-04-06",
                                    "nationality": "Australian"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "13",
                                "positionText": "13",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "russell",
                                    "permanentNumber": "63",
                                    "code": "RUS",
                                    "url": "http://en.wikipedia.org/wiki/George_Russell_%28racing_driver%29",
                                    "givenName": "George",
                                    "familyName": "Russell",
                                    "dateOfBirth": "1998-02-15",
                                    "nationality": "British"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "14",
                                "positionText": "14",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "sainz",
                                    "permanentNumber": "55",
                                    "code": "SAI",
                                    "url": "http://en.wikipedia.org/wiki/Carlos_Sainz_Jr.",
                                    "givenName": "Carlos",
                                    "familyName": "Sainz",
                                    "dateOfBirth": "1994-09-01",
                                    "nationality": "Spanish"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "15",
                                "positionText": "15",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "sargeant",
                                    "permanentNumber": "2",
                                    "code": "SAR",
                                    "url": "http://en.wikipedia.org/wiki/Logan_Sargeant",
                                    "givenName": "Logan",
                                    "familyName": "Sargeant",
                                    "dateOfBirth": "2000-12-31",
                                    "nationality": "American"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "16",
                                "positionText": "16",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "stroll",
                                    "permanentNumber": "18",
                                    "code": "STR",
                                    "url": "http://en.wikipedia.org/wiki/Lance_Stroll",
                                    "givenName": "Lance",
                                    "familyName": "Stroll",
                                    "dateOfBirth": "1998-10-29",
                                    "nationality": "Canadian"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "17",
                                "positionText": "17",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "tsunoda",
                                    "permanentNumber": "22",
                                    "code": "TSU",
                                    "url": "http://en.wikipedia.org/wiki/Yuki_Tsunoda",
                                    "givenName": "Yuki",
                                    "familyName": "Tsunoda",
                                    "dateOfBirth": "2000-05-11",
                                    "nationality": "Japanese"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "18",
                                "positionText": "18",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "max_verstappen",
                                    "permanentNumber": "33",
                                    "code": "VER",
                                    "url": "http://en.wikipedia.org/wiki/Max_Verstappen",
                                    "givenName": "Max",
                                    "familyName": "Verstappen",
                                    "dateOfBirth": "1997-09-30",
                                    "nationality": "Dutch"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "19",
                                "positionText": "19",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "de_vries",
                                    "permanentNumber": "45",
                                    "code": "DEV",
                                    "url": "http://en.wikipedia.org/wiki/Nyck_de_Vries",
                                    "givenName": "Nyck",
                                    "familyName": "de Vries",
                                    "dateOfBirth": "1995-02-06",
                                    "nationality": "Dutch"
                                },
                                "Constructors": []
                            },
                            {
                                "position": "20",
                                "positionText": "20",
                                "points": "0",
                                "wins": "0",
                                "Driver": {
                                    "driverId": "zhou",
                                    "permanentNumber": "24",
                                    "code": "ZHO",
                                    "url": "http://en.wikipedia.org/wiki/Guanyu_Zhou",
                                    "givenName": "Guanyu",
                                    "familyName": "Zhou",
                                    "dateOfBirth": "1999-05-30",
                                    "nationality": "Chinese"
                                },
                                "Constructors": []
                            }
                        ]
                    }
                ]
            }
        }
    }
    """
    
    public static let scheduleJsonResponse = """
    {
        "MRData": {
            "xmlns": "http://ergast.com/mrd/1.5",
            "series": "f1",
            "url": "http://ergast.com/api/f1/2023.json",
            "limit": "30",
            "offset": "0",
            "total": "23",
            "RaceTable": {
                "season": "2023",
                "Races": [
                    {
                        "season": "2023",
                        "round": "1",
                        "url": "https://en.wikipedia.org/wiki/2023_Bahrain_Grand_Prix",
                        "raceName": "Bahrain Grand Prix",
                        "Circuit": {
                            "circuitId": "bahrain",
                            "url": "http://en.wikipedia.org/wiki/Bahrain_International_Circuit",
                            "circuitName": "Bahrain International Circuit",
                            "Location": {
                                "lat": "26.0325",
                                "long": "50.5106",
                                "locality": "Sakhir",
                                "country": "Bahrain"
                            }
                        },
                        "date": "2023-03-05",
                        "time": "15:00:00Z",
                        "FirstPractice": {
                            "date": "2023-03-03",
                            "time": "12:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-03-03",
                            "time": "15:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-03-04",
                            "time": "12:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-03-04",
                            "time": "15:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "2",
                        "url": "https://en.wikipedia.org/wiki/2023_Saudi_Arabian_Grand_Prix",
                        "raceName": "Saudi Arabian Grand Prix",
                        "Circuit": {
                            "circuitId": "jeddah",
                            "url": "http://en.wikipedia.org/wiki/Jeddah_Street_Circuit",
                            "circuitName": "Jeddah Corniche Circuit",
                            "Location": {
                                "lat": "21.6319",
                                "long": "39.1044",
                                "locality": "Jeddah",
                                "country": "Saudi Arabia"
                            }
                        },
                        "date": "2023-03-19",
                        "time": "17:00:00Z",
                        "FirstPractice": {
                            "date": "2023-03-17",
                            "time": "14:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-03-17",
                            "time": "17:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-03-18",
                            "time": "14:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-03-18",
                            "time": "17:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "3",
                        "url": "https://en.wikipedia.org/wiki/2023_Australian_Grand_Prix",
                        "raceName": "Australian Grand Prix",
                        "Circuit": {
                            "circuitId": "albert_park",
                            "url": "http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit",
                            "circuitName": "Albert Park Grand Prix Circuit",
                            "Location": {
                                "lat": "-37.8497",
                                "long": "144.968",
                                "locality": "Melbourne",
                                "country": "Australia"
                            }
                        },
                        "date": "2023-04-02",
                        "time": "05:00:00Z",
                        "FirstPractice": {
                            "date": "2023-03-31",
                            "time": "03:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-03-31",
                            "time": "06:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-04-01",
                            "time": "03:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-04-01",
                            "time": "06:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "4",
                        "url": "https://en.wikipedia.org/wiki/2023_Azerbaijan_Grand_Prix",
                        "raceName": "Azerbaijan Grand Prix",
                        "Circuit": {
                            "circuitId": "baku",
                            "url": "http://en.wikipedia.org/wiki/Baku_City_Circuit",
                            "circuitName": "Baku City Circuit",
                            "Location": {
                                "lat": "40.3725",
                                "long": "49.8533",
                                "locality": "Baku",
                                "country": "Azerbaijan"
                            }
                        },
                        "date": "2023-04-30",
                        "time": "11:00:00Z",
                        "FirstPractice": {
                            "date": "2023-04-28",
                            "time": "11:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-04-28",
                            "time": "14:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-04-29",
                            "time": "11:00:00Z"
                        },
                        "Sprint": {
                            "date": "2023-04-29",
                            "time": "14:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "5",
                        "url": "https://en.wikipedia.org/wiki/2023_Miami_Grand_Prix",
                        "raceName": "Miami Grand Prix",
                        "Circuit": {
                            "circuitId": "miami",
                            "url": "http://en.wikipedia.org/wiki/Miami_International_Autodrome",
                            "circuitName": "Miami International Autodrome",
                            "Location": {
                                "lat": "25.9581",
                                "long": "-80.2389",
                                "locality": "Miami",
                                "country": "USA"
                            }
                        },
                        "date": "2023-05-07",
                        "time": "19:30:00Z",
                        "FirstPractice": {
                            "date": "2023-05-05",
                            "time": "18:30:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-05-05",
                            "time": "21:30:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-05-06",
                            "time": "17:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-05-06",
                            "time": "21:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "6",
                        "url": "https://en.wikipedia.org/wiki/2023_Emilia_Romagna_Grand_Prix",
                        "raceName": "Emilia Romagna Grand Prix",
                        "Circuit": {
                            "circuitId": "imola",
                            "url": "http://en.wikipedia.org/wiki/Autodromo_Enzo_e_Dino_Ferrari",
                            "circuitName": "Autodromo Enzo e Dino Ferrari",
                            "Location": {
                                "lat": "44.3439",
                                "long": "11.7167",
                                "locality": "Imola",
                                "country": "Italy"
                            }
                        },
                        "date": "2023-05-21",
                        "time": "13:00:00Z",
                        "FirstPractice": {
                            "date": "2023-05-19",
                            "time": "11:30:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-05-19",
                            "time": "15:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-05-20",
                            "time": "10:30:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-05-20",
                            "time": "14:30:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "7",
                        "url": "https://en.wikipedia.org/wiki/2023_Monaco_Grand_Prix",
                        "raceName": "Monaco Grand Prix",
                        "Circuit": {
                            "circuitId": "monaco",
                            "url": "http://en.wikipedia.org/wiki/Circuit_de_Monaco",
                            "circuitName": "Circuit de Monaco",
                            "Location": {
                                "lat": "43.7347",
                                "long": "7.42056",
                                "locality": "Monte-Carlo",
                                "country": "Monaco"
                            }
                        },
                        "date": "2023-05-28",
                        "time": "13:00:00Z",
                        "FirstPractice": {
                            "date": "2023-05-26",
                            "time": "12:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-05-26",
                            "time": "15:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-05-27",
                            "time": "11:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-05-27",
                            "time": "14:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "8",
                        "url": "https://en.wikipedia.org/wiki/2023_Spanish_Grand_Prix",
                        "raceName": "Spanish Grand Prix",
                        "Circuit": {
                            "circuitId": "catalunya",
                            "url": "http://en.wikipedia.org/wiki/Circuit_de_Barcelona-Catalunya",
                            "circuitName": "Circuit de Barcelona-Catalunya",
                            "Location": {
                                "lat": "41.57",
                                "long": "2.26111",
                                "locality": "Montmeló",
                                "country": "Spain"
                            }
                        },
                        "date": "2023-06-04",
                        "time": "13:00:00Z",
                        "FirstPractice": {
                            "date": "2023-06-02",
                            "time": "12:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-06-02",
                            "time": "15:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-06-03",
                            "time": "11:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-06-03",
                            "time": "14:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "9",
                        "url": "https://en.wikipedia.org/wiki/2023_Canadian_Grand_Prix",
                        "raceName": "Canadian Grand Prix",
                        "Circuit": {
                            "circuitId": "villeneuve",
                            "url": "http://en.wikipedia.org/wiki/Circuit_Gilles_Villeneuve",
                            "circuitName": "Circuit Gilles Villeneuve",
                            "Location": {
                                "lat": "45.5",
                                "long": "-73.5228",
                                "locality": "Montreal",
                                "country": "Canada"
                            }
                        },
                        "date": "2023-06-18",
                        "time": "18:00:00Z",
                        "FirstPractice": {
                            "date": "2023-06-16",
                            "time": "18:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-06-16",
                            "time": "21:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-06-17",
                            "time": "17:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-06-17",
                            "time": "20:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "10",
                        "url": "https://en.wikipedia.org/wiki/2023_Austrian_Grand_Prix",
                        "raceName": "Austrian Grand Prix",
                        "Circuit": {
                            "circuitId": "red_bull_ring",
                            "url": "http://en.wikipedia.org/wiki/Red_Bull_Ring",
                            "circuitName": "Red Bull Ring",
                            "Location": {
                                "lat": "47.2197",
                                "long": "14.7647",
                                "locality": "Spielberg",
                                "country": "Austria"
                            }
                        },
                        "date": "2023-07-02",
                        "time": "13:00:00Z",
                        "FirstPractice": {
                            "date": "2023-06-30",
                            "time": "11:30:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-06-30",
                            "time": "15:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-07-01",
                            "time": "10:30:00Z"
                        },
                        "Sprint": {
                            "date": "2023-07-01",
                            "time": "14:30:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "11",
                        "url": "https://en.wikipedia.org/wiki/2023_British_Grand_Prix",
                        "raceName": "British Grand Prix",
                        "Circuit": {
                            "circuitId": "silverstone",
                            "url": "http://en.wikipedia.org/wiki/Silverstone_Circuit",
                            "circuitName": "Silverstone Circuit",
                            "Location": {
                                "lat": "52.0786",
                                "long": "-1.01694",
                                "locality": "Silverstone",
                                "country": "UK"
                            }
                        },
                        "date": "2023-07-09",
                        "time": "14:00:00Z",
                        "FirstPractice": {
                            "date": "2023-07-07",
                            "time": "12:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-07-07",
                            "time": "15:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-07-08",
                            "time": "11:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-07-08",
                            "time": "14:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "12",
                        "url": "https://en.wikipedia.org/wiki/2023_Hungarian_Grand_Prix",
                        "raceName": "Hungarian Grand Prix",
                        "Circuit": {
                            "circuitId": "hungaroring",
                            "url": "http://en.wikipedia.org/wiki/Hungaroring",
                            "circuitName": "Hungaroring",
                            "Location": {
                                "lat": "47.5789",
                                "long": "19.2486",
                                "locality": "Budapest",
                                "country": "Hungary"
                            }
                        },
                        "date": "2023-07-23",
                        "time": "13:00:00Z",
                        "FirstPractice": {
                            "date": "2023-07-21",
                            "time": "12:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-07-21",
                            "time": "15:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-07-22",
                            "time": "11:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-07-22",
                            "time": "14:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "13",
                        "url": "https://en.wikipedia.org/wiki/2023_Belgian_Grand_Prix",
                        "raceName": "Belgian Grand Prix",
                        "Circuit": {
                            "circuitId": "spa",
                            "url": "http://en.wikipedia.org/wiki/Circuit_de_Spa-Francorchamps",
                            "circuitName": "Circuit de Spa-Francorchamps",
                            "Location": {
                                "lat": "50.4372",
                                "long": "5.97139",
                                "locality": "Spa",
                                "country": "Belgium"
                            }
                        },
                        "date": "2023-07-30",
                        "time": "13:00:00Z",
                        "FirstPractice": {
                            "date": "2023-07-28",
                            "time": "12:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-07-28",
                            "time": "15:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-07-29",
                            "time": "11:00:00Z"
                        },
                        "Sprint": {
                            "date": "2023-07-29",
                            "time": "14:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "14",
                        "url": "https://en.wikipedia.org/wiki/2023_Dutch_Grand_Prix",
                        "raceName": "Dutch Grand Prix",
                        "Circuit": {
                            "circuitId": "zandvoort",
                            "url": "http://en.wikipedia.org/wiki/Circuit_Zandvoort",
                            "circuitName": "Circuit Park Zandvoort",
                            "Location": {
                                "lat": "52.3888",
                                "long": "4.54092",
                                "locality": "Zandvoort",
                                "country": "Netherlands"
                            }
                        },
                        "date": "2023-08-27",
                        "time": "13:00:00Z",
                        "FirstPractice": {
                            "date": "2023-08-25",
                            "time": "10:30:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-08-25",
                            "time": "14:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-08-26",
                            "time": "10:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-08-26",
                            "time": "13:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "15",
                        "url": "https://en.wikipedia.org/wiki/2023_Italian_Grand_Prix",
                        "raceName": "Italian Grand Prix",
                        "Circuit": {
                            "circuitId": "monza",
                            "url": "http://en.wikipedia.org/wiki/Autodromo_Nazionale_Monza",
                            "circuitName": "Autodromo Nazionale di Monza",
                            "Location": {
                                "lat": "45.6156",
                                "long": "9.28111",
                                "locality": "Monza",
                                "country": "Italy"
                            }
                        },
                        "date": "2023-09-03",
                        "time": "13:00:00Z",
                        "FirstPractice": {
                            "date": "2023-09-01",
                            "time": "12:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-09-01",
                            "time": "15:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-09-02",
                            "time": "11:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-09-02",
                            "time": "14:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "16",
                        "url": "https://en.wikipedia.org/wiki/2023_Singapore_Grand_Prix",
                        "raceName": "Singapore Grand Prix",
                        "Circuit": {
                            "circuitId": "marina_bay",
                            "url": "http://en.wikipedia.org/wiki/Marina_Bay_Street_Circuit",
                            "circuitName": "Marina Bay Street Circuit",
                            "Location": {
                                "lat": "1.2914",
                                "long": "103.864",
                                "locality": "Marina Bay",
                                "country": "Singapore"
                            }
                        },
                        "date": "2023-09-17",
                        "time": "12:00:00Z",
                        "FirstPractice": {
                            "date": "2023-09-15",
                            "time": "10:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-09-15",
                            "time": "13:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-09-16",
                            "time": "10:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-09-16",
                            "time": "13:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "17",
                        "url": "https://en.wikipedia.org/wiki/2023_Japanese_Grand_Prix",
                        "raceName": "Japanese Grand Prix",
                        "Circuit": {
                            "circuitId": "suzuka",
                            "url": "http://en.wikipedia.org/wiki/Suzuka_Circuit",
                            "circuitName": "Suzuka Circuit",
                            "Location": {
                                "lat": "34.8431",
                                "long": "136.541",
                                "locality": "Suzuka",
                                "country": "Japan"
                            }
                        },
                        "date": "2023-09-24",
                        "time": "05:00:00Z",
                        "FirstPractice": {
                            "date": "2023-09-22",
                            "time": "03:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-09-22",
                            "time": "06:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-09-23",
                            "time": "03:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-09-23",
                            "time": "06:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "18",
                        "url": "https://en.wikipedia.org/wiki/2023_Qatar_Grand_Prix",
                        "raceName": "Qatar Grand Prix",
                        "Circuit": {
                            "circuitId": "losail",
                            "url": "http://en.wikipedia.org/wiki/Losail_International_Circuit",
                            "circuitName": "Losail International Circuit",
                            "Location": {
                                "lat": "25.49",
                                "long": "51.4542",
                                "locality": "Al Daayen",
                                "country": "Qatar"
                            }
                        },
                        "date": "2023-10-08",
                        "time": "14:00:00Z",
                        "FirstPractice": {
                            "date": "2023-10-06",
                            "time": "10:30:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-10-06",
                            "time": "14:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-10-07",
                            "time": "11:00:00Z"
                        },
                        "Sprint": {
                            "date": "2023-10-07",
                            "time": "14:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "19",
                        "url": "https://en.wikipedia.org/wiki/2023_United_States_Grand_Prix",
                        "raceName": "United States Grand Prix",
                        "Circuit": {
                            "circuitId": "americas",
                            "url": "http://en.wikipedia.org/wiki/Circuit_of_the_Americas",
                            "circuitName": "Circuit of the Americas",
                            "Location": {
                                "lat": "30.1328",
                                "long": "-97.6411",
                                "locality": "Austin",
                                "country": "USA"
                            }
                        },
                        "date": "2023-10-22",
                        "time": "19:00:00Z",
                        "FirstPractice": {
                            "date": "2023-10-20",
                            "time": "19:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-10-20",
                            "time": "22:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-10-21",
                            "time": "19:00:00Z"
                        },
                        "Sprint": {
                            "date": "2023-10-21",
                            "time": "22:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "20",
                        "url": "https://en.wikipedia.org/wiki/2023_Mexico_City_Grand_Prix",
                        "raceName": "Mexico City Grand Prix",
                        "Circuit": {
                            "circuitId": "rodriguez",
                            "url": "http://en.wikipedia.org/wiki/Aut%C3%B3dromo_Hermanos_Rodr%C3%ADguez",
                            "circuitName": "Autódromo Hermanos Rodríguez",
                            "Location": {
                                "lat": "19.4042",
                                "long": "-99.0907",
                                "locality": "Mexico City",
                                "country": "Mexico"
                            }
                        },
                        "date": "2023-10-29",
                        "time": "20:00:00Z",
                        "FirstPractice": {
                            "date": "2023-10-27",
                            "time": "18:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-10-27",
                            "time": "21:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-10-28",
                            "time": "17:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-10-28",
                            "time": "20:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "21",
                        "url": "https://en.wikipedia.org/wiki/2023_S%C3%A3o_Paulo_Grand_Prix",
                        "raceName": "São Paulo Grand Prix",
                        "Circuit": {
                            "circuitId": "interlagos",
                            "url": "http://en.wikipedia.org/wiki/Aut%C3%B3dromo_Jos%C3%A9_Carlos_Pace",
                            "circuitName": "Autódromo José Carlos Pace",
                            "Location": {
                                "lat": "-23.7036",
                                "long": "-46.6997",
                                "locality": "São Paulo",
                                "country": "Brazil"
                            }
                        },
                        "date": "2023-11-05",
                        "time": "18:00:00Z",
                        "FirstPractice": {
                            "date": "2023-11-03",
                            "time": "15:30:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-11-03",
                            "time": "19:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-11-04",
                            "time": "15:30:00Z"
                        },
                        "Sprint": {
                            "date": "2023-11-04",
                            "time": "19:30:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "22",
                        "url": "https://en.wikipedia.org/wiki/2023_Las_Vegas_Grand_Prix",
                        "raceName": "Las Vegas Grand Prix",
                        "Circuit": {
                            "circuitId": "vegas",
                            "url": "https://en.wikipedia.org/wiki/Las_Vegas_Grand_Prix#Circuit",
                            "circuitName": "Las Vegas Strip Street Circuit",
                            "Location": {
                                "lat": "36.1147",
                                "long": "-115.173",
                                "locality": "Las Vegas",
                                "country": "United States"
                            }
                        },
                        "date": "2023-11-18",
                        "time": "13:00:00Z",
                        "FirstPractice": {
                            "date": "2023-11-16",
                            "time": "12:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-11-16",
                            "time": "15:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-11-17",
                            "time": "11:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-11-17",
                            "time": "14:00:00Z"
                        }
                    },
                    {
                        "season": "2023",
                        "round": "23",
                        "url": "https://en.wikipedia.org/wiki/2023_Abu_Dhabi_Grand_Prix",
                        "raceName": "Abu Dhabi Grand Prix",
                        "Circuit": {
                            "circuitId": "yas_marina",
                            "url": "http://en.wikipedia.org/wiki/Yas_Marina_Circuit",
                            "circuitName": "Yas Marina Circuit",
                            "Location": {
                                "lat": "24.4672",
                                "long": "54.6031",
                                "locality": "Abu Dhabi",
                                "country": "UAE"
                            }
                        },
                        "date": "2023-11-26",
                        "time": "13:00:00Z",
                        "FirstPractice": {
                            "date": "2023-11-24",
                            "time": "10:00:00Z"
                        },
                        "SecondPractice": {
                            "date": "2023-11-24",
                            "time": "13:00:00Z"
                        },
                        "ThirdPractice": {
                            "date": "2023-11-25",
                            "time": "11:00:00Z"
                        },
                        "Qualifying": {
                            "date": "2023-11-25",
                            "time": "14:00:00Z"
                        }
                    }
                ]
            }
        }
    }
"""
        
}
