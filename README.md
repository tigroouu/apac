# Site de l'APAC 91

Site statique (HTML/CSS, sans framework ni build) de l'Association de Protection Animale Castelviroise, reprenant le contenu de https://apac91.weebly.com/.

## Structure

```
index.html            Accueil
actualites.html       Actualités (collectes, AG, permanences)
nous-aider.html       Comment nous aider
famille-accueil.html  Devenir famille d'accueil
adopter.html          Conditions d'adoption
chatons.html          Chatons à l'adoption
juniors.html          Juniors à l'adoption
adultes.html          Adultes à l'adoption
adoptes.html          Ils ont été adoptés
boutique.html         Boutique
contact.html          Formulaire de contact
css/style.css         Styles (couleurs modifiables en haut du fichier)
js/menu.js            Menu mobile
scripts/rapatrier-medias.sh  Copie les images/PDF Weebly dans assets/
```

## Publier sur GitHub Pages

1. Créer un dépôt sur GitHub (par exemple `apac91`) et y pousser le contenu de ce dossier :
   ```bash
   git init
   git add .
   git commit -m "Site APAC 91"
   git branch -M main
   git remote add origin https://github.com/<compte>/apac91.git
   git push -u origin main
   ```
2. Sur GitHub : **Settings > Pages > Build and deployment**, source **Deploy from a branch**, branche `main`, dossier `/ (root)`.
3. Le site est publié à l'adresse `https://<compte>.github.io/apac91/` après une ou deux minutes.

Nom de domaine personnalisé (facultatif) : renseigner le domaine dans **Settings > Pages > Custom domain**, puis créer chez le registrar un enregistrement CNAME vers `<compte>.github.io`.

## Images et PDF : à rapatrier avant la fermeture du site Weebly

Les images et documents pointent pour l'instant vers leurs adresses Weebly. Pour que le site ne dépende plus de Weebly :

```bash
./scripts/rapatrier-medias.sh
git add assets *.html && git commit -m "Médias hébergés dans le dépôt" && git push
```

Le script télécharge environ 420 fichiers dans `assets/img` et `assets/docs`, puis réécrit les liens des pages.

Les photos des chats actuellement à l'adoption ne sont pas toutes reprises (le site Weebly les affiche dans des diaporamas non récupérables automatiquement) : les fiches sans photo affichent un pictogramme. Pour en ajouter une, déposer l'image dans `assets/img/` et remplacer dans la fiche :

```html
<div class="photo"><span class="placeholder" aria-hidden="true">🐱</span></div>
```
par
```html
<div class="photo"><img src="assets/img/tara.jpg" alt="Photo de Tara" loading="lazy"></div>
```

## Formulaire de contact

GitHub Pages n'exécute pas de code serveur. Le formulaire passe par le service gratuit [FormSubmit](https://formsubmit.co/), qui transfère les messages à `apac.virychatillon.91@gmail.com`. Au premier envoi, FormSubmit envoie un mail d'activation à cette adresse : il faut cliquer sur le lien pour activer le formulaire. Alternative : Formspree, ou un simple lien `mailto:`.

## Mettre à jour le contenu

- **Ajouter une actualité** : dans `actualites.html`, copier un bloc `<article class="news">…</article>` en haut de l'année concernée.
- **Ajouter un chat à l'adoption** : dans `chatons.html` ou `adultes.html`, copier un bloc `<article class="cat">…</article>`.
- **Chat adopté** : déplacer sa photo dans la galerie de l'année de `adoptes.html` (bloc `<figure>`).
- **Couleurs** : variables `--primary` et `--accent` en tête de `css/style.css`.
