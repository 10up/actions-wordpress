# GitHub Actions for WordPress!

Here is a collection of GitHub Actions to help with common needs for WordPress development. Specific documentation for each Action is in the `README.md` file in its subdirectory.

[More information about GitHub Actions](https://github.com/features/actions/)

## Ready to use
### [Deploying a plugin to the WordPress.org repository](dotorg-plugin-deploy)

Whenever you tag a new version of your plugin on GitHub, your changes will be committed to both `trunk` and the appropriate `tags` subfolder in your WordPress.org plugin repository.

### [Deploying plugin asset/readme updates to the WordPress.org repository](dotorg-plugin-asset-update)

If you push to your specified branch and it only contains changes to the WordPress.org assets directory (defaults to `/.wordpress-org`) or `readme.txt`, deploy those changes to the WordPress.org plugin repository. This is useful for being able to update things like screenshots or the `Tested up to` version in between tagged releases.

## Planned
* Building a production-ready version into a `stable` branch or other location of choice.

## Ideas
* Generate hook docs into a Markdown file that can be published into a subfolder, GitHub wiki, and/or `gh-pages` branch.

## Contributing
Want to help? Check out our [contributing guidelines](CONTRIBUTING.md) to get started.

<p align="center">
<a href="http://10up.com/contact/"><img src="https://10updotcom-wpengine.s3.amazonaws.com/uploads/2016/10/10up-Github-Banner.png" width="850"></a>
</p>

## License

Our GitHub Actions are available for use and remix under the MIT license.
