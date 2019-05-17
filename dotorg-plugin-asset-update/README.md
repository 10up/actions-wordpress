# WordPress.org Plugin Assets Update

This Action commits any `readme.txt` and WordPress.org-specific `assets` changes in your specified stable branch (typically `master`) to the WordPress.org plugin repository if no other changes have been made. This is useful for updating things like screenshots or `Tested up to` separately from functional changes provided your Git branching methodology avoids changing anything else in the specified branch between functional releases.

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

action "WordPress Plugin Update" {
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

