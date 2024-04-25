er[numerocase(i + 2 * tour, j + 2) - 1] == 5)
		
    	{
        return true;
    	}
    	
    	else{
    		
        if (damier[numerocase(i, j) - 1] == d){ // si c un damier n3kssouhm ten s7a7;; heda wsh zdt f les 2
            
			if (damier[numerocase(i - tour, j + 1) - 1] == 5 ||
			   damier[numerocase(i - tour, j - 1) - 1] == 5 ||
			   damier[numerocase(i - tour, j - 1) - 1] == 5 ||
			   damier[numerocase(i - tour, j - 1) - 1] == b 
			   &&
			   damier[numerocase(i - 2 * tour, j - 2) - 1] == 5 ||
			   damier[numerocase(i - tour, j + 1) - 1] == a ||
			   amier[numerocase(i - tour, j + 1) - 1] == b
			   &&
			   damier[numerocase(i - 2 * tour, j + 2) - 1] == 5)
             {
                return true;
             }
        }

        return false;
    }

    return false;
}
