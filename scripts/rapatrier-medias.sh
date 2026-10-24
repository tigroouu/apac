#!/usr/bin/env bash
# Télécharge les images et PDF encore hébergés sur Weebly dans assets/,
# puis réécrit les liens des pages HTML vers ces copies locales.
# À lancer depuis la racine du dépôt : ./scripts/rapatrier-medias.sh
set -euo pipefail

BASE="https://apac91.weebly.com/uploads/8/8/8/7/88873086/"
cd "$(dirname "$0")/.."

LIST=$(mktemp)
grep -ohE "https://apac91\.weebly\.com/uploads/[^\"' )]+" ./*.html | sort -u > "$LIST"
echo "$(wc -l < "$LIST" | tr -d ' ') fichiers référencés"

ok=0; ko=0
while IFS= read -r url; do
  rel="${url#"$BASE"}"            # ex. published/sush.jpg
  case "$rel" in
    *.pdf) dest="assets/docs/$(basename "$rel")" ;;
    *)     dest="assets/img/${rel//\//_}" ;;   # published/sush.jpg -> published_sush.jpg
  esac
  mkdir -p "$(dirname "$dest")"
  if [ -s "$dest" ] || curl -fsSL --retry 2 -o "$dest" "$url"; then
    # remplace l'URL par le chemin local dans toutes les pages
    esc_url=$(printf '%s' "$url" | sed 's/[.[\*^$/]/\\&/g')
    esc_dest=$(printf '%s' "$dest" | sed 's/[&/]/\\&/g')
    sed -i.bak "s/${esc_url}/${esc_dest}/g" ./*.html
    ok=$((ok+1))
  else
    echo "Échec : $url" >&2
    rm -f "$dest"; ko=$((ko+1))
  fi
done < "$LIST"
rm -f ./*.html.bak "$LIST"
echo "Terminé : $ok rapatriés, $ko échecs (les échecs gardent leur lien Weebly)."
