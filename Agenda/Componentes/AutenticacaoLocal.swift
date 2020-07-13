//
//  AutenticacaoLocal.swift
//  Agenda
//
//  Created by Ian Pablo on 03/09/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import LocalAuthentication

class AutenticacaoLocal: NSObject {
    
    var error:NSError?

    func autorizaUsuario(completion:@escaping(_ autenticado:Bool) -> Void){
        let contexto = LAContext()
        if contexto.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
            contexto.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "é necessário fazer a autenticação para excluir o aluno.") { (resposta, erro) in
                completion(resposta)
            }
        }
    }
}
