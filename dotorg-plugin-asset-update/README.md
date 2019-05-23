# WordPress.org Plugin Assets Update

This Action commits any `readme.txt` and WordPress.org-specific assets changes in your specified branch to the WordPress.org plugin repository if no other changes have been made since the last deployment to WordPress.org. This is useful for updating things like screenshots or `Tested up to` separately from functional changes, provided your Git branching methodology avoids changing anything else in the specified branch between functional releases. It is **highly recommended** that you use a stable branch where you only merge readme/asset commits in between larger functional merges that only occur when preparing for a release (often implemented as `master` vs. `develop`).

Because the WordPress.org plugin repository shows information from `readme.txt` in the specified `Stable tag`, this Action also attempts to parse out the stable tag from `readme.txt` and deploy to there as well as `trunk`. If your stable tag is `trunk` or a tag that does not exist in the `tags` subfolder, it will skip that part of the update and only update `trunk` and/or `assets`.

**Important note:** If your development process leads to a situation where `master` (or other specified branch) only contains changes to `readme.txt` or `assets` since the last sync to the plugin directory and those changes are in preparation for the next release, those changes will go live and potentially be misleading to users. Usage of this Action assumes a fairly traditional Git methodology that involves merging all changes to `master` when functional changes are ready and that this seemingly unlikely situation will therefore not happen in your repo; there are no safeguards against syncing changes based on readme/asset content, as that cannot be predicted.

## Configuration

### Required secrets
* `SVN_USERNAME`
* `SVN_PASSWORD`

Secrets can be set while editing your workflow or in the repository settings. They cannot be viewed once stored. [GitHub secrets documentation](https://developer.github.com/actions/creating-workflows/storing-secrets/)

### Optional environment variables
* `SLUG` - defaults to the respository name, customizable in case your WordPress repository has a different slug. This should be a very rare case as WordPress assumes that the directory and initial plugin file have the same slug.
* `ASSETS_DIR` - defaults to `.wordpress-org`, customizable for other locations of WordPress.org plugin repository-specific assets that belong in the top-level `assets` directory (the one on the same level as `trunk`)

## Example Workflow File
```
workflow "Plugin Asset Update" {
  resolves = ["WordPress Plugin Asset Update"]
  on = "push"
}

# Filter for master branch
action "branch" {
    uses = "actions/bin/filter@master"
    args = "branch master"
}

action "WordPress Plugin Asset Update" {
  needs = ["branch"]
  uses = "10up/actions-wordpress/dotorg-plugin-asset-update@master"
  secrets = ["SVN_USERNAME", "SVN_PASSWORD"]
}
```

## Contributing
Want to help? Check out our [contributing guidelines](../CONTRIBUTING.md) to get started.

<p align="center">
<a href="http://10up.com/contact/"><img src="https://10updotcom-wpengine.s3.amazonaws.com/uploads/2016/10/10up-Github-Banner.png" width="850"></a>
</p>

## License

Our GitHub Actions are available for use and remix under the MIT license.

