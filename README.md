# Introducción a los Modelos Basados en Agentes
> Workshop Chisocnet 2025

Este repositorio contiene los materiales para el Workshop de Introducción a los Modelos Basados en Agentes (ABM), parte del programa de Chisocnet 2025.

![](img/segregacion_schelling.gif)


### 🎯 Materiales del Workshop

- [📊 Presentación](presentacion/slides_ABM_workshop.pdf) 
- [💻 Script de práctica](scripts/practicaABM.R)

### 📚 Recursos Bibliográficos

#### Lecturas Fundamentales

- Acerbi, A., Mesoudi, A., & Smolla, M. (2023). [Individual-Based Models of Cultural Evolution: A Step-by-Step Guide Using R](bibliography/acerbi_et_al_2022.pdf). *Routledge*
- Macy, M. W., & Willer, R. (2002). [From Factors to Actors: Computational Sociology and Agent-Based Modeling](bibliography/annurev.soc.28.110601.141117.pdf). *Annual Review of Sociology* 28(1), 143-166. https://doi.org/10.1146/annurev.soc.28.110601.141117
- Schelling, T. C. (1971). [Dynamic models of segregation](bibliography/schelling1971.pdf). *Journal of Mathematical Sociology, 1*(2), 143-186.
- Smaldino, P. E. (2020). [How to Translate a Verbal Theory Into a Formal Model](bibliography/smaldino2020.pdf). *Social Psychology*, 51(4), 207-218. https://doi.org/10.1027/1864-9335/a000425

#### Lecturas Complementarias

- Gilbert & Troitzsch (2005). [Simulation for the social scientist](https://cress.soc.surrey.ac.uk/s4ss/S4SS-sample-chapter.pdf). Open University Press. 
- Manzo, G. (2022). [Agent-based models and causal inference](bibliography/manzo2022.pdf). John Wiley & Sons, Inc.
- Smaldino, P. E. (2023). [Modeling social behavior: Mathematical and agent-based models of social dynamics and cultural evolution](bibliography/smaldino2023.pdf). Princeton University Press.

### 🔧 Preparación del Entorno

#### Requisitos Previos

- R (versión ≥ 4.0.0)
- RStudio 

#### Instalación de Paquetes

```r
# Instalación de paquetes necesarios
install.packages(c(
  "tidyverse",  # Manipulación y visualización de datos
  "igraph",     # Análisis y visualización de redes
  "extraDistr"  # Distribuciones de probabilidad adicionales
))
```

#### Configuración

1. Clonar el repositorio:
```bash
git clone https://github.com/rcantillan/ABM_workshop.git
```

2. Instalar dependencias:
```r
source("scripts/install_packages.R")
```

3. Iniciar proyecto:
   - Abrir `ABM_workshop.Rproj` en RStudio

### 📁 Estructura del Proyecto

```
ABM_workshop/
├── README.md
├── presentacion/
├── scripts/
├── bibliografia/
└── img/
```

### ℹ️ Información del Workshop

- **Evento**: Chisocnet 2025
- **Modalidad**: TBD
- **Duración**: TBD

### 💬 Soporte

- 🐛 Reporta problemas vía [Issues](../../issues)
- 📧 Contacta al instructor directamente

### 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver [LICENSE.md](LICENSE.md) para detalles.


