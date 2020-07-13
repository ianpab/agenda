//
//  Filtro.swift
//  Agenda
//
//  Created by Ian Pablo on 05/12/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class Filtro: NSObject {

    func FiltraAlunos(listaDeAlunos:Array<Aluno>, texto:String) -> Array<Aluno>{
        let alunoEncontrado = listaDeAlunos.filter { (aluno) -> Bool in
            if let nome = aluno.nome{
                
                return nome.contains(texto)
            }
            return false
        }
        return alunoEncontrado
    }
}
