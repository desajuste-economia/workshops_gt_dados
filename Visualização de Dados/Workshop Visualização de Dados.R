"""
Workshop de Visualização de Dados - Desajuste
"""

# Instalando as bibliotecas
install.packages("ggplot2")
install.packages("ggthemes")

# Importando as bibliotecas
library("ggplot2") 
library("ggthemes")


"""
1. Visualizando os dados
- Importante analisar o tipo de cada variável (chr, dbl, int, etc.)
"""
df_felicidade_2017 <- read.csv("felicidade_2017.csv")
str(df_felicidade_2017) 
View(df_felicidade_2017)

"""
R base x GGPLOT2
"""
# Gráfico gerado no R base
plot(x = df_felicidade_2017$log_gdp_per_capita,
     y = df_felicidade_2017$life_expec)

# Gráfico gerado no GGPLOT2
ggplot(data = df_felicidade_2017, aes(x = log_gdp_per_capita,
                                      y = life_expec)) +
  geom_point() 


"""
Principais tipos de gráficos
1. Dispersão (scatterplot) -> geom_point()
2. Gráfico de barras       -> geom_col()/geom_bar()
3. Histograma              -> geom_histogram()
4. Boxplot                 -> geom_boxplot()
5. Densidade               -> geom_density()
6. Gráfico de linhas       -> geom_line()
"""

"""
Estética
"""
# Agrupando

## Por cor
ggplot(data = df_felicidade_2017, aes(x = log_gdp_per_capita,
                                      y = life_expec,
                                      color = continent)) +
  geom_point() 
## Por forma
ggplot(data = df_felicidade_2017, aes(x = log_gdp_per_capita,
                                      y = life_expec,
                                      shape = continent)) +
  geom_point() 

# Facetas
ggplot(data = df_felicidade_2017, aes(x = log_gdp_per_capita,
                                      y = life_expec)) +
  geom_point() +
  facet_wrap(~ continent)

# Paleta de cores

install.packages("RColorBrewer")
library("RColorBrewer")

display.brewer.all(n=NULL, type="all", select=NULL, exact.n=TRUE,
                   colorblindFriendly=TRUE)

## Mudando paletas de cores
ggplot(data = df_felicidade_2017, aes(x = log_gdp_per_capita,
                                      y = life_expec,
                                      color = continent)) +
  geom_point() +
  scale_color_brewer(palette = "Dark2")

"""
Elementos possíveis dentro de aes()
1. Posição (x e y);
2. Cor (color);
3. Tamanho (size);
4. Preenchimento (fill);
5. Transparência (alpha);
6. Forma (shape).
"""

"""
Linha de tendência
"""
# Completo
ggplot(data = df_felicidade_2017, aes(x = log_gdp_per_capita,
                                      y = life_expec)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

# Por grupos
ggplot(data = df_felicidade_2017, aes(x = log_gdp_per_capita,
                                      y = life_expec,
                                      color = continent)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

"""
Gráfico de Pizza vs Gráfico em Barra
"""
n_paises <- df_felicidade_2017 %>%
  group_by(continent) %>%
  summarise(n = n())

# Pizza
ggplot(n_paises, aes(x = "", y = n, fill = continent)) + 
  geom_bar(stat="identity", width = 1) +
  coord_polar("y", start = 0) + 
  theme_void()

# Barra
ggplot(n_paises, aes(y = n, x = continent, fill = continent)) + 
  geom_col()


"
Labels e Legendas
Soma-se ao final o comando labs com as legendas desejadas 
"


# Gráfico da Correlação Renda e Expectativa de Vida, continentes demarcados

ggplot(data = df_felicidade_2017, aes(x = log_gdp_per_capita,
                                      y = life_expec,
                                      color = continent)) +
  geom_point()  


# Título e subtítulo (fonte) do Gráfico

ggplot(data = df_felicidade_2017, aes(x = log_gdp_per_capita,
                                      y = life_expec,
                                      color = continent)) +
  geom_point()  +
  
  labs(title = "Correlação entre a Renda e a Expectativa de Vida",
       
       subtitle = "Fonte: Helliwell, J., Layard, R., & Sachs, J. (2017).")


# Legenda dos Eixos x e y

ggplot(data = df_felicidade_2017, aes(x = log_gdp_per_capita,
                                      y = life_expec,
                                      color = continent)) +
  geom_point()  + 
  
  labs(title = "Correlação entre a Renda e a Expectativa de Vida",
       subtitle = "Fonte: Helliwell, J., Layard, R., & Sachs, J. (2017).",
       x = "Log da Renda per Capita", y = "Expectativa de vida")


# Legenda do continente de cada país

ggplot(data = df_felicidade_2017, aes(x = log_gdp_per_capita,
                                      y = life_expec,
                                      color = continent)) +
  geom_point()  +
  
  labs(title = "Correlação entre a Renda e a Expectativa de Vida",
       
       subtitle = "Fonte: Helliwell, J., Layard, R., & Sachs, J. (2017).",
       
       x = "Log da Renda per Capita", y = "Expectativa de vida",
       
       color = "Continente:")

"
2. Análise Exploratória
"

"
Boxplot
"

ggplot(data = df_felicidade_2017) +
  geom_boxplot(aes(y = log_gdp_per_capita)) # Nesse caso utilizamos y



"
Histograma
"

ggplot(data = df_felicidade_2017) +
  geom_histogram(aes(x = log_gdp_per_capita)) # Ajustando o número de colunas

ggplot(data = df_felicidade_2017) +
  geom_histogram(aes(x = log_gdp_per_capita), bins = 8)


"
Renda dos países tem  distribuição assimétrica
negativa / para esquerda (maiores desvios na renda dos países pobres)
"



"
3. Temas - Usaremos o pacote ggthemes 
"

library("ggthemes")


"
Utilizando novamente o último gráfico em que selecionamos as legendas
Iremos salvá-lo como um objeto plot_labels
"


plot_labels <- ggplot(data = df_felicidade_2017, aes(x = log_gdp_per_capita,
                                                     y = life_expec,
                                                     color = continent)) +
  geom_point()  +
  
  labs(title = "Correlação entre a Renda e a Expectativa de Vida",
       
       subtitle = "Fonte: Helliwell, J., Layard, R., & Sachs, J. (2017).",
       
       x = "Log da Renda per Capita", y = "Expectativa de vida",
       
       color = "Continente:")


"
É possível alterar a estética e o layout do plot por meio de um tema diferente
Somaremos ao objeto plot_labels o comando theme_XXX()
"

plot_labels + theme_base() # Estilo R padrão

plot_labels + theme_excel_new() # Similar ao Excel

plot_labels + theme_economist() # Similar ao The Economist

plot_labels + theme_clean()  # Minimalista 


"
É possível alterar partes específicas do tema para customizar o gráfico
Soma-se ao tema elementos desejádos
"

# Alterando a fonte

plot_labels + theme_clean() + 
  theme(text = element_text(family = "Times New Roman"))


# Alterando o local da legenda

plot_labels + theme_clean() + 
  theme(text = element_text(family = "Times New Roman")) +
  theme(legend.position = "bottom")

"
É possível salvar esse novo tema customizado
"

theme_custom <- theme_clean() + 
  theme(text = element_text(family = "Times New Roman")) +
  theme(legend.position = "bottom")


# Aplicando o tema

plot_labels + theme_custom

plot_labels_new <- plot_labels + theme_custom



plot_labels + theme_clean() + 
  theme(title = element_text(family = "Times New Roman", size = 20))  +
  theme(axis.title.x = element_text(family = "Times New Roman", size = 14)) +
  theme(axis.title.y = element_text(family = "Times New Roman", size = 14)) +
  scale_color_brewer(palette = "Dark2")



