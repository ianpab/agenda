//
//  MenuOpcoesAlunos.swift
//  Agenda
//
//  Created by Ian Pablo on 11/08/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

//enum menuActionSheetAlunos {
//    case sms
//    case ligacao
//    case waze
//    case mapa
//    case web
//
//}

class MenuOpcoesAlunos: NSObject {

    func configMenuDeOpcoesAlunos(alunoSelecionado:Aluno, navigation:UINavigationController) -> UIAlertController{
        let menu = UIAlertController(title: "Atencao", message: "Selecione uma opcao", preferredStyle: .actionSheet)
        guard let navigationController = navigation.viewControllers.last else { return menu }
        
        // SMS
        let sms = UIAlertAction(title: "SMS", style: .default) { (acao) in
            Mensagem().enviaSMS(alunoSelecionado, controller: navigationController)
        }
        menu.addAction(sms)
        
        // LIGACAO
        let ligacao = UIAlertAction(title: "Ligar", style: .default) { (acao) in
            LigacaoTelefonica().fazLigacao(alunoSelecionado)
        }
        menu.addAction(ligacao)
        
        // CANCELAR
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        menu.addAction(cancelar)
        
        // WAZE
        let waze = UIAlertAction(title: "Localizar no Waze", style: .default) { (acao) in
            Localizacao().localizaAlunoNoWaze(alunoSelecionado)
        }
        menu.addAction(waze)
        
        // MAPA
        let mapa = UIAlertAction(title: "Localizar no Mapa", style: .default) { (acao) in

            let mapa = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapa") as! MapaViewController
            mapa.aluno = alunoSelecionado
            navigation.pushViewController(mapa, animated: true)

        }
        menu.addAction(mapa)
        
        // SAFARI
        let web = UIAlertAction(title: "Abrir página", style: .default) { (acao) in
            Safari().abrirPaginaWeb(alunoSelecionado, controller: navigationController)
        }
        menu.addAction(web)
        
        return menu
    }
    
}
