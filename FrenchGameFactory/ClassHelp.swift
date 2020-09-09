//
//  ClassHelp.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 29/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

struct Text {
	/*
	- Text is the simpliest struct, équivalant to a simple String
	- The goal is to learn how to use nested structures using this struct in other structs
	*/
	var label: String
	
	init(_ label: String) {
		self.label = label
	}
}


struct Help {
	/*
	- The Help struct contains the various help messages used throughout the application.
	- A simple table would have done the trick.
	- The goal is to learn how to use nested structures by using another shared structure
	- As Help struct contains all the help message, the helpList function return partial content dépending on the context
	*/
	var texts = [Text("\nBienvenue dans cette introduction !"),
					 Text("\nObjectif :"),
					 Text("   - La demande initiale de Charlotte était de fournir un programme basique permettant de simuler le déroulement d'un jeu de rôle. L'objectif pour elle étant de trouver le bon EQUILIBRE du jeu en modifiant si besoin le code source, même si elle n'est pas une développeuse, comme elle le dit."),
					 Text("   - Comme la demande était vague dans ces contours et n’ayant aucune connaissance en jeu de rôle (je préfère la randonnée :-)), il m’a semblé pratique de proposer quelques paramètres modifiables directement depuis l’interface pour simplifier son travail de game designeuse. Rien n’empêche à chacun de mettre son nez dans le code pour voir ce qui s’y passe. ;-)."),
					 Text("   - Cette application n'est donc pas un RPG mais un simulateur permettant de varier différentes paramètres ou règles afin de tester l'impact sur le déroulement du jeu."),
					 Text("\nUtilisation de l'application :"),
					 Text("   - Pour faciliter la saisie, toutes les fonctions sont représentées à l'écran par des lettres ou des chiffre encadrés."),
					 Text("    - Appuyez simplement sur la touche correspondant à la fonction pour l'activer. L'usage de la touche Entrée est inutile, sauf demande explite dans les messages pour la saisie d'informations."),
					 Text("   - Les touches majuscules et minuscules sont prises en compte de la même façon. Pour les claviers sans pavé numérique, les autres caractères inscrits sur les touches numériques sont également pris en compte pour le choix d'une fonction. Cela évite d'avoir à utiliser la touche shift chaque fois que l'on veut taper un chiffre."),
					 Text("   - Comme demandé, l'interface de l'application ainsi que les variables et commentaires dans le code source sont en anglais."),
					 Text("\nQuelques détails pratiques :"),
					 Text("   - Pour simplifier l'utilisation du simulateur, 2 équipes de 3 avatars avec leurs armes sont créés au lancement du simulateur. L'interface permet de personnaliser le nom des équipes, des avatars, ainsi que le choix des armes utilisées."),
					 Text("   - La capacité de destruction n'étant pas uniquement liée à l'arme mais aussi aux qualités du personnage (agilité, force, expérience...), ces points sont directement associés à chaque avatar afin faciliter leur modification dans le simulateur."),
					 Text("   - Avant chaque nouvelle partie vous pouvez modifier certains paramètres du jeu tels que le nombre de points de vie, de destruction et de soin ainsi que leur répartition au sein d'une équipe."),
					 Text("   - Vous pouvez également modifier certaines règles :"),
					 Text("     - Mode Tour : Rotation entre les avatars ou bien choix par le joueur à chaque tour."),
					 Text("     - Mode Soin : Soit les soins sont 'gratuits', soit les points de soin donnés sont déduits des points de vie du donneur."),
					 Text("     - Mode Extra :"),
					 Text("       - Fréquence: % de chance d'avoir une offre d'extra en mode attack"),
					 Text("       - Nombre de points de l'offre. Ce nombre de points sera ajouté ou déduit selon une valeur aléatoire (1/2)"),
					 Text("\n    - Enfin, le programme enregistre chaque tour avec l'ensemble de ses paramètres. Cela permet de consulter l'historique de la partie&, y compris pendant la partie."),
					 Text("\n    - Comme cette application est un plutôt un POC, la fonction de sauvegarde dans un fichier n'est pas implémentée.\n"),
					 Text("───────────────────────────── 􀂨eys functions ───────────────────────────"),
					 Text("    􀂴: Quit Game Parameters         􀂢: Display current Help"),
					 Text("  􀃊􀃌: Modify the team's 􀂮ame   􀃊..􀑵: Modify the avatar's data"),
					 Text("􀂪􀂚􀂘: Modify points allocation      􀂜: Extra Chance & Extra Points"),
					 Text("       for Life Damage & Care        􀂬: Care mode: +care = -life or not"),
					 Text("    􀂲: PLAY GAME                    􀂺: Turn mode: rotation/choice player"),
					 Text("▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"),
					 Text("────────────────────────────────────── 􀂨eys functions ────────────────────────────────────"),
					 Text("􀂴: Quit Game or Round          􀂢: Display current Help        􀂪: Display the game's Log"),
					 Text("▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"),
					 Text("──────────────── 􀂨eys functions ────────────"),
					 Text("􀂴: Quit RPG Simulator      􀂢: Display Help"),
					 Text("􀃊: Presentation Simulator  􀃌: Start a game"),
					 Text("▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔")]

				
	func helpList(_ index: Int) -> [String]
	{
		// This function return an array of formated string for the helpDisplay function
		let index1		= helpSection.context[index][0]
		let index2		= index1 + helpSection.context[index][1] - 1
		var helpList	= [String]()
		for index3 in index1...index2 {
			helpList.append(self.texts[index3].label)
		}
		return helpList
	}
	
	func helpDisplay(_ sectionIndex: Int)
	{
		// This function displays the help corresponding to the requested section.
		let helpList 	= helps.helpList(sectionIndex)
		for index in 0...helpList.count - 1 {
			print(helpList[index])
		}
	}
}


struct HelpSection {
	/*
	- The HelpIndex structure allows to store the values of the start and end indexes according to the calling context.
	- Thus, if the content of the Help structure evolves, it will not be necessary to modify all the calls but just the HelpIndex structure.
	*/
	var context = [[0, 22], [22, 7], [29, 3], [32, 4]]
}



/* Same in english -> need to be updated since the last modifications
Text("\nWelcome to this introduction!"),
Text("\nGoal :"),
Text("   - Charlotte's initial request is to provide a basic program simulating a role-playing game in his sequences to allow her to find the right BALANCE of the game by making changes directly in the source code if needed."),
Text("   - As the request is vague in its outlines and having no knowledge in role-playing games (I prefer hiking :-)), it appeared to me more practical to provide some parameters that could be modified directly from the application to simplify her work as a game designer. Nothing prevents anyone from poking his nose into the code and seeing what happens. :-)"),
Text("   - As requested, this application is not an RPG game but a simulator allowing to vary different parameters of the games rules in order to find the right BALANCING necessary to succeed the player's interest."),
Text("\nUsing the application :"),
Text("   - To facilitate input, the available functions are represented on the screen by framed letters or numbers."),
Text("   - Simply press the corresponding key to trigger the action."),
Text("   - The use of the Enter key is unnecessary, unless explicitly requested in a message."),
Text("\nSome practical details :"),
Text("   - In order to simplify its use, 2 teams of 3 avatars have been pre-loaded."),
Text("   - You can modify teams's names, avatars's namess and choose others weapons from the armory."),
Text("   - Before each game you have the possibility to change some rules of the game as well as the allocation of life, damage and care points between the different avatars."),
Text("\n   - The capacity of destruction being not the only fact of the weapon used (experience, agility, ...) it seemed more practical to me that points are attached directly to the characters, which facilitates the modification of the simulator's rules."),
Text("\n   - Finally, the progress of each game is memorized, which allows you to consult the list of turns and actions performed at any time."),
Text("\n   - As this application is a POC, the function for saving data and parameters to a file is not available. You can still use all the functions while the application remains open.\n"),
*/
