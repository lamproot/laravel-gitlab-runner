# Laravel Gitlab runner, deploying to AWS EC2 instance
We use Gitlab to deploy our Laravel projects on staging and production server.

Setup a Gitlab runner on your dev server. So that we can maintain caches across the pipeline without using artifacts. Feel free to use artifacts, its the recommended way for cloud runners.

The user should set enviroment variables in gitlab CI/CD in project settings.
The following variables and its values needs to be set.

DEPLOY_SERVERS (Should place your staging servers ip address)

DEPLOY_SERVERS_PROD (Should place your production servers ip address)

DESTINATION_DIR (Directory in which you need to copy your staging files)

DESTINATION_DIR_PROD (Directory in which you need to copy your production files)

PRIVATE_KEY (Text from your PEM file)

PRIVATE_KEY_PROD (Text from your PEM file)

SOURCE_DIR (Files and folders that need to be copied, * if you have to copy everything)

SOURCE_DIR_PROD (Files and folders that need to be copied, * if you have to copy everything)

USER_NAME (Your staging EC2 username)

USER_NAME_PROD (Your production EC2 username)