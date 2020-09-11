//
//  Help.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 29/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

struct Help {
	/*
	- The Help struct contains the various help messages used throughout the application.
	- As Help struct contains all the help message, the helpList function return partial content dépending on the context
	*/
	var text = ["\nBienvenue dans cette introduction !",
					 "\nObjectif :",
					 "   - La demande initiale de Charlotte était de fournir un programme basique permettant de simuler le déroulement d'un jeu de rôle. L'objectif pour elle étant de trouver le bon EQUILIBRE du jeu en modifiant si besoin le code source, même si elle n'est pas une développeuse, comme elle le dit.",
					 "   - Comme la demande était vague dans ces contours et n’ayant aucune connaissance en jeu de rôle (je préfère la randonnée :-)), il m’a semblé pratique de proposer quelques paramètres modifiables directement depuis l’interface pour simplifier son travail de game designeuse. Rien n’empêche à chacun de mettre son nez dans le code pour voir ce qui s’y passe. ;-).",
					 "   - Cette application n'est donc pas un RPG mais un simulateur permettant de varier différentes paramètres ou règles afin de tester l'impact sur le déroulement du jeu.",
					 "\nUtilisation de l'application :",
					 "   - Pour faciliter la saisie, toutes les fonctions sont représentées à l'écran par des lettres ou des chiffre encadrés.",
					 "    - Appuyez simplement sur la touche correspondant à la fonction pour l'activer. L'usage de la touche Entrée est inutile, sauf demande explite dans les messages pour la saisie d'informations.",
					 "   - Les touches majuscules et minuscules sont prises en compte de la même façon. Pour les claviers sans pavé numérique, les autres caractères inscrits sur les touches numériques sont également pris en compte pour le choix d'une fonction. Cela évite d'avoir à utiliser la touche shift chaque fois que l'on veut taper un chiffre.",
					 "   - Comme demandé, l'interface de l'application ainsi que les variables et commentaires dans le code source sont en anglais.",
					 "\nQuelques détails pratiques :",
					 "   - Pour simplifier l'utilisation du simulateur, 2 équipes de 3 avatars avec leurs armes sont créés au lancement du simulateur. L'interface permet de personnaliser le nom des équipes, des avatars, ainsi que le choix des armes utilisées.",
					 "   - La capacité de destruction n'étant pas uniquement liée à l'arme mais aussi aux qualités du personnage (agilité, force, expérience...), ces points sont directement associés à chaque avatar afin faciliter leur modification dans le simulateur.",
					 "   - Avant chaque nouvelle partie vous pouvez modifier certains paramètres du jeu tels que le nombre de points de vie, de destruction et de soin ainsi que leur répartition au sein d'une équipe.",
					 "   - Vous pouvez également modifier certaines règles :",
					 "     - Mode Tour : Rotation entre les avatars ou bien choix par le joueur à chaque tour.",
					 "     - Mode Soin : Soit les soins sont 'gratuits', soit les points de soin donnés sont déduits des points de vie du donneur.",
					 "     - Mode Extra :",
					 "       - Fréquence: % de chance d'avoir une offre d'extra en mode attack",
					 "       - Nombre de points de l'offre. Ce nombre de points sera ajouté ou déduit selon une valeur aléatoire (1/2)",
					 "\n    - Enfin, le programme enregistre chaque tour avec l'ensemble de ses paramètres. Cela permet de consulter l'historique de la partie&, y compris pendant la partie.",
					 "\n    - Comme cette application est un plutôt un POC, la fonction de sauvegarde dans un fichier n'est pas implémentée.\n",
					 "───────────────────────────── 􀂨eys functions ───────────────────────────",
					 "    􀂴: Quit Game Parameters         􀂢: Display current Help",
					 "  􀃊􀃌: Modify the team's 􀂮ame   􀃊..􀑵: Modify the avatar's data",
					 "􀂪􀂚􀂘: Modify points allocation      􀂜: Extra Chance & Extra Points",
					 "       for Life Damage & Care        􀂬: Care mode: +care = -life or not",
					 "    􀂲: PLAY GAME                    􀂺: Turn mode: rotation/choice player",
					 "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔",
					 "────────────────────────────────────── 􀂨eys functions ────────────────────────────────────",
					 "􀂴: Quit Game or Round          􀂢: Display current Help        􀂪: Display the game's Log",
					 "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔",
					 "──────────────── 􀂨eys functions ────────────",
					 "􀂴: Quit RPG Simulator      􀂢: Display Help",
					 "􀃊: Presentation Simulator  􀃌: Start a game",
					 "▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"]

	func helpList(_ index: Int) -> [String]
	{
		// This function return an array of formated string for the helpDisplay function
		let index1		= helpSection.context[index][0]
		let index2		= index1 + helpSection.context[index][1] - 1
		var helpList	= [String]()
		for index3 in index1...index2 {
			helpList.append(self.text[index3])
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
