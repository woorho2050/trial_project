# 패키지 관리 함수 활용
install_load_pkg <- function(pkgs) {
    new_pkgs <- pkgs[!(pkgs %in% installed.packages()[, "Package"])]
    if (length(new_pkgs) > 0) {
        install.packages(new_pkgs)
    }
    lapply(pkgs, require, character.only = TRUE)
    invisible(capture.output())
}

pkgs <- c("tidyverse", "rvest")

install_load_pkg(pkgs)


# 웹페이지 수집
url <- "https://www.citylab.com/design/2020/03/coronavirus-urban-planning-global-cities-infectious-disease/607603/"
html_raw <- read_html(url)
html_raw

# 요소별 구분 텍스트 추출
title <- html_raw %>% 
    html_nodes(".l-article__hed") %>% 
    html_text()
title

author <- html_raw %>% 
    html_nodes(".c-byline__link--article__hed") %>% 
    html_text()
author

date <- html_raw %>% 
    html_nodes(".c-byline__time--article__hed") %>% 
    html_text()
date

abstract <- html_raw %>% 
    html_nodes(".l-article__dek.o-small-container") %>% 
    html_text()
abstract

body <- html_raw %>% 
    html_nodes(".s-article__section.o-small-container") %>% 
    html_nodes("p") %>% 
    html_text()
body[1]


# 원문 텍스트 파일 저장
article <- c(title, author, date, abstract, body)
length(article)

dirs <- c("interim_data", "output")

map(dirs, function(dir) {
    if (!dir.exists(dir)) {
        dir.create(dir, recursive = TRUE)
    }
})

write_rds(article, "interim_data/article.RDS")
write_lines(article, "output/article.txt")