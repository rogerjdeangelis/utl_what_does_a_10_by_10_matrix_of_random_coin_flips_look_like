What does a 10 by 10 matrix of random coin flips look like or is it a heat map

see for graphic output
https://tinyurl.com/yc4cbc4x
https://github.com/rogerjdeangelis/utl_what_does_a_10_by_10_matrix_of_random_coin_flips_look_like/blob/master/utl_what_does_a_10_by_10_matrix_of_random_coin_flips_look_like.png

github
https://tinyurl.com/ycjoeykt
https://github.com/rogerjdeangelis/utl_how_far_can_the_roots_of_a_tree_expand_before_they_interfer_to_with_another_tree

 Two solutions

     1. WPS/PROC R or IML/R
     2. SAS Proc plot

        WPS failed on the line printer countour plot
        ERROR: Option "contour" is not known for the PLOT statement

see
https://tinyurl.com/yapvk5cg
https://stackoverflow.com/questions/49021201/heatmap-of-a-matrix-of-zeros-and-ones-using-image-function-in-r

Kamil Slowikowski profile
https://stackoverflow.com/users/330558/kamil-slowikowski

Heatmap of a matrix of zeros and ones using image function in R

INPUT
=====

 Matrix of random coin flips

 SD1.HAVE total obs=10

  Obs    X1    X2    X3    X4    X5    X6    X7    X8    X9    X10

    1     1     0     1     0     0     0     0     1     1     1
    2     0     1     0     1     0     1     1     0     0     1
    3     1     0     1     1     0     0     1     1     0     0
    4     1     1     0     0     1     1     1     1     1     1
    5     1     1     1     1     0     0     0     1     1     0
    6     1     1     1     0     0     0     1     1     0     0
    7     0     0     1     0     1     0     0     0     0     0
    8     1     0     1     1     0     1     1     0     0     0
    9     0     0     1     1     0     0     1     0     1     1
   10     0     1     0     1     1     0     0     0     0     1

 WANT

    Heat Map or Matrix of Random Flips

      1 3 5 7 9

    1 M M    MMM
    2  M M MM  M
    3 M MM  MM
    4 MM  MMMMMM
    5 MMMM   MM
    6 MMM   MM
    7   M M
    8 M MM MM
    9   MM  M MM
   10  M MM    M


PROCESS (working code)
======================

  WPS/PROC R or

    image(t(have[nrow(have):1,]), col = c("black", "white"));

  SAS (requires slighly different input)

    options ps=20 ls=64;
    proc plot data=sd1.have;
    plot y*x=z / contour=2;
    run;quit;


OUTPUTS
=======

Hilite the matrix in proc plot outpu and issue this on the classic
editor command line (not EE)

"c '-' ' ' all;c ' ' '' all;c # M all;c '.' ' ' all;

Contour plot of Y*X.
      1 3 5 7 9

    1 M M    MMM
    2  M M MM  M
    3 M MM  MM
    4 MM  MMMMMM
    5 MMMM   MM
    6 MMM   MM
    7   M M
    8 M MM MM
    9   MM  M MM
   10  M MM    M

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;
* R INPUT;

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
array xs[10] x1-x10;
do rec=1 to 10;
   do i=1 to 10;
     if uniform(5731)<.5 then xs[i]=1;
     else xs[i]=0;
   end;
drop  i;
output;
end;
run;quit;

* SAS INPUT

data have;
do x=1 to 10;
   do y=1 to 10;
     if uniform(5731)<.5 then z=1;
     else z=0;
     output;
   end;
end;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __  ___
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|
\__ \ (_) | | |_| | |_| | (_) | | | \__ \
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/

;

* R
%utl_submit_wps64('
libname sd1 "d:/sd1";
options set=R_HOME "C:/Program Files/R/R-3.3.2";
libname wrk "%sysfunc(pathname(work))";
libname hlp "C:\Program Files\SASHome\SASFoundation\9.4\core\sashelp";
proc r;
submit;
source("C:/Program Files/R/R-3.3.2/etc/Rprofile.site", echo=T);
library(haven);
have<-as.matrix(read_sas("d:/sd1/have.sas7bdat"));
head(have);
png("d:/png/utl_what_does_a_10_by_10_matrix_of_random_coin_flips_look_like.png");
image(t(have[nrow(have):1,]), col = c("black", "white"));
png();
endsubmit;
run;quit;
');

* SAS;
data have;
do x=0 to 9;
   do y=0 to 9;
     if uniform(5731)<.5 then z=1;
     else z=0;
     output;
   end;
end;
run;quit;

options ps=20 ls=64;
proc plot data=have;
plot y*x=z / contour=2;
run;quit;


Hilite the matrix output and issue this on the classic
editor command line

* cut and paste this on command line;

c '-' ' ' all;c ' ' '' all;c # M all;c '.' ' ' all;

 Contour plot of Y*X.
Y
9 +MM M    MM
8 +M  MM   M
7 +M MMMM
6 + MMM M MM
5 + M M   M
4 +   M  M  M
3 + MM M  MMM
2 +M M MMMMM
1 + M MMM   M
0 +M MMMM M
  -++++++++++
   0123456789

