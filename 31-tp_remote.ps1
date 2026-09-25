# personnaliser les variables
$Partage = 'Dav_share'
$Server = 'AD1'
$Identite = 'dawan\david'
$UNCPath = "\\$Server\c$\shares\$Partage"
$LocalPath = "c:\shares\$Partage"


# 1- Créer le dossier $Partage via la partage administratif \\ad1\c$\shares


# 2- Avec une session CIM le partager via SMB dans c:\shares sur AD1.dawan.local (Get-Command *-smb*)


# 3- Avec une session WinRM
# Fixer les permissions NTFS en controle total pour votre utilisateur
# et désactiver l'héritage  (module NTFSSecurity)
# (get-acl $Path).Access | fl *




# 4- Avec une session WinRM
# Fixer un quota "10 GB Limit" sur votre partage : cf get-command *FSRM*
#   FSRM : File Server Resource Manager


# Avec une session CIM
# Vérifier le partage via une requête WMI sur le serveur
# Get-CimClass -ClassName *share*


# Fermer les sessions



# Bonus :
# 1- Ajouter un trap pour logguer les erreur des votre script dans un fichier
# log.txt avec la date et l'heure

# 2- Si le fichier credential.xml a plus de 15 jours, le supprimer
# Si le fichier credential.xml est présent le charger, sinon redemander un credential
# Enregsitrer le credential dans un fichier credential.xml

# 3- ajouter en début de script un test sur l'accessibilité du serveur
# pour les port SMB TCP/445 et WinRM TCP/5985
# arrêter le script si un des 2 protocoles n'est pas joignable
