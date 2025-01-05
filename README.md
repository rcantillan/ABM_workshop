# Workshop: Introducción a los Modelos Basados en Agentes

![Modelo de Segregación de Schelling](img/segregacion_schelling.gif)

Este repositorio contiene los materiales para el Workshop de Introducción a los Modelos Basados en Agentes (ABM) que se realizará en el marco de la conferencia Chisocnet 2025.

## Contenidos

### Materiales del Workshop
- 📊 [Presentación](presentacion/slides_ABM_workshop.pdf) 
- 💻 [Script de práctica](scripts/practicaABM.R)

### Bibliografía Fundamental
- 📚 Acerbi, A., Mesoudi, A., & Smolla, M. (2023). [Individual-Based Models of Cultural Evolution: A Step-by-Step Guide Using R](bibliography/acerbi_et_al_2022.pdf). *Routledge*
- 📚 Macy, M. W., & Willer, R. (2002). [From Factors to Actors: Computational Sociology and Agent-Based Modeling](bibliography/annurev.soc.28.110601.141117.pdf). *Annual Review of Sociology* 28(1), 143-166. https://doi.org/10.1146/annurev.soc.28.110601.141117
- 📚 Schelling, T. C. (1971). [Dynamic models of segregation](bibliography/schelling1971.pdf). *Journal of Mathematical Sociology, 1*(2), 143-186.
- 📚 Smaldino, P. E. (2020). [How to Translate a Verbal Theory Into a Formal Model](bibliography/smaldino2020.pdf). *Social Psychology*, 51(4), 207-218. https://doi.org/10.1027/1864-9335/a000425


### Bibliografía Complementaria
- 📚 Epstein, J. M., & Axtell, R. (1996). [Growing artificial societies: Social science from the bottom up](https://books.google.cl/books?hl=es&lr=&id=6JYhAQAAIAAJ&oi=fnd&pg=PR9&dq=epstein+axtell+1996&ots=8Q6Z9Q6Q8v&sig=8Q6Z9Q6Q8v&redir_esc=y#v=onepage&q=epstein%20axtell%201996&f=false). Brookings Institution Press.
- 📚 Gilbert, N., & Troitzsch, K. G. (2005). [Simulation for the social scientist](https://books.google.cl/books?hl=es&lr=&id=6JYhAQAAIAAJ&oi=fnd&pg=PR9&dq=epstein+axtell+1996&ots=8Q6Z9Q6Q8v&sig=8Q6Z9Q6Q8v&redir_esc=y#v=onepage&q=epstein%20axtell%201996&f=false). McGraw-Hill Education (UK).
- 📚 Smaldino, P. E. (2023). Modeling social behavior: Mathematical and agent-based models of social dynamics and cultural evolution. Princeton University Press.


## Pre-requisitos

### Software Requerido
- R (>= 4.0.0)
- RStudio 

### Paquetes de R Necesarios
```r
# Instalación de paquetes requeridos
install.packages(c(
  "tidyverse",  # Para manipulación y visualización de datos
  "igraph",     # Para análisis y visualización de redes
  "extraDistr"  # Para distribuciones de probabilidad adicionales
))
```

## Configuración del Entorno

1. Clonar el repositorio:
```bash
git clone https://github.com/rcantillan/ABM_workshop.git
```

2. Instalar los paquetes requeridos:
```r
source("scripts/install_packages.R")
```

3. Abrir el proyecto en RStudio:
   - Navegar hasta el directorio clonado
   - Abrir el archivo `ABM_workshop.Rproj`

## Estructura del Repositorio

```
ABM_workshop/
├── README.md
├── presentacion/
│   └── slides_ABM_workshop.pdf
├── scripts/
│   ├── install_packages.R
│   └── practicaABM.R
├── bibliografia/
│   ├── acerbi_et_al_2022.pdf
│   └── schelling1971.pdf
└── img/
    └── segregacion_schelling.gif
```

## Información del Workshop

- **Evento**: Chisocnet 2025
- **Modalidad**: Por definir
- **Duración**: Por definir

## Soporte

Si encuentras algún problema o tienes preguntas:
1. Abre un issue en este repositorio
2. Contacta al instructor directamente

## Licencia

Este proyecto está bajo la Licencia [incluir tipo de licencia] - ver el archivo [LICENSE.md](LICENSE.md) para detalles.