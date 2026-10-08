# Overlay of SKF labs' python/graphql-injections/Dockerfile (vendored unchanged in app/). Differences:
# - COPY ./ becomes COPY app/ (the vendored lab sits in app/ of this build folder);
# - pip installs requirements.txt with constraints.txt, which pins the unpinned packages to their
#   versions of 2022-02-07 (upstream's install fails today: Flask-Migrate pulls alembic>=1.9, which
#   needs a newer Python than the image's 3.6).
# - the populate-database.py step is skipped: the vendored data.sqlite is already populated, and the
#   script fails on its first insert (sqlite3.IntegrityError: UNIQUE constraint failed: users.username).

### Static layers

FROM alpine:3.7 AS skf-alpine37
LABEL Glenn ten Cate <glenn.ten.cate@owasp.org>

# Installing needed binaries and deps. Then removing unneeded deps:
RUN apk update --no-cache && apk add python3 \
  python3-dev \
  py3-pip \
  bash \
  git \
  dos2unix \
  build-base \
  gcc \
  musl-dev \
  g++

### Dynamic layers
FROM skf-alpine37
LABEL Glenn ten Cate <glenn.ten.cate@owasp.org>

RUN addgroup -g 1000 app 
RUN adduser -u 1000 -G app -D -h /home/app app
RUN rm -rf /var/cache/apk/APKINDEX*

COPY app/ /home/app/graphql-injections

# Switching to the new app location:
WORKDIR /home/app/graphql-injections

RUN chown -R app:app /home/app/graphql-injections

# Switching to the limited user
USER app

# Installing needed binaries and deps
# Overlay: install with the pinned constraints (see constraints.txt).
COPY constraints.txt /tmp/constraints.txt
RUN pip3 install --no-cache-dir  --user -c /tmp/constraints.txt -r requirements.txt 

# Fixing Windows line endings for our students:
RUN find . -name "*.sh" -o -name "*.py" -o -name "*.css" -o -name "*.js" | xargs dos2unix

# Setting chmod +x on the scripts:
RUN find . -name "*.sh" -o -name "*.py" | xargs chmod +x

# Populate the database
# Overlay: not run. The vendored data.sqlite already holds this data, so the script fails
# on its first insert (UNIQUE constraint failed: users.username).
# RUN python3 populate-database.py

# Starting the actual application:
ENTRYPOINT [ "python3", "./app.py" ]
