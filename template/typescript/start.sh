if [ "$DEBUG" = "true" ]; then
    nodemon --inspect=0.0.0.0 index.ts
else
    node .
fi