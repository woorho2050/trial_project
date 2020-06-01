library(tidyverse)
library(pdftools)

urbanization <- pdf_text("urbanization.pdf")

str(urbanization)
urbanization[1:10]

urban_ed <- urbanization %>% 
  str_replace_all("  {2,}", "") %>% 
  str_replace_all("\\.\r\n", "\\.\n") %>% 
  str_replace_all("\r\n", " ") %>% 
  str_replace_all("ENTELEQUIAeumed•net revista interdisciplinarwww.eumed.net/entelequia ", "")
urban_ed[1:10]