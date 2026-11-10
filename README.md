# Évaluation Git et GitHub

Ce projet réunit trois scripts Bash pour surveiller une machine, inventorier ses comptes locaux et vérifier l’état de ses services. Un lanceur commun regroupe leur exécution et propose une option de journalisation.

## Membres du groupe

| Nom | Prénom | Pseudo GitHub | Rôle |
| --- | --- | --- | --- |
| Thorez | Bastian | @baba59 | Élève 1 · Surveillance, présentation du lanceur et release v1.0 |
| Marcant | Jean-Baptiste | @Snyxis | Élève 2 · Audit local, journalisation, résolution du conflit et hotfix v1.0.1 |
| Defief | Mathéo | @Pau2Kol | Élève 3 · Vérification des services, lanceur commun et coordination du conflit |

## Prérequis et utilisation

Utiliser Bash sous Linux depuis la racine du dépôt. Pour l’audit, `awk` et un fichier `/etc/passwd` lisible suffisent. La surveillance utilise notamment `nproc`, `lsblk`, `df` et `awk`. Le contrôle des services nécessite une machine où systemd est actif et la commande `systemctl` est disponible. La journalisation utilise `tee`. Les scripts se lancent sans `sudo`. Le répertoire courant doit être accessible en écriture pour créer les journaux et le rapport.

| Script | Commande | Résultat |
| --- | --- | --- |
| A · Surveillance | `bash surveillance-systeme` | Affiche le nombre de cœurs, la charge CPU, les disques, les partitions et l’espace disque. L’affichage se répète jusqu’à Ctrl+C. |
| B · Audit local | `bash scripts/audit.sh` | Liste les comptes locaux, leur UID, leur GID principal, leur dossier personnel et leur shell. |
| C · Services | `bash scripts/services.sh` | Vérifie l’état de `ssh` et `cron` et écrit un rapport horodaté `rapport_services_*.txt`. |

### Lanceur commun

```bash
bash scripts/run.sh
bash scripts/run.sh --log
```

Le lanceur affiche un titre avant chaque script. Avec `--log`, les sorties et les erreurs des scripts sont également ajoutées à `run.log`. Les titres du lanceur s’affichent dans le terminal.

Sur la version de `develop` consultée, le lanceur cherche `scripts/monitoring.sh`, alors que la surveillance se trouve dans `surveillance-systeme`. Il faut aligner ces chemins pour que le lanceur trouve le script. La surveillance fonctionne en boucle, donc il faudra également prévoir un mode ponctuel pour que le lanceur puisse enchaîner les trois scripts. Le script actuel de services s’interrompt lorsqu’un service est arrêté, ce que le hotfix doit corriger.

## Organisation et Git Flow

- `main` reçoit les versions stables et `develop` rassemble le travail en cours.
- Les branches de fonctionnalité partent de `develop` et sont intégrées par pull request après revue. Les commits citent l’issue et la description de la PR utilise `Closes #N` pour la relier à la fusion vers la branche par défaut.
- Le tableau Kanban suit les états **Todo**, **In progress**, **In review** et **Done**. La Roadmap s’appuie sur les dates de début et de fin ainsi que sur les dépendances entre issues.
- La correction de l’affichage disque passe par une branche de bugfix issue de `develop`. Elle intervient avant la préparation de la release.

### Conflit dans le lanceur

Bastian et Jean-Baptiste ont créé deux branches depuis le même commit de `develop`. Ils ont modifié la même ligne dans `scripts/run.sh`, celle qui exécute chaque script. Bastian a travaillé sur la présentation des résultats et Jean-Baptiste sur l’option de journalisation.

Après la fusion de la PR de Bastian, Jean-Baptiste a intégré `origin/develop` dans sa branche de journalisation. Git a signalé le conflit. La résolution a conservé les titres et les séparateurs de Bastian, ainsi que le bloc qui active la journalisation avec `--log`.

### Versions

| Version | Statut | Procédure |
| --- | --- | --- |
| `v1.0` | À publier | Créer `release/1.0` depuis `develop`, préparer la version, ouvrir une PR vers `main`, publier le tag et la GitHub Release, puis réintégrer la branche dans `develop`. |
| `v1.0.1` | À publier | Laisser un commit de travail sur `develop`, puis créer `hotfix/1.0.1` depuis `main`. Corriger le script C pour signaler un service arrêté et poursuivre le contrôle. Fusionner vers `main`, publier le tag et la GitHub Release, puis réintégrer le hotfix dans `develop`. |

Pour les fusions de release et de hotfix, utiliser **Create a merge commit**.

### Protections de branches

La fiche demande une PR et deux approbations pour `main` et `develop`, avec application des règles aux administrateurs. Dans un groupe de trois, l’auteur dépend des deux autres membres pour obtenir ses approbations. Une PR approuvée peut aussi rester bloquée si un conflit apparaît. L’état des protections et les difficultés rencontrées restent à confirmer par le groupe avant le rendu.

## Questions de synthèse

Répartition proposée. Chaque membre relit et valide les réponses qui lui sont attribuées avant le rendu.

1. **Pourquoi séparer le développement des versions stables ?** *(Bastian Thorez)*  
   `develop` permet d’intégrer et de tester les changements en cours. `main` conserve la version stable qui sert de base aux publications et aux corrections urgentes.

2. **Pourquoi faire une revue avant l’intégration ?** *(Bastian Thorez)*  
   La revue permet à un autre membre de comprendre la modification, de repérer des erreurs et de vérifier que les critères de l’issue sont remplis avant la fusion.

3. **Qu’est-ce qui provoque un conflit Git ?** *(Jean-Baptiste Marcant)*  
   Un conflit peut se produire quand deux branches modifient différemment les mêmes lignes. Git a besoin d’une intervention humaine pour choisir comment combiner les changements. Dans notre lanceur, la résolution a combiné la présentation et la journalisation.

4. **Quelle différence entre un bugfix et un hotfix ?** *(Jean-Baptiste Marcant)*  
   Un bugfix corrige un problème dans le développement en cours. Un hotfix part de la version stable sur `main` pour corriger rapidement un problème déjà publié.

5. **Pourquoi réintégrer un hotfix dans `develop` ?** *(Jean-Baptiste Marcant)*  
   La réintégration transmet le correctif aux prochaines versions et évite de réintroduire le problème lors d’une future release.

6. **À quoi sert une branche de release ?** *(Bastian Thorez)*  
   Elle isole les vérifications et ajustements de publication, comme la mise à jour de la version, pendant que le développement peut continuer sur `develop`.

7. **Comment les Issues et Projects aident-ils le groupe ?** *(Mathéo Defief)*  
   Une issue décrit le travail, son responsable et ses critères. Le Project montre l’avancement et les dépendances. Les références dans les commits et PR relient la tâche au code intégré.

8. **Comment retrouver l’origine d’une modification ?** *(Mathéo Defief)*  
   `git log -- scripts/run.sh` affiche l’historique du fichier. `git blame scripts/run.sh` indique le commit associé à chaque ligne et `git show <commit>` affiche le changement. Le numéro d’issue permet ensuite de retrouver le contexte sur GitHub.
