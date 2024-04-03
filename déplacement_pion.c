#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

//ON A penser a trouver une relation entre les nbr donnee
int ligne(int n){
    if(n>50||n<1){
       return 0;
        }
    else{

    if(n%5==0){
       return n/5;
    }else{
       return n/5+1;

    }
    }}

int colonne(int n){
    if(n>50||n<1){
            return 0;

    }else{
     if(n%10==0){
            return 9;
        }else{
        if(n%10>5){
            return (n%10-5)*2-1;
        }else{
        return 2*(n%10);
        }
        }
    }
}

int numerocase(int i,int j){
    if(i>10||i<1||j>10||j<1){
    return 0;
    }else{

          if(i%2==1&&j%2==0){

            return j/2+10*(i-1)/2;

        }else{
            if(j%2==1&&i%2==0){
             return (j+1)/2+5+10*(i-2)/2;
        }else return 0;
        }
    }

}


bool verifcasedepart(int i,int j,int tour,int damier[50]){     //if tour blanc==-1  //noir==1
    if(numerocase(i,j)==0){
        return false; //case de depart ghlta entrez a nouveau
    }

    if(tour==-1){
        if(damier[numerocase(i,j)-1]==2||damier[numerocase(i,j)-1]==4){ // zla tu utilise la fonction couleur== blanc

                if(damier[numerocase(i-1,j+1)-1]==5||damier[numerocase(i-1,j-1)-1]==5||(damier[numerocase(i-1,j-1)-1]==1||damier[numerocase(i-1,j-1)-1]==3)&&damier[numerocase(i-2,j-2)-1]==5||(damier[numerocase(i-1,j+1)-1]==1||damier[numerocase(i-1,j+1)-1]==3)&&damier[numerocase(i-2,j+2)-1]==5){
                 return true;
                }
                else{
                    return false;
                }

        }
        return false;

    }
     if(tour==1){
       if(damier[numerocase(i,j)-1]==1||damier[numerocase(i,j)-1]==3){ // zla tu utilise la fonction couleur== blanc

                if(damier[numerocase(i+1,j+1)-1]==5||damier[numerocase(i+1,j-1)-1]==5||(damier[numerocase(i+1,j-1)-1]==2||damier[numerocase(i+1,j-1)-1]==4)&&damier[numerocase(i+2,j-2)-1]==5||(damier[numerocase(i+1,j+1)-1]==2||damier[numerocase(i+1,j+1)-1]==4)&&damier[numerocase(i+2,j+2)-1]==5){
                 return true;
                }
                else{
                    return false;
                }

        }
        return false;
    }
    return false;//case de depart ghlta entrez a nouveau

}



bool verifcasearrivee(int i,int j,int x,int y,int tour,int damier[50]){//avant d appeller cette fonction on utilise la fonction verif
                                                                        //case depart psq ken ydkhlhm ghltin n9ouloulou sur le coup
    if(numerocase(x,y)==0){
        return false;
    }

    if(damier[numerocase(x,y)-1]!=5){
        return false; // la case d arrivee n est pas vide

    }
     //tour  et case de x,y vide
        if(x==i+tour&&y==j+1){

                damier[numerocase(x,y)-1]=damier[numerocase(i,j)-1];
                damier[numerocase(i,j)-1]=5;
                return true;
        }
         if(x==i+tour&&y==j-1){

                damier[numerocase(x,y)-1]=damier[numerocase(i,j)-1];
                damier[numerocase(i,j)-1]=5;
                return true;
        }
         if(x==i+2*tour&&y==j+2){
             if(tour==1){
            if(damier[numerocase(i+1,j+1)-1]==2||damier[numerocase(i+1,j+1)-1]==4){ //pion blanc ou dame blanche
                damier[numerocase(x,y)-1]=damier[numerocase(i,j)-1];
                damier[numerocase(i+1,j+1)-1]=5;
                damier[numerocase(i,j)-1]=5;
                return true;
            }
            return false;
            }
                   if(tour==-1){
            if(damier[numerocase(i-1,j+1)-1]==1||damier[numerocase(i-1,j+1)-1]==3){ //pion noir ou dame noir
                damier[numerocase(x,y)-1]=damier[numerocase(i,j)-1];
                damier[numerocase(i-1,j+1)-1]=5;
                damier[numerocase(i,j)-1]=5;
                return true;
            }
            return false;
            }
        }

          if(x==i+2*tour&&y==j-2){
                if(tour==1){
            if(damier[numerocase(i+1,j-1)-1]==2||damier[numerocase(i+1,j-1)-1]==4){ //pion blanc ou dame blanche
                damier[numerocase(x,y)-1]=damier[numerocase(i,j)-1];
                damier[numerocase(i+1,j-1)-1]=5;
                damier[numerocase(i,j)-1]=5;
                return true;
            }
            return false;
                }
            if(tour==-1){
                if(damier[numerocase(i-1,j-1)-1]==1||damier[numerocase(i-1,j-1)-1]==3){ //pion noir ou dame noir
                damier[numerocase(x,y)-1]=damier[numerocase(i,j)-1];
                damier[numerocase(i-1,j-1)-1]=5;
                damier[numerocase(i,j)-1]=5;
                return true;
            }
            return false;

            }
        }

        return false;


}

void initdamier(int damier[50]){
    for(int i=0;i<20;i++){
        damier[i]=1;//pion noir
    }
    for(int i=20;i<30;i++){
        damier[i]=5;//pion noir
    }
    for(int i=30;i<50;i++){
        damier[i]=2;//pion noir
    }
}

void affichedamier(int damier[50]){
    for(int i=1;i<=10;i++){
    printf("%d ",i);
    }
    printf("\n\n\n");
    int l=0;
    bool b=true;
    for(int i=0;i<10;i++){
     printf("\n");
      if(b==true){
        printf("  ");
        b=false;
        }else{
        b=true;
        }

    for(int j=0;j<5;j++){
       printf("%d ",damier[l]);
       if(j!=4){
        printf("  ");
       }else{
           if(b==true){
            printf("  ");
           }

       }

       l++;
    }
    printf("         %d",i+1);
    }
}
int main()
{
   int damier[50];
   initdamier(damier);
   affichedamier(damier);
   int tour;
   tour=1;
   while(true){
        int x,y,i,j;
        printf("\ntour de :%d",tour);
        do{
        printf("\ni:");
        scanf("%d",&i);
        printf("j:");
        scanf("%d",&j);
        verifcasedepart(i,j,tour,damier);
        }while(!verifcasedepart(i,j,tour,damier));
        do{
        printf("x:");
        scanf("%d",&x);
        printf("y:");
        scanf("%d",&y);
        }while(!verifcasearrivee(i,j,x,y,tour,damier));
        printf("bien jouee\n");
        affichedamier(damier);


   if(tour==-1){
    tour=1;
   }else{
   tour=-1;
   }
   }

    return 0;
}
