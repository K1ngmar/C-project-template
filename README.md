# ❤️ C project template
Are you tired of manually copying, pasting and renaming files when you start a new project? Look no further because setting up C project just became easy!

## ❓ How to easily setup your C projects?

1. Create a new repository by clicking use this template on this repository.

2. Create a [Personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) with write rights.

3. On the newly generated repository go to `settings->Secrets and variables->Actions` and create a secret called `PERSONAL_ACCESS_TOKEN`, and paste your token in the secret textbox.

4. On your repository, go to `Actions`, click on the last failed job and rerun the the failed jobs.

5. Clone your project!
```bash
# make sure you use --recurse-submodules when cloning
git clone --recurse-submodules https://github.com/you/your-repo

# or if you already cloned without --recurse-submodules
cd your-repo && git submodule init && git submodule update
```

6. Enjoy your fully setup project! It really is that easy!

## 🙋 What does it do?

- Setup your project, with custom filenames, etc.
- Protect your main branch!
- Reduce your headaches!
