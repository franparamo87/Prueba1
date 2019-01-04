//
//  Data.swift
//  Ejercicio
//
//  Created by Francisco Paramo Muñoz on 28/12/2018.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

protocol dataDownload {
    func correctDataDownload(arr : [CentroCultural])
    func errorDataDownload(err : Error)
}

import Alamofire

class Datas {
    let URL = "https://datos.madrid.es/portal/site/egob/menuitem.ac61933d6ee3c31cae77ae7784f1a5a0/?vgnextoid=00149033f2201410VgnVCM100000171f5a0aRCRD&format=json&file=0&filename=200304-0-centros-culturales&mgmtid=fc8a034270603410VgnVCM1000000b205a0aRCRD&preview=full"
    var centros = [CentroCultural]()

    func downloadData(delegate : dataDownload){
        Alamofire.request(URL).responseJSON { response in
            if response.result.isFailure {
                if let err = response.result.error {
                    print (err.localizedDescription)
                    delegate.errorDataDownload(err: err)
                }
                return
            }
            
            do{
                //created the json decoder
                let decoder = JSONDecoder()
                
                //using the array to put values
                let download = try decoder.decode(Download.self, from: response.data!)
                self.centros = download.graph!
        
                delegate.correctDataDownload(arr: self.centros)
            }catch let err{
                print(err)
                delegate.errorDataDownload(err: err)
            }
        }
    }
    
}

