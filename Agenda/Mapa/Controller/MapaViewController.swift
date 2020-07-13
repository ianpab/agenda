//
//  MapaViewController.swift
//  Agenda
//
//  Created by Ian Pablo on 28/08/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var mapa: MKMapView!
    
    // MARK: - Variavel
    
    var aluno:Aluno?
    lazy var localizacao = Localizacao()
    lazy var gerenciadorDeLocalizacao = CLLocationManager()
    
    
    // MARK: - View lifestyle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = titulo()
        verificaAutorizacaoGPS()
        localizacaoInicial()
        mapa.delegate = localizacao
        gerenciadorDeLocalizacao.delegate = self

    }
    
    // MARK: - Metodos
    
    func titulo() -> String{
        return "Localizar Aluno"
    }
    
    func localizacaoInicial(){
        Localizacao().converteEnderecoEmCoordenadas(endereco: "Caelum, São Paulo") { (localizacaoEncontrada) in
       // let pino = self.configuraPino(titulo: "Caelum", localizacao: localizacaoEncontrada)
        let pino = Localizacao().configuraPino(titulo: "Caelum", localizacao: localizacaoEncontrada, cor: .black, icone: UIImage(named: "icone_apple"))
        let regiao = MKCoordinateRegion.init(center: pino.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        self.mapa.setRegion(regiao, animated: true)
        self.mapa.addAnnotation(pino)
            self.localizarAluno()
        }
        
    }
    
    func localizarAluno(){
        if let aluno = aluno{
            Localizacao().converteEnderecoEmCoordenadas(endereco: aluno.endereco!) { (localizacaoEncontrada) in
            //    let pino = self.configuraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada)
                
                let pino = Localizacao().configuraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada, cor: nil, icone: nil)
            self.mapa.addAnnotation(pino)
            self.mapa.showAnnotations(self.mapa.annotations, animated: true)
            }
        }
    }
    
    func verificaAutorizacaoGPS(){
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus() {
                case .authorizedWhenInUse:
                    let botao = Localizacao().configuraBotaoLocalizacaoAtual(mapa: mapa)
                    mapa.addSubview(botao)
                    gerenciadorDeLocalizacao.startUpdatingLocation()
                    break
            case .notDetermined:
                    gerenciadorDeLocalizacao.requestWhenInUseAuthorization()
                    
                    break
                    
            case .denied:
                    
                    break
            default:
                break
                }
            
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            let botao = Localizacao().configuraBotaoLocalizacaoAtual(mapa: mapa)
            mapa.addSubview(botao)
            gerenciadorDeLocalizacao.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    

}
