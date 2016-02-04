# names (1880-2012)

[http://apps.bioconnector.virginia.edu/names](http://apps.bioconnector.virginia.edu/names)

display frequency of american names from late 19th century to early 21st century

data source: [social security administration names from babynames package](https://github.com/hadley/babynames)

use the following code to run locally:
```
install.packages("shiny")
install.packages("ggplot2")
install.packages("ggthemes")
install.packages("babynames")
install.packages("scales")

shiny::runGitHub('names', 'vpnagraj') 
```
