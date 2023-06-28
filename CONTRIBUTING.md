# Contributing

## General code rules

## Submitting a pull request

Before you submit your pull request consider the following guidelines:

* Fork the repository and clone your fork
  * open the following URL in your browser: <https://github.com/RedHatInsights/insights-content-service>
  * click on the 'Fork' button (near the top right corner)
  * select the account for fork
  * open your forked repository in browser: <https://github.com/YOUR_NAME/insights-content-service>
  * click on the 'Clone or download' button to get a command that can be used to clone the repository

* Make your changes in a new git branch:

  ```shell
  git checkout -b bug/my-fix-branch master
  ```

* Create your patch, **ideally including appropriate test cases**
* Include documentation that either describe a change to a behavior or the changed capability to an end user
* Commit your changes using **a descriptive commit message**. If you are fixing an issue please include something like 'this closes issue #xyz'
  * Please make sure your tests pass!
  * Currently we use Travis CI for our automated testing.

* Push your branch to GitHub:

  ```shell
  git push origin bug/my-fix-branch
  ```

* When opening a pull request, select the `master` branch as a base.
* Mark your pull request with **[WIP]** (Work In Progress) to get feedback but prevent merging (e.g. [WIP] Update CONTRIBUTING.md)
* If we suggest changes then:
  * Make the required updates
  * Push changes to git (this will update your Pull Request):
    * You can add new commit
    * Or rebase your branch and force push to your GitHub repository:

    ```shell
    git rebase -i master
    git push -f origin bug/my-fix-branch
    ```

That's it! Thank you for your contribution!
