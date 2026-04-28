#!/bin/bash
# ==============================================================================
# Script: pokemon
# Descrição: Mostra um Pokémon aleatório no terminal toda vez que você abre uma nova sessão.
# Requisitos: chafa, jq, curl, ssh, terminal (kitty)
# ==============================================================================
CACHE_DIR="/tmp/pokemons_cache"
INDEX_FILE="$CACHE_DIR/index"
DOWNLOADER="$HOME/Documentos/baixar_pokemons.sh"

if [ ! -f "$CACHE_DIR/0.img" ]; then
  "$DOWNLOADER"
fi

index=$(cat "$INDEX_FILE" 2>/dev/null || echo 0)

if [ "$index" -ge 10 ]; then
  "$DOWNLOADER"
  index=0
fi

name=$(cat "$CACHE_DIR/$index.name")

echo "$name"
echo

chafa -s 20x20 "$CACHE_DIR/$index.img"

# Incrementa índice
echo $((index + 1)) > "$INDEX_FILE"
