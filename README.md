# This repository contains presentation slides for a joint project with Angda Li and Qi Li.

*Abstract: We consider nonparametric kernel estimation of conditional density functions in bounded and unbounded support settings when bounds on the responses $Y$ are known or unknown and the multivariate responses and covariates $X$ may consist of mixed categorical and continuous data types. When bounds $[a,b]$ on the continuous responses are unknown, we advocate using the empirical support (i.e., $[\min(Y_i),\max(Y_i)]$) in their place. We jointly select the order of the approximating local polynomial $p$ and bandwith vectors via likelihood cross-validation. This fully data-driven approach thereby  i) automatically adapts to unknown bounds, ii) frees the practitioner from having to adopt a given polynomial order in an ad hoc manner, and iii) admits a mix of datatypes often encountered in applied settings. Simulations indicate that this approach is competitive with existing methods in terms of root mean square error (RMSE) in infinite $Y$ support settings and is particularly useful when the distribution of $Y$ is bounded but the bounds are not known a priori.*

-   The slides can be accessed via <https://jeffreyracine.github.io/bk>

-   The GitHub repository for these slides is <https://github.com/JeffreyRacine/bk> (you are here!)

-   The bkcde R package can be accessed at <https://github.com/JeffreyRacine/bkcde> (you need to first install this package if you wish to compile the slides)

-   To install auxiliary packages required to compile the slides, run the following command in R:

    install.packages(c("lpcde","np","pglm","progress","robustbase"),repos="https://cran.wu.ac.at/")

> To generate the slides, a) click the CODE icon in the GitHub repository, b) click on Download ZIP, c) unzip the download, d) open index.qmd in RStudio, e) comment out the simulation section (this reads files from a subdirectory containing large data files so is not included in this repo), f) install the packages highlighted in RStudio, then g) click Render in RStudio (you may have to install a few packages - click install if presented with the option), h) be patient, the code can take some time to run and complete.

