# docker-sammcore-deployer

Fábrica de imágenes de **SAMMCORE-Deployer**. Clona el repo principal desde GitHub (rama `master`),
compila frontend+backend y empaqueta la imagen para publicarla en GHCR.

## Build local

```bash
docker build -t ghcr.io/a81biz/sammcore-deployer:phase3 .
# o fijando referencia:
# docker build --build-arg GIT_REF=master -t ghcr.io/a81biz/sammcore-deployer:phase3 .
