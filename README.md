

## About this project
This project runs a php script that slacks me a reminder to walk my dog

## How to build
- Composer 2 is required to build
- From the root code directory, run

```
composer install --no-interaction --prefer-dist
cp .env.example .env
php artisan key:generate
```

## Running Tests
Once built, run `php artisan test --testdox` to test the application

## IMPORTANT
You must have the environment variable
SLACK_SECRET=

## Running the application
Simply execute `php artisan slack-me`

## Deploying the application
This application can be deployed to any environment that has PHP 8.2 CLI

## IMPORTANT
Please do not include any dev dependencies in the final build

To do this you must run composer install again with these parameters

`composer install --no-dev --optimize-autoloader`

## CICD
### Variables
These variables are defined at the repository level
- DOCKER_USER - username for docker hub push

### Secrets
These secrets are defined at the repository level
- APP_KEY - App key to be used by tests
- DOCKER_PAT - Docker PAT to be used for pushing to docker hub
- SLACK_SECRET - Secret to be used for slack to be used by tests

### Tagging
Tags need to follow semver standards to correctly trigger a push otherwise it will fail unceremoniously (this could be made a little more robust or follow better company standards, but it was not listed as to what the requirements were)
Pushes to a registry called gzub/tac at docker hub.

## Verification
This can be verified as show below:
```
gzub@Hendon-TP:~/tac/rz-sl-me$ docker run -e SLACK_SECRET=foo gzub/tac:latest
SUCCESS! A message was sent
```

## Notes
PHP 8.2 used, we can use other versions although vulnerabilities appear the same in 8.3 and 8.4
No environments were used, however likely adding environments and progressing the container through multiple envs for testing would be what I would expect for a final model.
The Dockerfile uses a multi-stage build to not put extraneous items (composer, libzip, unzip, etc) in the final build, due to inexperience with PHP, I would need to research additionaly if some of the directories that I copied to the final image were unnecessary.
The Dockerfile could likely be further optimized by using a smaller starting image and adding only those components we need.