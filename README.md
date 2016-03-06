Differences in behaviour of `before_install` depending on
- whether it's inlined in `.travis.yml` or in a shell script
- whether it's a public or private repo

## 1. Public repo (travis-ci.org)

### 1.1. Inline

```yml
# travis.yml
before_install:
  - echo "about to fail"
  - exit 1
script:
  - echo "build passed"
```

Build marked as **failed**.
The output is as follows.

```bash
$ nvm install 0.10
######################################################################## 100.0%
Now using node v0.10.43
$ node --version
v0.10.43
$ npm --version
1.4.29
$ nvm --version
0.23.3
before_install.1
0.00s
$ echo "about to fail"
about to fail
$ exit 1
```

## 1.2. External script

```yml
# travis.yml
before_install:
  - ./travis-before.sh   # same content as above
script:
  - echo "build passed"
```

Build marked as **errored**.
Similar output, and we can see the script being run and exiting with code 1.

```bash
$ nvm install 5.1
######################################################################## 100.0%
Now using node v5.1.1
$ node --version
v5.1.1
$ npm --version
3.3.12
$ nvm --version
0.23.3
0.00s
$ ./travis-before.sh
about to fail
The command "./travis-before.sh" failed and exited with 1 during .
Your build has been stopped.
```

## 2. Private repo (travis-ci.com)

### 2.1. Inline

```yml
# travis.yml
before_install:
  - echo "about to fail"
  - exit 1
script:
  - echo "build passed"
```

Build marked as **failed**.
Output is similar to the public repo, except we don't see the `exit 1` command.

```bash
$ nvm install 5.1
######################################################################## 100.0%
Now using node v5.1.1
$ node --version
v5.1.1
$ npm --version
3.3.12
$ nvm --version
0.23.3
NaNs
$ echo "about to fail"
about to fail
```

### 2.2. external script

```yml
# travis.yml
before_install:
  - ./travis-before.sh  # same content as above
script:
  - echo "build passed"
```

Build marked as **errored**.
The output is completely silent.

```bash
$ nvm install 5.1
############################################
```
