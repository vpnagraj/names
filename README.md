# names (1880-2012)

[http://apps.bioconnector.virginia.edu/names](http://apps.bioconnector.virginia.edu/names)

display frequency of american names from late 19th century to early 21st century

data source: [social security administration names from genderdata package](https://github.com/ropensci/genderdata)

use the following code to run locally:
```
install.packages("install.packages("genderdata", repos = "http://packages.ropensci.org")
install.packages("shiny")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("ggthemes")

shiny::runGitHub('names', 'vpnagraj') 
```
