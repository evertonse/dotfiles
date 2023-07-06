# Squash commits into one
 how_many_commits_to_squase='3'
 ``$ rebase``

# Rebase
- ``$ git checkout -b local_feature ``
- ``$ git commit -a -m "features"``

- to update everything from remote/main to local/main ``$ git checkout main && git pull  ``
- make local_feature rebased ``$ git checkout local_feature && git rebase main``
- make main rebased ``$ git checkout main && git rebase local_feature``
- push your new straight branch ``$ git push``

