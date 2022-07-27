if [ "$DEBUG" = "true" ]; then
    nodemon index.ts
else
    node .
fi