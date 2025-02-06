HackMeIfYouCan

J'ai grave galéré au début, j'étais perdu, je ne savais pas par quoi commencer. J'ai commencé à revoir tout ce qu'on avait vu en cours, et j'ai commencé mes consoles.
Au final, j'y ai vu plus clair, j'ai vu que l'adresse sur laquelle je tapais pour voir mes résultats (marks, floor, etc.) n'était pas la bonne, donc j'avais toujours 0. Et dès que j'ai changé, là j'avais 3 points, et ça m'a motivé à faire la suite, etc. Sinon, j'en pouvais plus LOL. Le stress de l'exam u joue aussi..
Merci à toi entout cas pour ton aide et ta réactivité pour nos questions et nos erreurs.

PASSWORD :
Password est private, mais il reste tout de même visible sur le storage.
Donc, on va chercher directement sa position où il est stocké.
Pour le password, lorsque l'on voit les variables du contrat, on voit que password est la 4ᵉ variable.
On sait qu'un slot fait 32 bytes, donc le password est dans le slot 3.
On utilise vm.load pour aller chercher la valeur du slot 3.
Enfin, on peut passer la valeur du slot 3 en bytes32.

KEY :
Pour key c'est le meme principe que password, hors la ce n'est pas un uint comme password mais un array. 
On sait aussi que le debut du array de key est au slot 4.
Donc la premiere case du tableau "[0]" vas etre le slot4. Au début j'avais du mal à comprendre cette notion sachant que le matin on avait vu les array dynamique et sa m'a embrouiller. Au final j'ai compris que c'etait des array static "MERCI SID AHMED :)"
Donc ce qui fait que le slot 4 est la premiere case du tableau et pour la key on demander la case 12. Donc j'ai fais 12+4 ce qui ma donner les position exact du slot. Et j'ai pu récupérer la variable avec le vm.load et mis la valeur dans la fonction mais en bytes16 par contre.

TRANSFER :
Pour le tranfer, il faut envoyer à partir d'une address vers un autre. J'ai pris directement balance de d'address(0) quiest de  0, et pour rentrer dans cette fonction il faut envoyer des token et etre supérieur à 0. Sauf qu'avait le underflow si j'essaye d'envoyer 10 tokens sachant que j'en est 0 sa aurait fait 0-10. Mais la balance ne peux pas etre négatif. Donc sa donne une grande valeur

FALLBACK :
La fonction receive du contrat exige d'etre contributeur et que la value soit supérieur à 0. Donc ce que j'ai fais, j'ai commencer par devenir contributeur en appelant la fonction contrubute et déposer des ethers.
Puis je fait appeler la fonction de payable pour pouvoir déclencher la fonction receive. Etant donner que les conditions sont ok (contributeur et value supérieur à 0) alors je rentre dedans.

FLIP :
Pour flip il suffisait de donner le bon gess des le début. Mais impossible de le savoir car c'était un calcule aléatoir qui dépendais du block précédent. Ce que j'ai fais c'est comme il y as tous qui nous indique comment est calculer calculer l'aléatoire de la flipValue j'ai fais un contrat qui à le meme calcule. donc ce que je fait c'est que je predict la valeur avant pour pouvoir rentrer directement la bonne valeur
