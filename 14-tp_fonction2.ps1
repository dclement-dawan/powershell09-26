# https://standards-oui.ieee.org/

# Créer une fonction Get-Manufacturer
#    en entrée: une adresse MAC $MACAddress de type String obligatoire
#    utiliser un [ValidatePattern('^([a-f0-9]{2}(:|-| )?){5}[a-f0-9]{2}$')] sur le paramètre $MacAddress
'C4-E9-0A-96-B1-C3' -match '^([a-f0-9]{2}(:|-| )?){5}[a-f0-9]{2}$'
'C4:E9:0A:96:B1:C3' -match '^([a-f0-9]{2}(:|-| )?){5}[a-f0-9]{2}$'
'C4E90G96B1C3' -match '^([a-f0-9]{2}(:|-| )?){5}[a-f0-9]{2}$'

#   en sortie: le nom du fabricant ou 'N/A' si inexistant
# Documenter la fonction

# But : A partir du fichier oui.txt récupérer le nom du fabricant


# ipconfig /all   ou  Get-NetAdapter
# 'C4-E9-0A-96-BC-CF'
# 'C4-E9:0A 96-BC-CF' -replace '-',''
# Nettoyer l'adresse MAC

'C4-E9:0A 96-BC-CF' -replace '-|:| ', '' # avec expression régulière (| = ou logique)

# Découper l'adresse MAC et récupérer le préfixe de 3 octets
'C4E90A96BCCF'.Substring(0, 6)  # 3 premiers octets

# Chercher le préfixe d'adresse mac dans le fichier oui.txt
# Convertir un objet en chaine de caractères
Select-String -Pattern 'C4E90A' -Path .\oui.txt -SimpleMatch | Out-String
# ou
(Select-String -Pattern 'C4E90A' -Path .\oui.txt -SimpleMatch)[0].Line

# -split : opérateur de découpage string -> array
# découpage de la chaîne avec le caractère tabulation `t
# le deuxième élément
('C4E90A     (base 16)		D-Link International' -split "`t+")[1]

# ou $tab[-1] : dernier élément du tableau
('C4E90A     (base 16)		D-Link International' -split "`t+")[-1]



# première étape: chaîner les commandes avec des variables intermédiaires


# deuxième étape : intégrer ses commandes dans la fonction
# avec le paramètre et la doc
