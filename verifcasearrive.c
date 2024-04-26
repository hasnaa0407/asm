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
    //hna tbda l if tae islam:
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
    }// hna tkhlas.

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


    // hna tzid t3awd tbda:
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
        } //hna thbes.

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
