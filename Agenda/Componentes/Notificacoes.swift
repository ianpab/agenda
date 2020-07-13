//
//  Notificacoes.swift
//  Agenda
//
//  Created by Ian Pablo on 02/09/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class Notificacoes: NSObject {

    func exibirNotificacao(dicionarioMedia:Dictionary<String, Any>) -> UIAlertController?{
        if let media = dicionarioMedia["media"] as? String{
            let alerta = UIAlertController(title: "Atenção", message: "A média dos alunos é: \(media)", preferredStyle: .alert)
            let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
            alerta.addAction(botao)
            
            return alerta
        
        }
        return nil
    }
}
