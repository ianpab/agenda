//
//  LigacaoTelefonica.swift
//  Agenda
//
//  Created by Ian Pablo on 02/11/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class LigacaoTelefonica: NSObject {
    
    func fazLigacao(_ alunoSelecionado:Aluno){
            guard let numeroAluno = alunoSelecionado.telefone else { return }
            if let url = URL(string: "tel://\(numeroAluno)"), UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
    }

}
