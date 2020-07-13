//
//  HomeTableViewController.swift
//  Agenda
//
//  Created by Ândriu Coelho on 24/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit
import CoreData



class HomeTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: - Variáveis
    
    //COLOCA O CONTEXTO IGUAL AO OUTROS CONTROLLERS - FAZ CONEXAO AO BD
//    var contexto:NSManagedObjectContext{
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext
//    }
    
    let searchController = UISearchController(searchResultsController: nil)
    var alunoViewController:AlunoViewController?
    var alunos:Array<Aluno> = []
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuraSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recuperaAlunos()
    }
    
    // MARK: - Métodos
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar"{
        alunoViewController = segue.destination as? AlunoViewController
        }
    }
    
    func recuperaAlunos(){
        Repositorio().RecuperaAlunos { (listaDeAlunos) in
            self.alunos = listaDeAlunos
            self.tableView.reloadData()
        }
    }
    
    func configuraSearch() {
        self.searchController.searchBar.delegate = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
    
// BUSCA POR NOME
//
//    func filtroAluno(_ filtro:String) -> NSPredicate{
//        return NSPredicate.init(format: "nome CONTAINS %@", filtro)
//    }
//
//    func verificaFiltro(_ filtro:String) -> Bool{
//        if filtro.isEmpty{
//            return false
//        }
//        return true
//    }
    
    @objc func abrirActionSheet(_ longPress:UILongPressGestureRecognizer) {
        if longPress.state == .began {
            let alunoSelecionado = alunos[(longPress.view?.tag)!]
            guard let navigationController = navigationController else { return }
            let menu = MenuOpcoesAlunos().configMenuDeOpcoesAlunos(alunoSelecionado: alunoSelecionado, navigation: navigationController)
            present(menu, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let countAlunos = gerenciadorDeResultados?.fetchedObjects?.count else { return 0 }
//        return countAlunos
        
        return alunos.count // jeito novo
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula-aluno", for: indexPath) as! HomeTableViewCell
        celula.tag = indexPath.row

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(abrirActionSheet(_:)))
        
        //COLOCAR ALUNO EM CADA CELULA
//        guard let aluno = gerenciadorDeResultados?.fetchedObjects![indexPath.row] else { return celula }
        let aluno = alunos[indexPath.row] // jeito novo
        celula.configuraCelula(aluno)
        //COLOCAR LONG PRESS NA CELULA
        celula.addGestureRecognizer(longPress)
        return celula
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    // MARK: - Deletar
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // chamar o autenticacao para ver se foi liberado para deletar
            AutenticacaoLocal().autorizaUsuario { (autenticado) in
                if autenticado{
                    DispatchQueue.main.async {
                        let alunoSelecionado = self.alunos[indexPath.row]
                        Repositorio().deletaAluno(aluno: alunoSelecionado)
                        self.alunos.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
                    }

                }
            }

            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // guard let alunoSelecionado = gerenciadorDeResultados?.fetchedObjects![indexPath.row] else { return }
        let alunoSelecionado = alunos[indexPath.row]
        alunoViewController?.aluno = alunoSelecionado
    }
    

    
    @IBAction func buttonCalculaMedia(_ sender: UIBarButtonItem) {
        //guard let listaDeAlunos = gerenciadorDeResultados?.fetchedObjects else { return }
        CalculaMediaAPI().CalculaMediaGeralAlunos(alunos: alunos, sucesso: { (dicionario) in
            if let alerta = Notificacoes().exibirNotificacao(dicionarioMedia: dicionario){
                self.present(alerta, animated: true, completion: nil)
            }
        }) { (erro) in
            print(erro.localizedDescription)
        }
        
    }
    
    @IBAction func buttonLocalizacaoGeral(_ sender: UIBarButtonItem) {
        let mapa = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapa") as! MapaViewController
        
        navigationController?.pushViewController(mapa, animated: true)
                
    }
    
    // MARK: - SearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //    guard let nomeDoAluno = searchBar.text else { return }
//        recuperaAlunos(filtro: nomeDoAluno)
//        tableView.reloadData()
        if let texto = searchBar.text{
            alunos = Filtro().FiltraAlunos(listaDeAlunos: alunos, texto: texto)
            }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       // recuperaAlunos()
       // tableView.reloadData()
        alunos = AlunoDAO().recuperaAlunos()
        tableView.reloadData()
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
