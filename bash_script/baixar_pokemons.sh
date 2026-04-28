#!/bin/bash
# ==============================================================================
# Script: pokemon
# Descrição: Baixa 10 sprites de pokemons aleatorios no diretorio /tmp/pokemons_cache.
# Requisitos: chafa, jq, curl, ssh, terminal (kitty)
# ==============================================================================

CACHE_DIR="/tmp/pokemons_cache"
INDEX_FILE="$CACHE_DIR/index"

mkdir -p "$CACHE_DIR"

rm -f "$CACHE_DIR"/*

for i in $(seq 0 9); do
  id=$(shuf -i 1-1025 -n 1)

  data=$(curl -s --fail https://pokeapi.co/api/v2/pokemon/$id)

  name=$(jq -r '.name' <<< "$data")
  sprite=$(jq -r '.sprites.front_default' <<< "$data")

  echo "$name" > "$CACHE_DIR/$i.name"

  curl -s "$sprite" > "$CACHE_DIR/$i.img" &
done

wait

echo 0 > "$INDEX_FILE"
