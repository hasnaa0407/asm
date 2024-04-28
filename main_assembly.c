int main()
{
	// islam ybda mna lazm ychouf kifah y9der ykhdem la fonction random whdha comme procedure pcq makach f assembly: 
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
        srand(time(NULL)); // haylik random
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
            if (robot) // si contre pc
            {
                do
                {
                	// hna tst3mel random bech tmdlk des valeurs tae i et j entre 1 et 10 
                    i = (rand() % 10) + 1; 
                    j = (rand() % 10) + 1;
                } while (!verifcasedepart(i, j, tour, damier));
                printf("\ni:%d", i);
                printf("\nj:%d", j);
            }
            else //si contre adversaire
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
            // hna thbes islam
            
            
            
            
            // abdou ydir kamel had l while hta ykhlas l main:
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
