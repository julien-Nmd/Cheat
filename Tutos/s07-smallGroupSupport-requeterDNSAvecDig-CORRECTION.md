# 💪 Challenge

Utilise la commande **dig** pour récupérer les informations suivantes :

- les adresses IP version 4 du site web de la **Wild Code School** ! www.wildcodeschool.com
- les adresses IP version 6 d'**odyssey** et en déduire l'hébergeur de ton fournisseur de quête préféré
-  (Bonus) les noms des serveurs de noms faisant autorité sur le domaine wildcodeschool.com et le serveur primaire.
- (Bonus) Refaire les requêtes précédentes en précisant l'utilisation du serveur récursif **quad9** (9.9.9.9 ou 2620:fe::9)

Poste les commandes tapées et leurs résultats dans le champs texte

# 🧐 Critères d'acceptation

- Toutes les adresses IPv4 de www.wildcodeschool.com ont été trouvées
- Toutes les adresses IPv6 d'odyssey.wildcodeschool.com ont été trouvées
- Les commandes utilisées sont correctes.

---

# 1. Adresses IPv4 de www.wildcodeschool.com

```bash
dig A www.wildcodeschool.com +short
```

=>
2902314.group14.sites.hubspot.net.
group14.sites.hscoscdn10.net.
199.60.103.225
199.60.103.31

# 2. Adresses IPv6 de odyssey.wildcodeschool.com

```bash
dig AAAA odyssey.wildcodeschool.com
```

=>
odyssey.wildcodeschool.com. 263	IN	CNAME	ghs.googlehosted.com.
ghs.googlehosted.com.	263	IN	AAAA	2a00:1450:4007:80e::2013

# 3. Serveurs de noms faisant autorité pour wildcodeschool.com

```bash
dig NS wildcodeschool.com +short
```

=>
wildcodeschool.com.	34077	IN	NS	kim.ns.cloudflare.com.
wildcodeschool.com.	34077	IN	NS	cash.ns.cloudflare.com.

# 4. Serveur primaire

```bash
dig SOA wildcodeschool.com
```

=>
wildcodeschool.com.	1800	IN	SOA	cash.ns.cloudflare.com. dns.cloudflare.com. 2357424175 10000 2400 604800 1800

# 5. Utilisation du serveur récursif 8.8.8.8

Ajout de `@9.9.9.9` sur chaque ligne avec le même résultat.