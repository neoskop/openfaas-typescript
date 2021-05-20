# OpenFaaS typescript template
OpenFaaS typescript template with easy debugging (thanks to nodemon)

I did not found a good typescript template for OpenFaaS, so I made one.

If you want to launch it in debug mode, set the DEBUG build arg:

```
    build_args:
      DEBUG: true
```

This will start nodemon with enabled debugging. I recomment to use [Devspace](https://devspace.sh/) or [Okteto](https://okteto.com/), so that you don't have to rebuild on every change.

More information can be found here: https://www.openfaas.com/blog/painless-serverless-development/
