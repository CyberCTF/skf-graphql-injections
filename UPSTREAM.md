# Upstream

| | |
| --- | --- |
| Project | OWASP Security Knowledge Framework labs (SKF labs) |
| Repository | https://github.com/blabla1337/skf-labs |
| Lab | `python/graphql-injections` (Python) |
| Version | master (SKF labs has no releases) |
| Commit | 35199b6f49658b75f860530c0f09b91e985198aa |
| Licence | Apache-2.0 |

| Here | SKF labs path |
| --- | --- |
| `build/web/app/` | [`python/graphql-injections`](https://github.com/blabla1337/skf-labs/tree/35199b6f49658b75f860530c0f09b91e985198aa/python/graphql-injections) |

The vendored folder is that commit's lab folder, unchanged, without its Git history.

`build/web/Dockerfile` is the lab's Dockerfile with `COPY ./` changed to `COPY app/`, and: pip installs with `build/web/constraints.txt`, which pins the packages upstream leaves unpinned to their versions of 2022-02-07 (the date of the lab's last `requirements.txt` change); upstream's install fails today because Flask-Migrate pulls alembic>=1.9, which needs a newer Python than the image's 3.6. Where upstream runs `populate-database.py` in the image, that step is skipped: the vendored `data.sqlite` already holds the data, and the script fails on its first insert (`UNIQUE constraint failed: users.username`).

To update, replace the vendored folder with a newer SKF labs commit, then change this file.
