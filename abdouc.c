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

    if (damier[numerocase(i + tour, j + 1) - 1] == 5 ||
	    damier[numerocase(i + tour, j - 1) - 1] == 5 ||
		((damier[numerocase(i + tour, j - 1) - 1] == a || damier[numerocase(i + tour, j - 1) - 1] == b)
		&& damier[numerocase(i + 2 * tour, j - 2) - 1] == 5) ||
		((damier[numerocase(i + tour, j + 1) - 1] == a || damier[numerocase(i + tour, j + 1) - 1] == b)
		&& damier[numerocase(i + 2 * tour, j + 2) - 1] == 5))
    {
        return true;
    }
    else
    {
        if (damier[numerocase(i, j) - 1] == d)
        { // si c un damier n3kssouhm ten s7a7;; heda wsh zdt f les 2
            if (damier[numerocase(i - tour, j + 1) - 1] == 5 ||
			    damier[numerocase(i - tour, j - 1) - 1] == 5 ||
				((damier[numerocase(i - tour, j - 1) - 1] == a || damier[numerocase(i - tour, j - 1) - 1] == b) 
				&& damier[numerocase(i - 2 * tour, j - 2) - 1] == 5) ||
				((damier[numerocase(i - tour, j + 1) - 1] == a || damier[numerocase(i - tour, j + 1) - 1] == b)
				&& damier[numerocase(i - 2 * tour, j + 2) - 1] == 5))
            {
                return true;
            }
        }

        return false;
    }

    return false;
}
