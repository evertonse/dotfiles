# lifetime-config-files
dotfiles and +
# github
Get Token
The first step in using tokens is to generate a token from the GitHub website. Note that it would be best practice to use different tokens for different computers/systems/services/tasks so that they can be easily managed.

To generate a token:

Log into GitHub
Click on your name / Avatar in the upper right corner and select Settings
On the left, click Developer settings
Select Personal access tokens and click Generate new token
Give the token a description/name and select the scope of the token
I selected repo only to facilitate pull, push, clone, and commit actions
Click the link Red more about OAuth scopes for details about the permission sets
Click Generate token
Copy the token – this is your new password!

Configure local GIT
Once we have a token, we need to configure the local GIT client with a username and email address. On a Linux machine, use the following commands to configure this, replacing the values in the brackets with your username and email.

git config --global user.name ""
git config --global user.email ""
git config -l
Clone from GitHub
Once GIT is configured, we can begin using it to access GitHub. In this example I perform a git clone command to copy a repository to the local computer. When prompted for the username and password, enter your GitHub username and the previously generated token as the password.


Configure Credential Caching
Lastly, to ensure the local computer remembers the token, we can enable caching of the credentials. This configures the computer to remember the complex token so that we dont have too.

git config --global credential.helper cache
If needed, you can later clear the token from the local computer by running

git config --global --unset credential.helper
