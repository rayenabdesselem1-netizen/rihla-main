# Journal IA — TP6 (Copilot)

Nom :mohamed aziz sta Dépôt : ……………………

Au moins 4 lignes, dont au moins une suggestion **modifiée** ou **rejetée**.

| # | Outil Copilot | Demande / intention | Décision | Pourquoi |
|---|---|---|---|---|
| 1 | Complétion | TODO basculer du FavorisModel | Modifiée | La suggestion oubliait `notifyListeners()`. Je l’ai ajouté. |
| 2 | Chat inline (Ctrl+I) | Proposer `FavorisScreen` avec la liste des favoris et le message si elle est vide | Modifiée | J’ai gardé `context.watch<FavorisModel>()` pour actualiser l’écran et le message « Aucun favori pour le moment ». |
| 3 | `/explain` | Expliquer pourquoi `FavorisModel` appelle `notifyListeners()` après `basculer` | Acceptée | Cela avertit les widgets qui écoutent le modèle afin qu’ils se reconstruisent avec l’état des favoris mis à jour. |
| 4 | `/explain` | Expliquer la différence entre `watch` et `read` dans `FavoriteButton` | Acceptée | `watch` écoute les changements et reconstruit le widget; `read` lit le modèle sans écouter pour appeler `basculer`. |
| 5 | `/explain` | Expliquer pourquoi `FavoriteButton` peut être `StatelessWidget` alors que son affichage change | Acceptée | Le widget ne stocke pas l’état; Provider le reconstruit quand `FavorisModel` notifie ses écouteurs. |

Outil : Complétion · Chat inline (Ctrl+I) · /explain · Message de commit (✨)
Décision : Acceptée · Modifiée · Rejetée

## /explain : watch et read (partie 2.4)
`watch` met le widget à jour quand les données changent. `read` lit les données sans écouter les changements.

## Questions de compréhension
**Partie 1** — Que se passe-t-il pour `main` si je casse l'application sur `feature/favoris` ?

Rien ne change dans `main` tant que `feature/favoris` n’est pas fusionnée dans `main`.

**Partie 2**
1. Pourquoi `FavoriteButton` peut-il être un `StatelessWidget` alors que son affichage change ?

`FavoriteButton` ne garde pas les favoris. `watch` écoute le modèle et met le bouton à jour quand il change.

2. Pourquoi ranger les favoris par `id` plutôt que dans un `Set<Destination>` ?

Chaque rechargement peut créer de nouveaux objets `Destination`. Mais l’id d’une destination reste le même. La `Map` utilise cet id pour retrouver le favori.

3. Pourquoi les favoris disparaissent-ils après un hot restart ?

Les favoris sont gardés en mémoire. Un hot restart vide cette mémoire. Il faut les enregistrer, par exemple dans `db.json`, pour les garder.

**Partie 4**
1. Pourquoi la Partie 3 n'a-t-elle produit aucun conflit ?

Les branches n’ont pas changé les mêmes lignes de façon incompatible. Git a donc pu les fusionner sans conflit.

2. Que se passe-t-il si j'oublie de supprimer un marqueur `=======` ?

`=======` est un marqueur de conflit, pas du code Dart valide. S’il reste dans le fichier, l’application ne compile pas. Il faut régler le conflit et supprimer tous les marqueurs.

**TP 7**
palier 1 :
Pourquoi stocke-t-on des String JSON et pas directement des objets Destination ? 
pour les enregistrer en db.json on doit les transformer en string json pour les sauvgarader comme objets json puis on les reconstruit en des objets destinations quand on va les utiliser

Que fait exactement FavorisModel()..charger() ? Que se passerait-il avec FavorisModel().charger() ?
..charger appelle la methode charger mais laisse l'objet initale donc elle charge les données, on l'utilise car les fonctions qu'on utilise sont async, si on utilise .charger favorismodel va charger la variable Future<void> comme elle est maintenant donc sans charger les données si ils changent



 Pourquoi oublier notifyListeners() à la fin de charger() serait-il un bug discret ?
car les données vont etre affichées et lors de changement les données vont etre modifiées mais pas à l'affichage

Palier 3: 
1: on vérifie que le serveur a repndu correctement, sinon on risquait de sauvgarder une reponse d'erreur a la place des destinations.
2: elle voit un message d'erreur et un bouton pour réssayer car il n'ya pas encore de cache avec les destinations à afficher.
3: rethrow relance la mere erreur. le futurebuilder la recoit et affiche l'ecran d'érreur
## TP7 - Changement du theme

Suggestion IA initiale : ajouter seulement le bouton dans l'AppBar.
Decision : modifiee.
Pourquoi : le bouton seul ne change pas le theme de MaterialApp et ne restaure pas le choix apres un redemarrage. J'ai relie ReglagesModel a themeMode et charge le choix au demarrage. J'ai aussi verifie la meme cle en lecture/ecriture, la valeur false par defaut et notifyListeners() dans charger() et basculerTheme().
