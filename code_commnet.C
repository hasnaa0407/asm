#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

// ON A penser a trouver une relation entre les nbr donnee
int ligne(int n)
{
    if (n > 50 || n < 1)
    {
        return 0;
    }
    else
    {

        if (n % 5 == 0)
        {
            return n / 5;
        }
        else
        {
            return n / 5 + 1;
        }
    }
}

int colonne(int n)
{
    if (n > 50 || n < 1)
    {
        return 0;
    }
    else
    {
        if (n % 10 == 0)
        {
            return 9;
        }
        else
        {
            if (n % 10 > 5)
            {
                return (n % 10 - 5) * 2 - 1;
            }
            else
            {
                return 2 * (n % 10);
            }
        }
    }
}

int numerocase(int i, int j)
{
    if (i > 10 || i < 1 || j > 10 || j < 1)
    {
        return 51;
    }
    else
    {

        if (i % 2 == 1 && j % 2 == 0)
        {

            return j / 2 + 10 * (i - 1) / 2;
        }
        else
        {
            if (j % 2 == 1 && i % 2 == 0)
            {
                return (j + 1) / 2 + 5 + 10 * (i - 2) / 2;
            }
            else
                return 0;
        }
    }
}

bool verifcasedepart(int i, int j, int tour, int damier[50])
{ // if tour blanc==-1  //noir==1
    if (numerocase(i, j) == 0)
    {
        return false; // case de depart ghlta entrez a nouveau
    }
    int a, b, c, d;
    if (tour == 1)
    {
        a = 2; // case de l adverssaire
        b = 4;
        c = 1;
        d = 3; // la dame
    }
    if (tour == -1)
    {
        a = 1;
        b = 3;
        c = 2;
        d = 4;
    }

    if ((damier[numerocase(i, j) - 1] != c) && (damier[numerocase(i, j) - 1] != d))
    {
        return false;
    }

    if (
	damier[numerocase(i + tour, j + 1) - 1] == 5 ||//Cette condition vérifie si la case située à une position vers le bas et une position vers la droite est vide, c'est-à-dire si elle contient le caractère '5'.
	
	damier[numerocase(i + tour, j - 1) - 1] == 5 ||//Cette condition vérifie si la case située à une position vers le bas et une position vers la gauche est vide, c'est-à-dire si elle contient le caractère '5'.
	 
	  
	(damier[numerocase(i + tour, j - 1) - 1] == a || damier[numerocase(i + tour, j - 1) - 1] == b)
	&& 
	damier[numerocase(i + 2 * tour, j - 2) - 1] == 5 //Cette condition vérifie si la case située à une position vers le bas et une position vers la gauche contient soit une pièce de type 'a' ou 'b', et si la case située deux positions vers le bas et deux positions vers la gauche est vide
	
	||
	 
	(damier[numerocase(i + tour, j + 1) - 1] == a || damier[numerocase(i + tour, j + 1) - 1] == b) 
	&& 
	damier[numerocase(i + 2 * tour, j + 2) - 1] == 5//Cette condition vérifie si la case située à une position vers le bas et une position vers la droite contient soit une pièce de type 'a' ou 'b', et si la case située deux positions vers le bas et deux positions vers la droite est vide,
	   
	)
    {
        return true;
    }
    else{
    	
        if (damier[numerocase(i, j) ] == d){//Cette condition vérifie si la case actuelle contient un damier, c'est-à-dire si elle contient le caractère 'd'.
            if (
            
			(damier[numerocase(i - tour, j - 1) ] == a || damier[numerocase(i - tour, j - 1) ] == b)//1.1
			&&//-> 1.2
			damier[numerocase(i - 2 * tour, j - 2) ] == 5 //cette condition (1.1 && 1.2) vérifie si la case adjacente à gauche est occupée par une pièce de type 'a' ou 'b', et si la case deux positions vers le haut et deux positions vers la gauche est vide.
			
			||//->3
			
			(damier[numerocase(i - tour, j + 1) ] == a || damier[numerocase(i - tour, j + 1) ] == b)// ->2.1
			&&//-> 2.2
			damier[numerocase(i - 2 * tour, j + 2) ] == 5//cette condition (2.1 && 2.2) vérifie si la case adjacente à droite est occupée par une pièce de type 'a' ou 'b', et si la case deux positions vers le haut et deux positions vers la droite est vide.
			
			|| //-> 4
			
			damier[numerocase(i - tour, j + 1) ] == 5//Cette condition vérifie si la case adjacente à droite (à une position de ligne vers le haut et une position de colonne vers la droite par rapport à la position actuelle) est vide, c'est-à-dire si elle contient le caractère '5'.
			
			||//-> 5 
			
			damier[numerocase(i - tour, j - 1) - 1] == 5//Cette condition vérifie si la case adjacente à gauche (à une position de ligne vers le haut et une position de colonne vers la gauche par rapport à la position actuelle) est vide, c'est-à-dire si elle contient le caractère '5'.
			
			)
            {
                return true;
            }
        }

        return false;
    }

    return false;
}

bool verifcasearrivee(int i, int j, int x, int y, int tour, int damier[50], bool *eat, bool *verifwithchanges)
{ // avant d appeller cette fonction on utilise la fonction verif

    // case depart psq ken ydkhlhm ghltin n9ouloulou sur le coup
    if (numerocase(x, y) == 0)
    {
        *eat = false;
        return false;
    }

    if (damier[numerocase(x, y) - 1] != 5)
    {

        // la case d arrivee n est pas vide
        *eat = false;
        return false;
    }

    int avance;

    if (j < y)
    {
        avance = 1; // hedy t3 ida les colonne + wla -
    }
    if (j > y)
    {
        avance = -1;
    }

    int a, b, c, d;
    if (tour == 1)
    {
        a = 2; // case de l adverssaire
        b = 4;
        c = 1;
        d = 3; // represente la dame
    }
    if (tour == -1)
    {
        a = 1;
        b = 3;
        c = 2;
        d = 4;
    }

    // tour  et case de x,y vide
    // hna mzely nlmhoum hd 2;;;;;;;;;;;;;;;;;;;
    if (x == i + tour && y == j + avance)
    {
        if (*verifwithchanges == true)
        {
            damier[numerocase(x, y) - 1] = damier[numerocase(i, j) - 1];
            damier[numerocase(i, j) - 1] = 5;
            if (x == 10 || x == 1)
            {
                damier[numerocase(x, y) - 1] = d;
            }
        }
        *eat = false;
        return true;
    }

    if (x == i + 2 * tour && y == j + 2 * avance)
    {

        if (damier[numerocase(i + tour, j + avance) - 1] == a || damier[numerocase(i + tour, j + avance) - 1] == b)
        { // pion blanc ou dame blanche
            if (*verifwithchanges == true)
            {
                damier[numerocase(x, y) - 1] = damier[numerocase(i, j) - 1];
                damier[numerocase(i + tour, j + avance) - 1] = 5;
                damier[numerocase(i, j) - 1] = 5;
                if (x == 10 || x == 1)
                {
                    damier[numerocase(x, y) - 1] = d;
                }
            }
            *eat = true;
            return true;
        }
    }

    if (damier[numerocase(i, j) - 1] == d)
    { // si c une dame
        int avanceligne;
        if (i < x)
        {
            avanceligne = 1;
        }
        else
        {
            avanceligne = -1;
        }
        int nbrcaseadverssaire = 0;
        int l = i + avanceligne;
        int co = j + avance;
        int al = 0; // x et y t3 l adverssaire ida 9abelneh
        int ac = 0;
        while ((l != x || co != y) && co < 10 && l < 10 && co > 0 && l > 0)
        {

            if (damier[numerocase(l, co) - 1] == c || damier[numerocase(l, co) - 1] == d)
            {

                // keyn ly mnefs team
                *eat = false;
                return false;
            }

            if (damier[numerocase(l, co) - 1] == a || damier[numerocase(l, co) - 1] == b)
            {
                if (nbrcaseadverssaire == 0)
                {
                    al = l;
                    ac = co;
                    nbrcaseadverssaire++;
                }
                else
                {
                    *eat = false;
                    return false;
                }
            }
            l = l + avanceligne;

            co = co + avance;
        }

        if (l == x && co == y)
        {
            if (*verifwithchanges == true)
            {
                damier[numerocase(l, co) - 1] = damier[numerocase(i, j) - 1];
                damier[numerocase(i, j) - 1] = 5;
                if (x == 10 || x == 1)
                {
                    damier[numerocase(x, y) - 1] = d;
                }

                if (nbrcaseadverssaire != 0)
                {
                    damier[numerocase(al, ac) - 1] = 5;
                }
            }
            if (nbrcaseadverssaire == 0)
            {
                *eat = false;
            }
            else
            {
                *eat = true;
            }
            return true;
        }

        *eat = false;
        return false;
    }

    *eat = false;
    return false;
}

void initdamier(int damier[50])
{
    for (int i = 0; i < 20; i++)
    {
        damier[i] = 1; // pion noir
    }

    for (int i = 20; i < 30; i++)
    {
        damier[i] = 5; // vide
    }
    for (int i = 30; i < 50; i++)
    {
        damier[i] = 2; // pion blanc
    }
    damier[50] = 6;
}

void affichedamier(int damier[50])
{

    for (int i = 1; i <= 10; i++)
    {
        printf("%d ", i);
    }
    printf("\n\n\n");
    int l = 0;
    bool b = true;
    for (int i = 0; i < 10; i++)
    {
        printf("\n");
        if (b == true)
        {
            printf("  ");
            b = false;
        }
        else
        {
            b = true;
        }

        for (int j = 0; j < 5; j++)
        {
            printf("%d ", damier[l]);

            if (j != 4)
            {
                printf("  ");
            }
            else
            {
                if (b == true)
                {
                    printf("  ");
                }
            }

            l++;
        }
        printf("         %d", i + 1);
    }
}

int main()
{

    bool robot;
    int choix;
    printf("Combien de joueurs sont pr%csents ? (1 ou 2) :", 130);
    do
    {
        scanf("%d", &choix);
    } while (choix != 1 && choix != 2);
    if (choix == 1)
    {
        robot = true;
    }
    else
    {
        robot = false;
    }

    int damier[51];
    initdamier(damier);
    affichedamier(damier);
    int tour = 1;
    int nb_blanc = 20;
    int nb_noir = 20;
    while (nb_blanc != 0 && nb_noir != 0)
    {
        int x, y, i, j;
        bool eat, pion, dame;
        srand(time(NULL));
        if (tour == 1)
        {
            printf("\ntour de :%d", tour);
            do
            {
                printf("\ni:");
                scanf("%d", &i);
                printf("j:");
                scanf("%d", &j);
            } while (!verifcasedepart(i, j, tour, damier));
        }
        else
        {
            printf("\ntour de l'adversaire");
            if (robot)
            {
                do
                {
                    i = (rand() % 10) + 1;
                    j = (rand() % 10) + 1;
                } while (!verifcasedepart(i, j, tour, damier));
                printf("\ni:%d", i);
                printf("\nj:%d", j);
            }
            else
            {
                do
                {
                    printf("\ni:");
                    scanf("%d", &i);
                    printf("j:");
                    scanf("%d", &j);
                } while (!verifcasedepart(i, j, tour, damier));
            }
        }

        if (damier[numerocase(i, j) - 1] == 1 || damier[numerocase(i, j) - 1] == 2)
        {

            pion = true;
            dame = false;
        }
        else
        {
            pion = false;
            dame = true;
        }

        bool casearrivee;
        do
        {
            bool verifwithchanges = true;
            if (tour == 1)
            {
                printf("x:");
                scanf("%d", &x);
                printf("y:");
                scanf("%d", &y);
                casearrivee = verifcasearrivee(i, j, x, y, tour, damier, &eat, &verifwithchanges);
            }
            else
            {
                if (robot)
                {
                    x = (rand() % 10) + 1;
                    y = (rand() % 10) + 1;
                    casearrivee = verifcasearrivee(i, j, x, y, tour, damier, &eat, &verifwithchanges);
                    if (casearrivee)
                    {
                        printf("\nx:%d", x);
                        printf("\ny:%d\n", y);
                    }
                }
                else
                {
                    printf("x:");
                    scanf("%d", &x);
                    printf("y:");
                    scanf("%d", &y);
                    casearrivee = verifcasearrivee(i, j, x, y, tour, damier, &eat, &verifwithchanges);
                }
            }

            while (eat == true)
            {
                i = x;
                j = y;
                if (tour == 1)
                {
                    nb_blanc = nb_blanc - 1;
                }
                else
                {
                    nb_noir = nb_noir - 1;
                }

                verifwithchanges = false;
                if (pion)
                {
                    if (verifcasearrivee(i, j, i + 2 * tour, j + 2, tour, damier, &eat, &verifwithchanges) || verifcasearrivee(i, j, i + 2 * tour, j - 2, tour, damier, &eat, &verifwithchanges))
                    {
                        printf("vous devez manger a nouveau vous avez comme depart i=%d et j=%d\n", i, j);
                        if (tour == 1)
                        {
                            do
                            {
                                printf("x:");
                                scanf("%d", &x);
                                printf("y:");
                                scanf("%d", &y);
                                verifcasearrivee(i, j, x, y, tour, damier, &eat, &verifwithchanges);
                                ;
                            } while (!eat);
                        }
                        else
                        {
                            if (robot)
                            {
                                do
                                {
                                    x = (rand() % 10) + 1;
                                    y = (rand() % 10) + 1;
                                    verifcasearrivee(i, j, x, y, tour, damier, &eat, &verifwithchanges);
                                    ;
                                } while (!eat);
                                printf("x:%d\n", x);
                                printf("y:%d\n", y);
                            }
                            else
                            {
                                do
                                {
                                    printf("x:");
                                    scanf("%d", &x);
                                    printf("y:");
                                    scanf("%d", &y);
                                    verifcasearrivee(i, j, x, y, tour, damier, &eat, &verifwithchanges);
                                    ;
                                } while (!eat);
                            }
                        }

                        verifwithchanges = true;
                        verifcasearrivee(i, j, x, y, tour, damier, &eat, &verifwithchanges);
                        ;
                    }
                    else
                    {
                        eat = false;
                    }
                }

                // mzel t3 les dames lzm on verifie ida 3ndou mkla f la diagonale
                // on doit verifier soit dans la 1ere diagonale soit dans la deuxieme
                // gnr si l une des verif(x,y,x+n*tour,y+n*tour)
                if (dame)
                { // si dame

                    verifwithchanges = false;
                    bool trouvee = false;

                    int n = 2;

                    while (!trouvee && x + n <= 10 && y + n <= 10 && x + n > 0 && y + n > 0)
                    {

                        verifcasearrivee(x, y, x + n, y + n, tour, damier, &eat, &verifwithchanges);
                        trouvee = eat;
                        n++; // besh nvirifyi toute la diagonale rny ghlta
                    }

                    n = 2;

                    while (!trouvee && x - n <= 10 && y - n <= 10 && x - n > 0 && y - n > 0)
                    {

                        verifcasearrivee(x, y, x - n, y - n, tour, damier, &eat, &verifwithchanges);
                        trouvee = eat;
                        n++; // besh nvirifyi toute la diagonale rny ghlta
                    }

                    n = 2;

                    while (!trouvee && x + n <= 10 && y - n <= 10 && x + n > 0 && y - n > 0)
                    {

                        verifcasearrivee(x, y, x + n, y - n, tour, damier, &eat, &verifwithchanges);
                        trouvee = eat;
                        n++; // besh nvirifyi toute la diagonale rny ghlta
                    }

                    n = 2;

                    while (!trouvee && x - n <= 10 && y + n <= 10 && x - n > 0 && y + n > 0)
                    {

                        verifcasearrivee(x, y, x - n, y + n, tour, damier, &eat, &verifwithchanges);
                        trouvee = eat;
                        n++; // besh nvirifyi toute la diagonale rny ghlta
                    }
                    if (trouvee == true)
                    {

                        printf("vous devez manger a nouveau vous avez comme depart i=%d et j=%d\n", x, y);
                        verifwithchanges = false;

                        if (tour == 1)
                        {
                            do
                            {
                                printf("x:");
                                scanf("%d", &x);
                                printf("y:");
                                scanf("%d", &y);
                                verifcasearrivee(i, j, x, y, tour, damier, &eat, &verifwithchanges);
                                ;
                            } while (!eat);
                        }
                        else
                        {
                            if (robot)
                            {
                                do
                                {
                                    x = (rand() % 10) + 1;
                                    y = (rand() % 10) + 1;
                                    verifcasearrivee(i, j, x, y, tour, damier, &eat, &verifwithchanges);
                                    ;
                                } while (!eat);
                                printf("x:%d\n", x);
                                printf("y:%d\n", y);
                            }
                            else
                            {

                                do
                                {
                                    printf("x:");
                                    scanf("%d", &x);
                                    printf("y:");
                                    scanf("%d", &y);
                                    verifcasearrivee(i, j, x, y, tour, damier, &eat, &verifwithchanges);
                                    ;
                                } while (!eat);
                            }
                        }
                        verifwithchanges = true;
                        verifcasearrivee(i, j, x, y, tour, damier, &eat, &verifwithchanges);
                        ;
                    }
                    else
                    {
                        eat = false;
                    } // if trouvee else eat=false
                }     // if dame
            }

        } while (!casearrivee);
        printf("bien jouee\n");
        printf("\n%d %d \n", nb_blanc, nb_noir);
        affichedamier(damier);

        tour = -tour;
    }
    printf("\nle jeu est termin%c ", 130);

    return 0;
}
