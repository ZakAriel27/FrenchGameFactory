//
//  Help.swift
//  FrenchGameFactory
//
//  Created by Pascal Diamand on 29/08/2020.
//  Copyright © 2020 Pascal Diamand. All rights reserved.
//

// The Help struct contains the various help messages used throughout the application.
struct Help
{
	var text = ["\nBienvenue dans cette introduction !",
					 "\nObjectif :",
					 "   - La demande initiale de Charlotte était de fournir un programme basique permettant de simuler le déroulement d'un jeu de rôle. L'objectif pour elle étant de trouver le bon EQUILIBRE du jeu en modifiant si besoin le code source, même si elle n'est pas une développeuse, comme elle le dit.",
					 "   - Comme la demande était vague dans ces contours et n’ayant aucune connaissance en jeu de rôle (je préfère la randonnée :-)), il m’a semblé pratique de proposer quelques paramètres modifiables directement depuis l’interface pour simplifier son travail de game designeuse. Rien n’empêche à chacun de mettre son nez dans le code pour voir ce qui s’y passe. ;-).",
					 "   - Cette application n'est donc pas un RPG mais un simulateur permettant de varier différents paramètres ou règles afin de tester l'impact sur le déroulement du jeu.",
					 "\nUtilisation de l'application :",
					 "   - Pour faciliter la saisie, toutes les fonctions sont représentées à l'écran par des lettres ou des chiffre encadrés.",
					 "    - Appuyez simplement sur la touche correspondant à la fonction pour l'activer. L'usage de la touche Entrée est inutile, sauf demande explite dans les messages pour la saisie d'informations.",
					 "   - Les touches majuscules et minuscules sont prises en compte de la même façon. Pour les claviers sans pavé numérique, les autres caractères inscrits sur les touches numériques sont également pris en compte pour le choix d'une fonction. Cela évite d'avoir à utiliser la touche shift chaque fois que l'on veut taper un chiffre.",
					 "   - Comme demandé, l'interface de l'application ainsi que les variables et commentaires dans le code source sont en anglais.",
					 "\nQuelques détails pratiques :",
					 "   - Pour simplifier l'utilisation du simulateur, 2 équipes de 3 avatars avec leurs armes sont créés au lancement du simulateur. L'interface permet de personnaliser le nom des équipes, des avatars, ainsi que le choix des armes utilisées.",
					 "   - La capacité de destruction n'étant pas uniquement liée à l'arme mais aussi aux qualités du personnage (agilité, force, expérience...), ces points sont directement définis dans des profils afin faciliter leur modification dans le simulateur.",
					 "   - Vous pouvez modifier certains paramètres du jeu tels que le nombre de points de vie, de destruction et de soin ainsi que leur répartition au sein d'une équipe.",
					 "   - Vous pouvez également modifier certaines règles :",
					 "     - Mode Tour : Rotation entre les avatars ou bien choix par le joueur à chaque tour.",
					 "     - Mode Soin : Soit les soins sont 'gratuits', soit en contrepartie le donneur se voit soustrait un nombre de points de vie paramétrable.",
					 "     - Mode Extra :",
					 "       - Fréquence: % de chance d'avoir une offre d'extra en mode attack",
					 "       - Fourchette de points de l'offre. Ce nombre de points sera ajouté ou déduit selon une valeur aléatoire (1/2)",
					 "\n    - Enfin, le programme enregistre chaque tour avec l'ensemble de ses paramètres. Cela permet de consulter l'historique de la partie, y compris pendant la partie.",
					 "\n    - Comme cette application est un plutôt un POC, la fonction de sauvegarde dans un fichier n'est pas implémentée.\n",
					 "  ───────────────────────────────────── 􀂨eys functions ────────────────────────────────────",
					 "      􀂴: Quit Game Parameters                  􀂢: Display/hide this help",
					 "  􀃊..􀃘: Team & avatar's data               􀂪􀂚􀂘: Points allocation for Life Damage & Care",
					 "      􀂜: Extra offer Chance & Points           􀂬: Care mode: with/whithout removal life",
					 "      􀂺: Turn mode: rotation/free              􀂲: PLAY GAME",
					 "  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔",
					 "  ───────────────────────────────────── 􀂨eys functions ────────────────────────────────────",
					 "  􀂴: Quit Game or Round     􀂢: Toggle display/hide this help    􀂪: Display the game's Log",
					 "  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔",
					 "  ───────────────────── 􀂨eys functions ─────────────────",
					 "  􀂴: Quit RPG Simulator   􀂢: Display/Hide this Help",
					 "  􀃊: Presentation         􀃌: Settings     􀃎 Start game",
					 "  ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"]

// This method provides an array of formated string for the helpDisplay function
	func helpList(_ index: Int) -> [String]
	{
		let index1		= helpSection.context[index][0]
		let index2		= index1 + helpSection.context[index][1] - 1
		var helpList	= [String]()
		for index3 in index1...index2 {
			helpList.append(self.text[index3])
		}
		return helpList
	}
	
	// This method displays the help corresponding to the requested section.
	func helpDisplay(_ sectionIndex: Int)
	{
		let helpList 	= helps.helpList(sectionIndex)
		for index in 0...helpList.count - 1 {
			print(helpList[index])
		}
	}
}

// The HelpIndex structure allows to store the values of the start and end indexes according to the calling context
struct HelpSection
{
	var context = [[0, 22], [22, 6], [28, 3], [31, 4]]
}
