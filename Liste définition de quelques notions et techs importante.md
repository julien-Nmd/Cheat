### **Architecture matérielle et logicielle :** 

1. **Active Directory (AD) et Réplication d’AD** :
   Active Directory est un service de gestion des identités et des ressources dans un environnement Windows. La réplication d'AD permet de synchroniser les données entre les contrôleurs de domaine. Par exemple, si une entreprise a des contrôleurs de domaine dans plusieurs succursales, la réplication d'AD garantit que toutes les informations sur les utilisateurs, les groupes et les ressources sont cohérentes sur tous les contrôleurs de domaine. 
2. **Gestionnaire de stratégie de groupe** : 
   Cet outil permet de déployer des stratégies de configuration aux utilisateurs et aux ordinateurs dans un domaine Windows. Par exemple, une entreprise peut utiliser le Gestionnaire de stratégie de groupe pour imposer des paramètres de sécurité, des politiques de mot de passe ou des configurations spécifiques à un groupe d'utilisateurs. 
3. **Serveur de fichiers (Windows ou UNIX)** : 
   Un serveur de fichiers stocke et partage des fichiers avec d'autres utilisateurs sur un réseau. Par exemple, dans un environnement Windows, un serveur de fichiers peut être utilisé pour partager des documents, des images et d'autres fichiers entre les employés. 
4. **Serveur WEB** : 
   Un serveur web répond aux demandes HTTP des clients (navigateurs web) en fournissant des pages web, des applications web, etc. Par exemple, un site web d'une entreprise est hébergé sur un serveur web qui répond aux demandes des visiteurs en affichant les pages du site. 
5. **Windows WDS (Windows Deployment Services)** : 
   Windows Deployment Services est utilisé pour le déploiement automatisé des images système sur le réseau. Par exemple, lorsqu'une entreprise doit mettre à jour ou réinstaller le système d'exploitation sur de nombreux ordinateurs, WDS permet de le faire efficacement en utilisant des images pré-configurées.
6. **Hyperviseur de virtualisation : Hyper-V** : 
   Hyper-V permet de créer et de gérer des machines virtuelles sur des serveurs physiques. Par exemple, une entreprise peut utiliser Hyper-V pour consolider plusieurs serveurs virtuels sur un seul serveur physique, ce qui réduit les coûts matériels et améliore la flexibilité de l'infrastructure informatique. 
7. **Hyperviseur de virtualisation : VMWare ESXi et vSphere client** : 
   VMWare ESXi est un autre hyperviseur populaire, et vSphere client est l'interface de gestion associée. Par exemple, vSphere permet de provisionner, surveiller et gérer des machines virtuelles sur des serveurs ESXi. 
8. **Technologie de basculement : Création d’un SAN iSCSI, Cluster de basculement** : 
   La technologie de basculement garantit la disponibilité des services en basculant automatiquement vers un serveur de secours en cas de panne. Par exemple, dans un cluster de basculement, si un serveur tombe en panne, un autre prend le relais pour assurer la continuité des opérations. La création d'un SAN iSCSI permet de stocker des données partagées de manière centralisée, accessible par plusieurs serveurs. 
9. **Technologie de répartition de charge : Cluster d'équilibrage de la charge réseau (NBL)** : 
   Cette technologie permet de répartir la charge du trafic réseau entre plusieurs serveurs pour améliorer les performances et la disponibilité. Par exemple, un cluster de serveurs web peut répartir équitablement le trafic entrant entre ses membres, évitant ainsi la surcharge d'un seul serveur. 
10. **WSUS : distribution de mise à jour automatique** : 
    WSUS permet de gérer la distribution des mises à jour logicielles aux ordinateurs clients dans un réseau. Par exemple, un administrateur peut utiliser WSUS pour contrôler quand et comment les mises à jour sont déployées sur les ordinateurs de l'entreprise, ce qui contribue à maintenir la sécurité et la cohérence des systèmes. 
11. **Système de fichiers distribué (DFS)** : 
    DFS permet de créer des espaces de noms et de répartir des données sur plusieurs serveurs pour une meilleure disponibilité et une gestion simplifiée. Par exemple, une organisation peut utiliser DFS pour permettre aux utilisateurs d'accéder à des fichiers partagés via un chemin d'accès unique, même si ces fichiers sont physiquement stockés sur plusieurs serveurs. 
12. **Rôles Remote Desktop Services** : 
    Terminal Server, Remote APP, Broker et passerelle : Ces rôles permettent d'accéder à des applications ou des bureaux à distance, de gérer les connexions des utilisateurs et de sécuriser l'accès depuis l'extérieur. Par exemple, un Terminal Server permet aux utilisateurs distants d'accéder à un bureau Windows complet, tandis que Remote App permet d'exécuter des applications Windows à distance. 
13. **Clonage et réplication** : 
    Ces techniques permettent de dupliquer des machines virtuelles ou des données pour la sauvegarde, la reprise après sinistre ou la mise en place de scénarios de haute disponibilité. Par exemple, un administrateur peut cloner une machine virtuelle pour créer une copie exacte à des fins de test ou de sauvegarde. 

### **Sécurité et Cybersécurité :** 

14. **SSL (Secure Socket Layer)** : 
    SSL est un protocole de sécurité utilisé pour établir une connexion sécurisée entre un navigateur web et un serveur. Par exemple, lorsque vous effectuez des achats en ligne, SSL chiffre les informations sensibles telles que les numéros de carte de crédit pour éviter les interceptions malveillantes. 
15. **VPN (Virtual Private Network)** : 
    Un VPN crée une connexion sécurisée entre un utilisateur ou un réseau distant et un réseau privé via une connexion chiffrée. Par exemple, les employés peuvent utiliser un VPN pour accéder en toute sécurité aux ressources de l'entreprise depuis l'extérieur du bureau. 
16. **Firewall (Pare-feu)** : 
    Un pare-feu contrôle le trafic réseau en autorisant ou en bloquant les flux de données selon des règles définies. Par exemple, un pare-feu peut bloquer les tentatives d'accès non autorisées à un réseau. 
17. **Cryptage à clé publique (asymétrique)** : 
    Le cryptage à clé publique utilise une paire de clés, une clé publique pour chiffrer et une clé privée correspondante pour déchiffrer. Par exemple, l'utilisation de cryptage à clé publique est essentielle pour sécuriser les communications en ligne, y compris les transactions bancaires en ligne. 

### **Technologies systèmes sur Windows Server :** 

18. **DNS (Domain Name System)** : 
    Le DNS est un service essentiel qui traduit les noms de domaine en adresses IP, permettant ainsi aux utilisateurs d'accéder aux ressources par leur nom convivial. Par exemple, lorsqu'un utilisateur saisit "www.example.com" dans son navigateur, le DNS traduit cela en l'adresse IP du serveur web correspondant. 
19. **DHCP (Dynamic Host Configuration Protocol)** : 
    DHCP est un protocole qui permet l'attribution automatique des adresses IP aux périphériques sur un réseau. Par exemple, lorsqu'un ordinateur se connecte à un réseau, un serveur DHCP lui attribue automatiquement une adresse IP, ce qui simplifie la gestion des adresses IP. 
20. **Agent Relais DHCP + Routeur virtuel** : 
    L'agent relais DHCP permet aux sous-réseaux distants de recevoir des configurations DHCP à partir d'un serveur DHCP central. Un routeur virtuel peut être utilisé pour acheminer le trafic entre différents sous-réseaux. Par exemple, dans un réseau étendu, un agent relais DHCP permet aux clients d'obtenir une adresse IP du serveur DHCP central, même s'ils se trouvent dans un sous-réseau distant. 

### **Technologies réseaux :**

21. **Ethernet** : 
    La technologie Ethernet est largement utilisée pour la mise en réseau des périphériques informatiques en utilisant des câbles et des commutateurs. Par exemple, Ethernet est couramment utilisé pour connecter des ordinateurs, des imprimantes et d'autres périphériques à un réseau local. 
22. **IP (Internet Protocol)** : 
    IP est le protocole de base qui permet d'acheminer des données sur Internet en utilisant des adresses IP. Par exemple, lorsque vous naviguez sur Internet, les données sont divisées en paquets IP qui sont acheminés de serveur en serveur jusqu'à leur destination. 
23. **Adresse IP privée** : 
    Les adresses IP privées sont utilisées à l'intérieur d'un réseau local pour identifier les périphériques de manière unique. Par exemple, les adresses IP privées sont souvent utilisées dans les réseaux domestiques et d'entreprise pour identifier les ordinateurs, les imprimantes, etc. 
24. **Adresse IP publique** : 
    Une adresse IP publique est attribuée à un périphérique ou à un réseau et est utilisée pour communiquer sur Internet. Par exemple, un site web accessible depuis Internet est associé à une adresse IP publique. 
25. **LAN (Local Area Network)** : 
    Un LAN est un réseau local qui connecte des périphériques au sein d'une zone géographique limitée, comme un bureau ou une maison. Par exemple, un réseau domestique est généralement un LAN. 
26. **MAN (Metropolitan Area Network)** : 
    Un MAN est un réseau métropolitain qui couvre une zone géographique plus grande, comme une ville ou une région métropolitaine. Par exemple, un MAN peut être utilisé pour interconnecter plusieurs campus universitaires dans une ville. 
27. **WAN (Wide Area Network)** : 
    Un WAN est un réseau étendu qui peut couvrir de vastes régions géographiques, voire le monde entier. Par exemple, Internet est un exemple de WAN qui connecte des réseaux du monde entier. 
28. **IPP (Internet Printing Protocol)** : 
    L'IPP est un protocole qui permet d'imprimer des documents sur des imprimantes réseau via Internet. Par exemple, un utilisateur peut envoyer une tâche d'impression à une imprimante distante en utilisant l'IPP. 
29. **IRC (Internet Relay Chat)** : 
    IRC est un protocole de communication en temps réel qui permet la discussion en ligne entre utilisateurs. Par exemple, les salons de discussion IRC ont été populaires pour les discussions en ligne en temps réel avant l'avènement des médias sociaux. 
30. **RDP (Remote Desktop Protocol)** : 
    Le RDP est un protocole qui permet d'accéder à distance à un bureau Windows. Par exemple, un administrateur système peut utiliser RDP pour se connecter à un serveur à distance et effectuer des tâches de gestion. 
31. **HTTP (HyperText Transfer Protocol)** : 
    HTTP est un protocole utilisé pour transférer des données sur le World Wide Web. Par exemple, lorsque vous accédez à un site web, votre navigateur utilise le protocole HTTP pour récupérer les pages du site. 
32. **HTTPS (HyperText Transfer Protocol Secure)** : 
    HTTPS est une version sécurisée de HTTP qui utilise le cryptage SSL/TLS pour sécuriser les communications en ligne. Par exemple, les sites web de commerce électronique utilisent HTTPS pour protéger les informations sensibles des utilisateurs. 
33. **FTP (File Transfer Protocol)** : 
    FTP est un protocole utilisé pour transférer des fichiers entre un client et un serveur. Par exemple, les administrateurs système peuvent utiliser FTP pour télécharger des fichiers sur un serveur distant. 
34. **SFTP (Secure File Transfer Protocol)** : 
    SFTP est une version sécurisée de FTP qui utilise le cryptage pour sécuriser les transferts de fichiers. Par exemple, les entreprises utilisent SFTP pour transférer des fichiers sensibles de manière sécurisée. 
35. **TFTP (Trivial File Transfer Protocol)** : 
    TFTP est un protocole simple de transfert de fichiers utilisé pour le démarrage et la mise à jour de logiciels sur les périphériques réseau. Par exemple, TFTP est souvent utilisé pour charger le firmware sur des routeurs et des commutateurs. 
36. **SIP (Session Initiation Protocol)** : 
    SIP est un protocole de communication utilisé pour établir, modifier et résilier des sessions de communication multimédia, notamment la voix sur IP (VoIP). Par exemple, les appels téléphoniques sur Internet sont souvent acheminés à l'aide du protocole SIP. 
37. **SDP (Session Description Protocol)** : 
    SDP est un protocole utilisé pour décrire les paramètres d'une session multimédia, notamment lors de l'établissement de communications VoIP. Par exemple, SDP indique les codecs audio utilisés lors d'un appel VoIP. 
38. **UDP (User Datagram Protocol)** : 
    UDP est un protocole de transport qui permet la transmission de données sans connexion, adapté aux applications nécessitant une latence minimale. Par exemple, les flux vidéo en direct utilisent souvent UDP pour minimiser la latence. 
39. **TCP (Transmission Control Protocol)** : 
    TCP est un protocole de transport fiable utilisé pour établir des connexions de données fiables entre les périphériques. Par exemple, la plupart des transferts de données sur Internet utilisent TCP pour garantir que les données arrivent correctement. 
40. **POP (Post Office Protocol)** : 
    POP est un protocole utilisé pour récupérer les courriers électroniques depuis un serveur de messagerie. Par exemple, lorsque vous configurez un client de messagerie pour récupérer vos e-mails, vous pouvez choisir entre POP et IMAP. 
41. **IMAP (Internet Message Access Protocol)** : 
    IMAP est un protocole de messagerie électronique utilisé pour accéder et gérer les messages stockés sur un serveur de messagerie. Par exemple, IMAP permet aux utilisateurs de consulter leur boîte de réception à partir de plusieurs appareils tout en maintenant la synchronisation des messages. 
42. **SMTP (Simple Mail Transfer Protocol)** :
    SMTP est un protocole de messagerie électronique utilisé pour l'envoi de courriers électroniques. Par exemple, lorsque vous envoyez un e-mail, le serveur SMTP est utilisé pour transférer le message à son destinataire. 
43. **Telnet** : 
    Telnet est un protocole qui permet d'accéder à distance à un ordinateur ou à un serveur via une interface de ligne de commande. Par exemple, les administrateurs système utilisent Telnet pour se connecter à des serveurs à distance pour la gestion et la configuration. 
44. **ICMP (Internet Control Message Protocol)** : 
    ICMP est un protocole de contrôle et de gestion des erreurs utilisé pour les communications réseau, notamment pour le ping. Par exemple, lorsque vous effectuez un "ping" vers un autre ordinateur, ICMP est utilisé pour envoyer et recevoir des réponses. 
45. **ARP (Address Resolution Protocol)** : 
    ARP est un protocole utilisé pour résoudre les adresses IP en adresses MAC dans les réseaux locaux. Par exemple, ARP est utilisé pour découvrir l'adresse MAC correspondant à une adresse IP donnée sur le réseau local. 
46. **IEEE 802.1p (QoS - Quality of Service)** : 
    IEEE 802.1p est une norme qui définit la qualité de service (QoS) pour le trafic réseau afin de garantir des performances adéquates pour certaines applications. Par exemple, dans un réseau, les paquets de voix IP peuvent être marqués avec une priorité plus élevée pour assurer une qualité audio optimale. 
47. **IEEE 802.1Q VLAN (Virtual Local Area Network)** : 
    IEEE 802.1Q est une norme qui permet la création de réseaux virtuels distincts sur un réseau physique commun. Par exemple, une entreprise peut créer des VLAN pour isoler le trafic entre différents groupes d'utilisateurs ou de périphériques. 
48. **Mode access sur le switch** : 
    Le mode access sur un commutateur réseau permet à un port d'être connecté à un seul VLAN. Par exemple, un port en mode access est utilisé pour connecter un appareil à un seul réseau VLAN spécifique. 
49. **Mode trunk sur le switch** : 
    Le mode trunk sur un commutateur réseau permet à un port de prendre en charge plusieurs VLAN pour le trafic de données. Par exemple, un port en mode trunk est utilisé pour transporter le trafic de plusieurs VLAN sur un seul câble. 
50. **Encapsulation** : 
    L'encapsulation est le processus d'ajout d'en-têtes et de pieds de données pour le transport de données sur un réseau. Par exemple, lors de l'envoi de données sur Internet, les données sont encapsulées dans des paquets IP qui contiennent des en-têtes et des informations de routage. 
51. **Routage inter-VLAN** : 
    Le routage inter-VLAN permet aux VLAN de communiquer entre eux via un routeur. Par exemple, si deux groupes d'utilisateurs sont sur des VLAN différents, le routage inter-VLAN permet aux utilisateurs de ces VLAN de se communiquer entre eux. 
52. **GVRP (GARP VLAN Registration Protocol)** : 
    GVRP est un protocole qui permet l'enregistrement automatique des VLAN sur des commutateurs Ethernet. Par exemple, lorsque de nouveaux VLAN sont créés ou supprimés, GVRP met à jour automatiquement les commutateurs Ethernet pour refléter ces changements. 
53. **VTP (VLAN Trunking Protocol)** : 
    VTP est un protocole qui permet la configuration centralisée des VLAN sur plusieurs commutateurs. Par exemple, au lieu de configurer manuellement chaque commutateur avec les mêmes VLAN, VTP permet de propager automatiquement les changements de VLAN à tous les commutateurs. 
54. **IEEE 802.11 (Wi-Fi)** : 
    IEEE 802.11 est une norme qui définit les protocoles de communication sans fil, couramment utilisés pour le Wi-Fi. Par exemple, les routeurs Wi-Fi utilisent la norme 802.11 pour permettre aux appareils sans fil de se connecter au réseau. 
55. **IEEE 802.15** : 
    IEEE 802.15 est une norme qui définit les réseaux personnels sans fil, notamment Bluetooth. Par exemple, les dispositifs Bluetooth, tels que les écouteurs sans fil, utilisent la norme 802.15 pour communiquer les uns avec les autres. 
56. **RADIUS (Remote Authentication Dial-In User Service)** : 
    RADIUS est un protocole d'authentification et d'autorisation utilisé pour gérer l'accès aux réseaux. Par exemple, un serveur RADIUS peut être utilisé pour authentifier les utilisateurs qui se connectent à un réseau sans fil sécurisé. 
57. **Routage** : 
    Le routage est le processus de transmission de paquets de données d'un réseau à un autre, généralement géré par des routeurs. Par exemple, lorsque vous accédez à un site web, les paquets de données sont routés à travers plusieurs routeurs sur Internet pour atteindre le serveur web. 
58. **RIP (Routing Information Protocol)** : 
    RIP est un protocole de routage qui utilise des métriques simples pour déterminer le chemin optimal pour acheminer les données. Par exemple, RIP peut être utilisé pour déterminer le meilleur chemin pour acheminer le trafic sur un réseau IP. 
59. **OSPF (Open Shortest Path First)** : 
    OSPF est un protocole de routage à état de lien utilisé pour déterminer le chemin optimal pour acheminer les données dans un réseau IP. Par exemple, OSPF est couramment utilisé dans les réseaux d'entreprise pour garantir une connectivité efficace. 
60. ** EIGRP (Enhanced Interior Gateway Routing Protocol)** : 
    EIGRP est un protocole de routage amélioré utilisé pour déterminer les chemins de routage optimaux dans un réseau IP. Par exemple, EIGRP utilise des métriques plus avancées que RIP pour prendre des décisions de routage. 
61. **HSRP (Hot Standby Router Protocol)** : 
    HSRP est un protocole de redondance de routeur qui permet à un routeur de prendre automatiquement le relais en cas de panne d'un routeur principal. Par exemple, HSRP est utilisé pour garantir la disponibilité des services critiques en cas de panne d'un routeur. 
62. **VRRP (Virtual Router Redundancy Protocol)** : 
    VRRP est un protocole de redondance de routeur qui permet à plusieurs routeurs de travailler ensemble pour assurer la disponibilité des services. Par exemple, VRRP est utilisé dans les réseaux d'entreprise pour fournir une redondance au niveau du routeur. 
63. **GLBP (Gateway Load Balancing Protocol)** : 
    GLBP est un protocole de routage qui permet de répartir la charge entre plusieurs routeurs pour améliorer les performances et la disponibilité. Par exemple, GLBP répartit le trafic entre plusieurs routeurs, assurant ainsi une utilisation équilibrée des ressources. 
64. **IGRP (Interior Gateway Routing Protocol)** : 
    IGRP est un protocole de routage intérieur utilisé pour déterminer les chemins de routage optimaux dans un réseau IP. Par exemple, IGRP utilise des métriques spécifiques pour évaluer la qualité des chemins de routage. 
65. **Routage statique** : 
    Le routage statique consiste à configurer manuellement les chemins de routage dans un réseau. Par exemple, un administrateur réseau peut configurer manuellement les routes pour diriger le trafic vers des destinations spécifiques. 
66. **Routage dynamique** : 
    Le routage dynamique consiste à utiliser des protocoles de routage pour déterminer automatiquement les chemins de routage dans un réseau. Par exemple, les protocoles de routage comme OSPF et EIGRP ajustent automatiquement les chemins de routage en fonction des changements dans le réseau. 
67. **Commutateur niveau 2** : 
    Un commutateur de niveau 2 fonctionne au niveau de la couche de liaison de données et prend des décisions de transfert en fonction des adresses MAC. Par exemple, un commutateur de niveau 2 est capable de diriger le trafic en fonction des adresses MAC des périphériques connectés. 
68. **Commutateur niveau 3** : 
    Un commutateur de niveau 3 fonctionne au niveau de la couche réseau et peut prendre des décisions de routage en fonction des adresses IP. Par exemple, un commutateur de niveau 3 peut effectuer des opérations de routage et de commutation en même temps. 
69. **NAT (Network Address Translation)** : 
    NAT est une technique qui permet de mapper plusieurs adresses IP privées à une seule adresse IP publique pour accéder à Internet. Par exemple, un routeur NAT attribue des adresses IP privées aux appareils dans un réseau domestique et utilise une seule adresse IP publique pour communiquer avec Internet. 
70. **PAT (Port Address Translation)** : 
    PAT est une forme de NAT qui attribue des ports uniques à chaque connexion privée pour permettre à plusieurs périphériques d'utiliser une seule adresse IP publique. Par exemple, avec PAT, plusieurs ordinateurs dans un réseau domestique peuvent accéder à Internet en utilisant une seule adresse IP publique en utilisant des ports différents. 
71. **LDAP (Lightweight Directory Access Protocol)** : 
    LDAP est un protocole de gestion d'annuaire utilisé pour accéder et gérer des informations d'annuaire, telles que les informations d'authentification des utilisateurs. Par exemple, LDAP est utilisé pour gérer les comptes d'utilisateurs et les annuaires d'entreprise. 
72. **ACL (Access Control List)** : 
    Une ACL est une liste de règles qui définissent les autorisations et les interdictions de trafic réseau en fonction des adresses IP, des ports, etc. Par exemple, une ACL peut être configurée pour autoriser ou bloquer certains types de trafic réseau. 
73. **IEEE 802.1D (STP - Spanning Tree Protocol)** : 
    IEEE 802.1D est un protocole qui permet d'éviter les boucles de commutation en désactivant certains ports sur les commutateurs. Par exemple, STP est utilisé pour empêcher les boucles de commutation qui pourraient causer des problèmes de performance dans un réseau. 
74. **IEEE 802.1X (Authentication)** : 
    IEEE 802.1X est un protocole d'authentification utilisé pour contrôler l'accès aux réseaux en fonction des identifiants d'utilisateur. Par exemple, 802.1X est utilisé pour exiger une authentification avant qu'un utilisateur puisse se connecter à un réseau sans fil sécurisé. 
75. **IEEE 802.3ad (Agrégation de lien)** : 
    IEEE 802.3ad est une norme qui permet d'agréger plusieurs liens réseau pour augmenter la bande passante et la redondance. Par exemple, l'agrégation de liens est utilisée pour combiner plusieurs connexions Ethernet en une seule connexion plus rapide et plus fiable. 
76. **SNMP (Simple Network Management Protocol)** : 
    SNMP est un protocole utilisé pour la supervision et la gestion des équipements réseau, permettant de surveiller les performances et de recueillir des informations sur les dispositifs. Par exemple, les administrateurs réseau utilisent SNMP pour obtenir des informations sur l'état des routeurs, commutateurs et serveurs. 
77. **Proxy** : 
    Un serveur proxy agit en tant qu'intermédiaire entre les utilisateurs et les serveurs Internet, offrant des avantages tels que la sécurité, la mise en cache et le filtrage du trafic. Par exemple, un proxy peut être utilisé pour surveiller et contrôler l'accès à Internet dans un réseau d'entreprise. 
78. **Firewall** : 
    Un pare-feu est un dispositif ou un logiciel qui surveille et contrôle le trafic réseau entrant et sortant pour protéger un réseau contre les menaces de sécurité. Par exemple, un pare-feu peut bloquer le trafic malveillant et autoriser uniquement le trafic légitime. 
79. **VPN (Virtual Private Network)** : 
    Un VPN permet de créer une connexion sécurisée entre un utilisateur ou un réseau distant et un réseau privé via Internet. Par exemple, un VPN est utilisé pour sécuriser les communications entre les employés travaillant à distance et le réseau d'entreprise. 
80. **DMZ (Zone démilitarisée)** : 
    Une DMZ est une zone de réseau située entre le réseau interne sécurisé et Internet, où sont placés des serveurs accessibles depuis Internet, mais isolés du réseau interne. Par exemple, un serveur web public peut être placé dans la DMZ pour permettre l'accès depuis Internet tout en protégeant le réseau interne. 
81. **Load Balancer** : 
    Un répartiteur de charge est un dispositif ou un logiciel qui répartit le trafic réseau entre plusieurs serveurs pour améliorer les performances et la disponibilité. Par exemple, un répartiteur de charge peut distribuer le trafic web entre plusieurs serveurs web pour éviter la surcharge. 
82. **Serveur DHCP** : 
    Un serveur DHCP attribue automatiquement des adresses IP aux périphériques sur un réseau, simplifiant ainsi la gestion des adresses IP. Par exemple, un serveur DHCP peut attribuer des adresses IP à tous les ordinateurs d'un réseau local. 
83. **Serveur DNS** : 
    Un serveur DNS traduit les noms de domaine en adresses IP, permettant ainsi aux utilisateurs d'accéder aux ressources par leur nom convivial. Par exemple, lorsque vous saisissez l'adresse d'un site web dans votre navigateur, un serveur DNS traduit le nom de domaine en adresse IP. 
84. **Serveur Web** : 
    Un serveur web héberge des sites web et répond aux demandes des clients web en fournissant des pages web et des ressources. Par exemple, les sites web sont hébergés sur des serveurs web tels qu'Apache, Nginx ou Microsoft IIS. 
85. **Serveur FTP** : 
    Un serveur FTP permet le transfert de fichiers entre un client et un serveur via le protocole FTP. Par exemple, un serveur FTP est utilisé pour télécharger des fichiers depuis un site web ou pour partager des fichiers entre utilisateurs. 
86. **Serveur de messagerie** : 
    Un serveur de messagerie gère la réception, la transmission et le stockage des e-mails. Par exemple, Microsoft Exchange Server est un serveur de messagerie couramment utilisé dans les entreprises. 
87. **Serveur de fichiers** : 
    Un serveur de fichiers permet le stockage et le partage de fichiers sur un réseau. Par exemple, un serveur de fichiers peut être utilisé pour stocker des documents partagés dans une entreprise. 
88. **Serveur de base de données** : 
    Un serveur de base de données stocke, gère et permet l'accès aux données de manière structurée. Par exemple, un serveur de base de données peut être utilisé pour stocker les informations des clients d'une entreprise. 
89. **Serveur de sauvegarde** : 
    Un serveur de sauvegarde est utilisé pour effectuer des sauvegardes régulières des données importantes d'un réseau. Par exemple, un serveur de sauvegarde peut sauvegarder les fichiers critiques d'une entreprise pour la récupération en cas de perte de données. 
90. **Serveur proxy** : 
    Un serveur proxy agit en tant qu'intermédiaire entre les clients et les serveurs, permettant de contrôler et de filtrer le trafic. Par exemple, un serveur proxy peut être configuré pour bloquer l'accès à certains sites web depuis un réseau d'entreprise. 
91. **Serveur de sauvegarde distant** : 
    Un serveur de sauvegarde distant est un serveur situé hors site qui stocke des copies de sauvegarde des données importantes, offrant une protection contre la perte de données en cas de sinistre. Par exemple, un serveur de sauvegarde distant peut être situé dans un centre de données distant. 
92. **Répéteur** : 
    Un répéteur est un dispositif réseau utilisé pour étendre la portée d'un réseau sans fil en répétant les signaux Wi-Fi. Par exemple, un répéteur Wi-Fi est utilisé pour étendre la couverture Wi-Fi dans une grande maison ou un bureau. 
93. **Hub réseau** : 
    Un hub est un dispositif réseau qui connecte plusieurs périphériques réseau, mais il agit comme un concentrateur passif qui diffuse des données à tous les périphériques connectés sans intelligence de commutation. Les hubs ont été largement remplacés par les commutateurs pour améliorer les performances des réseaux.