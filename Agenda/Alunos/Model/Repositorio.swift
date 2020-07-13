//
//  repositorio.swift
//  Agenda
//
//  Created by Ian Pablo on 13/10/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class Repositorio: NSObject {
    
    func RecuperaAlunos(completion:@escaping(_ listaDeAlunos:Array<Aluno>) -> Void){
        var alunos = AlunoDAO().recuperaAlunos()
        if alunos.count == 0{
            AlunoAPI().recuperaAlunos{
                alunos = AlunoDAO().recuperaAlunos()
                completion(alunos)
            }
        }else{
            completion(alunos)
        }
    }

    func salvaAluno(aluno:Dictionary<String, String>){
        AlunoAPI().salvarAlunosNoServidor(parametros: [aluno])
        AlunoDAO().salvarAluno(dicionarioDeAluno: aluno)
        
    }
    
    func deletaAluno(aluno:Aluno){
        guard let idAluno = aluno.id else { return }
        AlunoAPI().deletarAluno(id: String(describing: idAluno).lowercased())
        AlunoDAO().deletaAluno(aluno: aluno)
    }
    
    func sincronizaAlunos(){
        let alunos = AlunoDAO().recuperaAlunos()
        var listaDeParametros:Array<Dictionary<String, String>> = []
        for aluno in alunos{
            guard let idAluno = aluno.id else { return }
            let parametros:Dictionary<String, String> = [
                "id" : String(describing: idAluno).lowercased(),
               "nome" : aluno.nome ?? "",
               "endereco" : aluno.endereco ?? "",
               "telefone" : aluno.telefone ?? "",
               "site" : aluno.site ?? "",
               "nota" : "\(aluno.nota)"
            ]
            listaDeParametros.append(parametros)
        }
        AlunoAPI().salvarAlunosNoServidor(parametros: listaDeParametros)
    }
}
