# Misc notes that could be helpful

## GIT
Use `git config --local`(must be in repo) to create account just for a repo

### Two github users on same comp

Here's what my setup looks like. First, I generated two sets of keys. In ~/.ssh I have

personal_github_ed25519

personal_github_ed25519.pub

work_github_ed25519

work_github_ed25519.pub

I put the public keys in their respective places in each github account. In
~/.ssh/config I have two entries, both for github but using different names
locally with the different key files

```
Host github.com
  HostName github.com
  IdentityFile ~/.ssh/id_ed25519_mine

Host github-work
  HostName github.com
  IdentityFile ~/.ssh/id_ed25519_work
```

The line Host <host> is the important one because when you do ssh things and
refer to a host with whatever you have as <host>, it will use that entry to
determine what credentials to use. With this setup you just need to make sure
when you clone or set the remote URL, that you change it to match the right
host. If you want to clone a work repo, you will need to use
git@github-work:username/repo.git

On my personal laptop, I have it set up as shown above so the name github.com
uses my personal account. On my work computer I have it flipped so Host
github.com is associated with my work keys. This way I don't have to use the
other url too often.
