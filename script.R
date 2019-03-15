#Baixa pacotes
library(rvest)
library(data.table)
library(plyr)
library(rjson)

#Lista estados
uf <- c("ac", "al", "am", "ap", "ba", "ce", "df", "es", "go", "ma", "mg", "ms",
        "mt", "pa", "pb", "pe", "pi", "pr", "rj", "rn", "ro","rr","rs","sc","se","sp","to")

#Importa lista de partidos do TSE
  url_tse <- "http://filiaweb.tse.jus.br/filiaweb/portal/relacoesFiliados.xhtml"
lista_partidos <- url_tse %>%
  read_html("http://filiaweb.tse.jus.br/filiaweb/portal/relacoesFiliados.xhtml") %>%
  html_nodes(xpath = '//*[@id="partido"]//option') %>%
  html_attr("value")

#Loop para baixar os arquivos do TSE - trocar por lapply ou simliar
for(partido in lista_partidos){
  for(estado in uf) {
  arquivo <- paste0(partido,"_",estado,".zip")
  download.file(paste0("http://agencia.tse.jus.br/estatistica/sead/eleitorado/filiados/uf/filiados_",
                       partido,"_",estado,".zip"),arquivo, mode = "wb")}}

#Descompacta os arquivos do TSE
arquivoszip <- list.files(pattern = "*.zip", full.names = TRUE)
ldply(.data = arquivoszip, .fun = unzip)


