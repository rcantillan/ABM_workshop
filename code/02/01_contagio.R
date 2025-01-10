# Implementación ajustada del modelo de Flache & Macy (2011)
# Siguiendo fielmente las especificaciones del paper original

library(igraph)
library(tidyverse)
library(Matrix)

#===========================================
# Parámetros del modelo
#===========================================

model_params <- list(
  n_caves = 20,           # Número de caves como en el paper
  agents_per_cave = 5,    # 5 agentes por cave como en el paper
  n_dimensions = 2,       # 2 dimensiones culturales
  p_rewire = 0.003,      # Probabilidad de reconexión del paper
  max_iter = 10000,      # Iteraciones máximas
  convergence_threshold = 1e-6  # Umbral de convergencia
)

#===========================================
# Funciones de red
#===========================================

create_cave_network <- function(n_caves, agents_per_cave, p_rewire = 0) {
  n_agents <- n_caves * agents_per_cave
  
  # Creamos matriz de adyacencia inicial vacía
  adj_matrix <- matrix(0, n_agents, n_agents)
  
  # Creamos caves completamente conectadas
  for(i in 1:n_caves) {
    cave_start <- (i-1) * agents_per_cave + 1
    cave_end <- i * agents_per_cave
    cave_nodes <- cave_start:cave_end
    
    # Conexiones dentro de la cave
    for(v1 in cave_nodes) {
      for(v2 in cave_nodes) {
        if(v1 < v2) {
          adj_matrix[v1, v2] <- adj_matrix[v2, v1] <- 1
        }
      }
    }
    
    # Conectamos con la siguiente cave (estructura circular)
    if(i < n_caves) {
      next_cave_start <- cave_end + 1
      adj_matrix[cave_end, next_cave_start] <- adj_matrix[next_cave_start, cave_end] <- 1
    }
  }
  
  # Cerramos el círculo
  adj_matrix[n_agents, 1] <- adj_matrix[1, n_agents] <- 1
  
  # Añadimos enlaces aleatorios según p_rewire
  if(p_rewire > 0) {
    potential_edges <- which(adj_matrix == 0 & upper.tri(adj_matrix))
    n_rewire <- rbinom(1, length(potential_edges), p_rewire)
    if(n_rewire > 0) {
      rewire_edges <- sample(potential_edges, n_rewire)
      for(edge in rewire_edges) {
        i <- (edge-1) %% n_agents + 1
        j <- (edge-1) %/% n_agents + 1
        adj_matrix[i,j] <- adj_matrix[j,i] <- 1
      }
    }
  }
  
  return(graph_from_adjacency_matrix(adj_matrix, mode="undirected"))
}

#===========================================
# Funciones de cultura y similitud
#===========================================

initialize_culture <- function(n_agents, n_dimensions) {
  # Distribución uniforme en [-1,1] como en el paper
  matrix(runif(n_agents * n_dimensions, -1, 1),
         nrow = n_agents,
         ncol = n_dimensions)
}

calculate_similarity <- function(v1, v2) {
  # Usando la fórmula exacta del paper
  1 - mean(abs(v1 - v2))
}

calculate_weight <- function(sim, allow_negative = TRUE) {
  if(allow_negative) {
    # Fórmula del paper: w_ij = 1 - d_ij donde d_ij es la distancia cultural media
    return(2 * sim - 1)
  } else {
    # Para el caso de solo valencia positiva
    return(max(0, sim))
  }
}

#===========================================
# Funciones de actualización
#===========================================

update_culture <- function(focal_culture, neighbor_cultures, weights) {
  # Implementación exacta de la ecuación 2 del paper
  n_neighbors <- nrow(neighbor_cultures)
  if(n_neighbors == 0) return(focal_culture)
  
  # Calculamos el cambio raw según ecuación 2
  raw_change <- colSums(weights * (neighbor_cultures - 
                                     matrix(focal_culture, 
                                            nrow=n_neighbors, 
                                            ncol=length(focal_culture), 
                                            byrow=TRUE))) / (2 * n_neighbors)
  
  # Aplicamos la función de suavizado según ecuación 2a
  new_culture <- focal_culture
  for(k in 1:length(focal_culture)) {
    if(focal_culture[k] > 0) {
      new_culture[k] <- focal_culture[k] + raw_change[k] * (1 - focal_culture[k])
    } else {
      new_culture[k] <- focal_culture[k] + raw_change[k] * (1 + focal_culture[k])
    }
  }
  
  return(new_culture)
}

#===========================================
# Métricas
#===========================================

calculate_polarization <- function(culture_matrix) {
  # Implementación de la medida de polarización del paper (ecuación 3)
  n_agents <- nrow(culture_matrix)
  distances <- matrix(0, n_agents, n_agents)
  
  for(i in 1:n_agents) {
    for(j in 1:n_agents) {
      if(i != j) {
        distances[i,j] <- mean(abs(culture_matrix[i,] - culture_matrix[j,]))
      }
    }
  }
  
  mean_dist <- mean(distances[upper.tri(distances)])
  polarization <- mean((distances[upper.tri(distances)] - mean_dist)^2) / 
    (n_agents * (n_agents - 1))
  
  return(polarization)
}

#===========================================
# Simulación principal
#===========================================

run_simulation <- function(params, allow_negative = TRUE) {
  # Inicialización
  g <- create_cave_network(params$n_caves, 
                           params$agents_per_cave, 
                           params$p_rewire)
  n_agents <- params$n_caves * params$agents_per_cave
  culture_matrix <- initialize_culture(n_agents, params$n_dimensions)
  
  # Para almacenar métricas
  metrics_df <- data.frame(
    iteration = 0:params$max_iter,
    polarization = NA
  )
  
  # Métricas iniciales
  metrics_df$polarization[1] <- calculate_polarization(culture_matrix)
  
  # Loop principal
  for(iter in 1:params$max_iter) {
    old_culture <- culture_matrix
    
    # Actualización asíncrona
    update_order <- sample(n_agents)
    for(focal in update_order) {
      neighbors <- as.numeric(neighbors(g, focal))
      if(length(neighbors) == 0) next
      
      # Calculamos similitudes y pesos
      similarities <- sapply(neighbors, function(n) {
        calculate_similarity(culture_matrix[focal,], 
                             culture_matrix[n,])
      })
      weights <- sapply(similarities, calculate_weight, allow_negative)
      
      # Actualizamos cultura
      culture_matrix[focal,] <- update_culture(
        culture_matrix[focal,],
        culture_matrix[neighbors,],
        weights
      )
    }
    
    # Métricas y convergencia
    metrics_df$polarization[iter+1] <- calculate_polarization(culture_matrix)
    
    if(max(abs(culture_matrix - old_culture)) < params$convergence_threshold) {
      metrics_df <- metrics_df[1:(iter+1),]
      break
    }
  }
  
  return(list(
    final_culture = culture_matrix,
    network = g,
    metrics = metrics_df
  ))
}

#===========================================
# Ejecución y visualización
#===========================================

# Ejecutamos ambas condiciones
set.seed(123) # Para reproducibilidad
sim_positive <- run_simulation(model_params, allow_negative = FALSE)
sim_negative <- run_simulation(model_params, allow_negative = TRUE)

# Visualizamos resultados
ggplot() +
  geom_line(data = sim_positive$metrics,
            aes(x = iteration, y = polarization, color = "Solo positiva")) +
  geom_line(data = sim_negative$metrics,
            aes(x = iteration, y = polarization, color = "Positiva y negativa")) +
  labs(title = "Evolución de la polarización",
       x = "Iteración",
       y = "Polarización",
       color = "Valencia de\ninteracción") +
  theme_minimal() +
  scale_color_manual(values = c("Solo positiva" = "#00BFC4",
                                "Positiva y negativa" = "#F8766D"))







