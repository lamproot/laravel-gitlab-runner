# laravel-gitlab-runner, deploying to AWS EC2 instance
We use Gitlab to deploy our Laravel projects on staging and production server.

We have setup a Gitlab runner on our dev server. So we maintain caches across the pipeline and don't make use of artifacts. Feel free to use artifacts, its the recommended way to do CIs.

The user should set enviroment variables in gitlab CI/CD in project settings.
The following are to be set.

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



